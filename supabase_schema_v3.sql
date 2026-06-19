-- ================================================================
-- COFRE v3 — Schema Definitivo e Livre de Erros
-- Compatível com: PostgreSQL 15+ / Supabase
-- Colunas 100% alinhadas com o frontend cofre_v3.html
-- ================================================================

-- ── EXTENSÕES ────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- ── ENUMS (idempotentes) ─────────────────────────────────────────
DO $$ BEGIN
  CREATE TYPE public.tx_type AS ENUM (
    'entrada','saida','pix','desp','conta'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE public.bill_recurrence AS ENUM (
    'unica','diaria','semanal','quinzenal',
    'mensal','bimestral','trimestral','semestral','anual'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE public.invest_type AS ENUM (
    'renda_fixa','acoes','fii','criptomoedas',
    'fundos','exterior','tesouro','previdencia','outro'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE public.log_action AS ENUM (
    'CREATE','UPDATE','DELETE','LOGIN','LOGOUT',
    'EXPORT','IMPORT','BACKUP','RESTORE','PAYMENT'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ================================================================
--  TABELAS
--  Ordem: profiles → user_settings → transaction_categories →
--         transactions → bills (FK bill→tx depois) → goals →
--         goal_contributions → investments → monthly_snapshots →
--         notifications → backup_snapshots → audit_logs
-- ================================================================

-- ── 1. profiles ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.profiles (
  id              UUID          PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name       TEXT,
  avatar_url      TEXT,
  salario         NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (salario >= 0),
  currency        TEXT          NOT NULL DEFAULT 'BRL',
  locale          TEXT          NOT NULL DEFAULT 'pt-BR',
  onboarding_done BOOLEAN       NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 2. user_settings ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.user_settings (
  user_id           UUID          PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  invest_acum       NUMERIC(14,2) NOT NULL DEFAULT 0,
  invest_taxa       NUMERIC(8,4)  NOT NULL DEFAULT 1,
  show_saldo_graph  BOOLEAN       NOT NULL DEFAULT FALSE,
  auto_snapshot     BOOLEAN       NOT NULL DEFAULT TRUE,
  bill_alert_days   INTEGER       NOT NULL DEFAULT 3,
  dark_mode         BOOLEAN       NOT NULL DEFAULT TRUE,
  show_cents        BOOLEAN       NOT NULL DEFAULT TRUE,
  default_tab       TEXT          NOT NULL DEFAULT 'visao',
  updated_at        TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 3. salary_history ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.salary_history (
  id             UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id        UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  salario        NUMERIC(14,2) NOT NULL CHECK (salario >= 0),
  note           TEXT,
  effective_date DATE          NOT NULL DEFAULT CURRENT_DATE,
  created_at     TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 4. transaction_categories ────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.transaction_categories (
  id           UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id      UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name         TEXT          NOT NULL CHECK (length(trim(name)) > 0),
  emoji        TEXT          NOT NULL DEFAULT '📁',
  color        TEXT          NOT NULL DEFAULT '#6366f1',
  pct          NUMERIC(5,2)  NOT NULL DEFAULT 0 CHECK (pct >= 0 AND pct <= 100),
  manual_value NUMERIC(14,2),
  usa_manual   BOOLEAN       NOT NULL DEFAULT FALSE,
  sort_order   INTEGER       NOT NULL DEFAULT 0,
  archived     BOOLEAN       NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 5. transactions ──────────────────────────────────────────────
--  Colunas alinhadas com o frontend:
--    name, amount, type (tx_type), notes, transaction_date
CREATE TABLE IF NOT EXISTS public.transactions (
  id               UUID             NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id          UUID             NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id      UUID             REFERENCES public.transaction_categories(id) ON DELETE SET NULL,
  bill_id          UUID,            -- FK adicionada depois de criar bills
  name             TEXT             NOT NULL CHECK (length(trim(name)) > 0),
  amount           NUMERIC(14,2)    NOT NULL CHECK (amount > 0),
  type             TEXT             NOT NULL DEFAULT 'saida',
  transaction_date DATE             NOT NULL DEFAULT CURRENT_DATE,
  notes            TEXT,
  tags             TEXT[]           NOT NULL DEFAULT '{}',
  is_recurring     BOOLEAN          NOT NULL DEFAULT FALSE,
  attachment_url   TEXT,
  created_at       TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ      NOT NULL DEFAULT NOW()
);

-- ── 6. bills ─────────────────────────────────────────────────────
--  Colunas alinhadas com o frontend:
--    name, amount, due_day, category, recurrence, is_paid, paid_at
CREATE TABLE IF NOT EXISTS public.bills (
  id          UUID                   NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID                   NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id UUID                   REFERENCES public.transaction_categories(id) ON DELETE SET NULL,
  name        TEXT                   NOT NULL CHECK (length(trim(name)) > 0),
  amount      NUMERIC(14,2)          NOT NULL CHECK (amount > 0),
  due_day     INTEGER                NOT NULL DEFAULT 1 CHECK (due_day BETWEEN 1 AND 31),
  category    TEXT                   NOT NULL DEFAULT 'outro',
  recurrence  public.bill_recurrence NOT NULL DEFAULT 'mensal',
  is_paid     BOOLEAN                NOT NULL DEFAULT FALSE,
  paid_at     TIMESTAMPTZ,
  paid_tx_id  UUID,                  -- FK adicionada depois
  auto_pay    BOOLEAN                NOT NULL DEFAULT FALSE,
  notes       TEXT,
  remind_days INTEGER                NOT NULL DEFAULT 3,
  archived    BOOLEAN                NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMPTZ            NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ            NOT NULL DEFAULT NOW()
);

-- FK bills.paid_tx_id → transactions (idempotente)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'fk_bills_paid_tx'
      AND conrelid = 'public.bills'::regclass
  ) THEN
    ALTER TABLE public.bills
      ADD CONSTRAINT fk_bills_paid_tx
      FOREIGN KEY (paid_tx_id) REFERENCES public.transactions(id) ON DELETE SET NULL;
  END IF;
END $$;

-- FK transactions.bill_id → bills (idempotente)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'fk_transactions_bill'
      AND conrelid = 'public.transactions'::regclass
  ) THEN
    ALTER TABLE public.transactions
      ADD CONSTRAINT fk_transactions_bill
      FOREIGN KEY (bill_id) REFERENCES public.bills(id) ON DELETE SET NULL;
  END IF;
END $$;

-- ── 7. goals ─────────────────────────────────────────────────────
--  Colunas alinhadas com o frontend:
--    name, emoji, target_amount, current_amount, deadline_months, is_completed
CREATE TABLE IF NOT EXISTS public.goals (
  id              UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT          NOT NULL CHECK (length(trim(name)) > 0),
  emoji           TEXT          NOT NULL DEFAULT '🎯',
  target_amount   NUMERIC(14,2) NOT NULL CHECK (target_amount > 0),
  current_amount  NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (current_amount >= 0),
  deadline_months INTEGER       NOT NULL DEFAULT 12,
  is_completed    BOOLEAN       NOT NULL DEFAULT FALSE,
  completed_at    TIMESTAMPTZ,
  color           TEXT          NOT NULL DEFAULT '#6366f1',
  notes           TEXT,
  archived        BOOLEAN       NOT NULL DEFAULT FALSE,
  sort_order      INTEGER       NOT NULL DEFAULT 0,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 8. goal_contributions ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.goal_contributions (
  id         UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  goal_id    UUID          NOT NULL REFERENCES public.goals(id) ON DELETE CASCADE,
  user_id    UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  amount     NUMERIC(14,2) NOT NULL CHECK (amount != 0),
  note       TEXT,
  date       DATE          NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 9. investments ───────────────────────────────────────────────
--  Colunas alinhadas com o frontend:
--    name, type, institution, total_invested, current_value, monthly_rate, notes, is_active, sort_order
CREATE TABLE IF NOT EXISTS public.investments (
  id             UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id        UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name           TEXT          NOT NULL CHECK (length(trim(name)) > 0),
  type           TEXT          NOT NULL DEFAULT 'outro',
  institution    TEXT          NOT NULL DEFAULT '',
  total_invested NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (total_invested >= 0),
  current_value  NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (current_value >= 0),
  monthly_rate   NUMERIC(8,4)  NOT NULL DEFAULT 0,
  ticker         TEXT,
  broker         TEXT,
  notes          TEXT,
  is_active      BOOLEAN       NOT NULL DEFAULT TRUE,
  color          TEXT          NOT NULL DEFAULT '#10b981',
  sort_order     INTEGER       NOT NULL DEFAULT 0,
  archived       BOOLEAN       NOT NULL DEFAULT FALSE,
  created_at     TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 10. monthly_snapshots ────────────────────────────────────────
--  Colunas alinhadas com o frontend:
--    title, salario, saldo_livre, total_cats, total_tx_saidas,
--    total_tx_entradas, total_bills_pago, payload
CREATE TABLE IF NOT EXISTS public.monthly_snapshots (
  id                  UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id             UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title               TEXT          NOT NULL,
  salario             NUMERIC(14,2) NOT NULL DEFAULT 0,
  saldo_livre         NUMERIC(14,2) NOT NULL DEFAULT 0,
  total_cats          NUMERIC(14,2) NOT NULL DEFAULT 0,
  total_tx_saidas     NUMERIC(14,2) NOT NULL DEFAULT 0,
  total_tx_entradas   NUMERIC(14,2) NOT NULL DEFAULT 0,
  total_bills_pago    NUMERIC(14,2) NOT NULL DEFAULT 0,
  invest_total        NUMERIC(14,2) NOT NULL DEFAULT 0,
  payload             JSONB,
  snapshot_date       DATE          NOT NULL DEFAULT CURRENT_DATE,
  created_at          TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ── 11. notifications ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.notifications (
  id          UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type        TEXT        NOT NULL DEFAULT 'info',
  title       TEXT        NOT NULL,
  body        TEXT        NOT NULL DEFAULT '',
  entity_type TEXT,
  entity_id   UUID,
  read        BOOLEAN     NOT NULL DEFAULT FALSE,
  read_at     TIMESTAMPTZ,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── 12. backup_snapshots ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.backup_snapshots (
  id          UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  label       TEXT        NOT NULL DEFAULT 'Backup Manual',
  backup_type TEXT        NOT NULL DEFAULT 'manual'
              CHECK (backup_type IN ('manual','auto','pre_reset')),
  data_json   JSONB       NOT NULL,
  byte_size   INTEGER,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── 13. audit_logs ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id         UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id    UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  table_name TEXT        NOT NULL,
  record_id  UUID        NOT NULL,
  operation  TEXT        NOT NULL CHECK (operation IN ('INSERT','UPDATE','DELETE')),
  old_data   JSONB,
  new_data   JSONB,
  changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── 14. activity_logs ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.activity_logs (
  id          UUID               NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID               NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  action      public.log_action  NOT NULL,
  entity_type TEXT,
  entity_id   UUID,
  description TEXT               NOT NULL DEFAULT '',
  metadata    JSONB,
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT NOW()
);

-- ================================================================
--  ÍNDICES
-- ================================================================

CREATE INDEX IF NOT EXISTS idx_tx_user_date   ON public.transactions(user_id, transaction_date DESC);
CREATE INDEX IF NOT EXISTS idx_tx_category    ON public.transactions(category_id);
CREATE INDEX IF NOT EXISTS idx_tx_bill        ON public.transactions(bill_id);
CREATE INDEX IF NOT EXISTS idx_tx_tags        ON public.transactions USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_tx_name_trgm   ON public.transactions USING GIN(name gin_trgm_ops);

CREATE INDEX IF NOT EXISTS idx_bills_user     ON public.bills(user_id, is_paid);
CREATE INDEX IF NOT EXISTS idx_bills_due      ON public.bills(user_id, due_day);

CREATE INDEX IF NOT EXISTS idx_goals_user     ON public.goals(user_id, sort_order);
CREATE INDEX IF NOT EXISTS idx_gc_goal        ON public.goal_contributions(goal_id);

CREATE INDEX IF NOT EXISTS idx_inv_user       ON public.investments(user_id, sort_order);

CREATE INDEX IF NOT EXISTS idx_cats_user      ON public.transaction_categories(user_id, sort_order);

CREATE INDEX IF NOT EXISTS idx_snap_user      ON public.monthly_snapshots(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_notif_user     ON public.notifications(user_id, read, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_backup_user    ON public.backup_snapshots(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_audit_tbl      ON public.audit_logs(table_name, record_id);

-- ================================================================
--  FUNÇÕES
-- ================================================================

-- updated_at automático
CREATE OR REPLACE FUNCTION public.fn_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- Cria perfil + settings ao registrar novo usuário
CREATE OR REPLACE FUNCTION public.fn_handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1))
  )
  ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.user_settings (user_id)
  VALUES (NEW.id)
  ON CONFLICT (user_id) DO NOTHING;

  RETURN NEW;
END;
$$;

-- Registra histórico ao alterar salário
CREATE OR REPLACE FUNCTION public.fn_salary_history()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NEW.salario IS DISTINCT FROM OLD.salario THEN
    INSERT INTO public.salary_history (user_id, salario)
    VALUES (NEW.id, NEW.salario);
  END IF;
  RETURN NEW;
END;
$$;

-- Atualiza current_amount nas metas
CREATE OR REPLACE FUNCTION public.fn_goal_contribution()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_current NUMERIC(14,2);
  v_target  NUMERIC(14,2);
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT current_amount, target_amount INTO v_current, v_target
    FROM public.goals WHERE id = NEW.goal_id;

    UPDATE public.goals SET
      current_amount = v_current + NEW.amount,
      is_completed   = (v_current + NEW.amount) >= v_target,
      completed_at   = CASE
                         WHEN (v_current + NEW.amount) >= v_target AND NOT is_completed
                         THEN NOW() ELSE completed_at
                       END,
      updated_at = NOW()
    WHERE id = NEW.goal_id;

  ELSIF TG_OP = 'DELETE' THEN
    SELECT current_amount, target_amount INTO v_current, v_target
    FROM public.goals WHERE id = OLD.goal_id;

    UPDATE public.goals SET
      current_amount = GREATEST(0, v_current - OLD.amount),
      is_completed   = GREATEST(0, v_current - OLD.amount) >= v_target,
      updated_at = NOW()
    WHERE id = OLD.goal_id;
  END IF;

  RETURN NULL;
END;
$$;

-- Audit log genérico
CREATE OR REPLACE FUNCTION public.fn_audit_log()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_uid UUID;
  v_id  UUID;
BEGIN
  IF TG_OP = 'DELETE' THEN
    v_uid := OLD.user_id; v_id := OLD.id;
  ELSE
    v_uid := NEW.user_id; v_id := NEW.id;
  END IF;

  INSERT INTO public.audit_logs (
    user_id, table_name, record_id, operation, old_data, new_data
  ) VALUES (
    COALESCE(v_uid, auth.uid()),
    TG_TABLE_NAME, v_id, TG_OP,
    CASE WHEN TG_OP <> 'INSERT' THEN to_jsonb(OLD) ELSE NULL END,
    CASE WHEN TG_OP <> 'DELETE' THEN to_jsonb(NEW) ELSE NULL END
  );

  RETURN NULL;
END;
$$;

-- Paga conta: cria transação + marca paga + gera próxima parcela
CREATE OR REPLACE FUNCTION public.fn_pay_bill(
  p_bill_id   UUID,
  p_user_id   UUID,
  p_paid_date DATE DEFAULT CURRENT_DATE
)
RETURNS UUID LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_bill  public.bills%ROWTYPE;
  v_tx_id UUID;
BEGIN
  SELECT * INTO v_bill
  FROM public.bills
  WHERE id = p_bill_id AND user_id = p_user_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Conta não encontrada ou sem permissão';
  END IF;

  INSERT INTO public.transactions (
    user_id, bill_id, type, name, amount, transaction_date
  ) VALUES (
    p_user_id, p_bill_id, 'conta',
    'Pagamento: ' || v_bill.name,
    v_bill.amount, p_paid_date
  ) RETURNING id INTO v_tx_id;

  UPDATE public.bills SET
    is_paid    = TRUE,
    paid_at    = NOW(),
    paid_tx_id = v_tx_id,
    updated_at = NOW()
  WHERE id = p_bill_id;

  IF v_bill.recurrence <> 'unica' THEN
    INSERT INTO public.bills (
      user_id, category_id, name, amount, due_day,
      category, recurrence, remind_days, notes
    ) VALUES (
      p_user_id, v_bill.category_id, v_bill.name, v_bill.amount,
      v_bill.due_day, v_bill.category, v_bill.recurrence,
      v_bill.remind_days, v_bill.notes
    );
  END IF;

  RETURN v_tx_id;
END;
$$;

-- ================================================================
--  VIEWS (sem JOIN em profiles para evitar erros de coluna)
-- ================================================================

-- Resumo mensal
CREATE OR REPLACE VIEW public.vw_monthly_summary AS
SELECT
  user_id,
  DATE_TRUNC('month', transaction_date)::DATE                                     AS month,
  SUM(CASE WHEN type = 'entrada'           THEN amount ELSE 0 END)               AS total_entrada,
  SUM(CASE WHEN type IN ('saida','pix','desp','conta') THEN amount ELSE 0 END)   AS total_saida,
  SUM(CASE WHEN type = 'entrada'           THEN amount ELSE 0 END)
  - SUM(CASE WHEN type IN ('saida','pix','desp','conta') THEN amount ELSE 0 END) AS saldo,
  COUNT(*)                                                                         AS total_txs
FROM public.transactions
GROUP BY user_id, DATE_TRUNC('month', transaction_date);

-- Contas pendentes nos próximos 7 dias (sem JOIN — seguro contra schema v1)
CREATE OR REPLACE VIEW public.vw_bills_due_soon AS
SELECT
  b.id,
  b.user_id,
  b.name,
  b.amount,
  b.due_day,
  b.category,
  b.recurrence,
  b.is_paid,
  b.notes,
  b.remind_days
FROM public.bills b
WHERE b.is_paid   = FALSE
  AND b.archived  = FALSE
  AND b.due_day   BETWEEN EXTRACT(DAY FROM CURRENT_DATE)
                       AND EXTRACT(DAY FROM CURRENT_DATE) + 7;

-- Patrimônio de investimentos
CREATE OR REPLACE VIEW public.vw_patrimonio AS
SELECT
  user_id,
  SUM(current_value)                         AS valor_atual_total,
  SUM(total_invested)                        AS total_aportado,
  SUM(current_value - total_invested)        AS lucro_total,
  CASE WHEN SUM(total_invested) > 0
    THEN ROUND(
      (SUM(current_value) - SUM(total_invested))
      / SUM(total_invested) * 100, 2
    )
    ELSE 0
  END                                        AS rentabilidade_pct
FROM public.investments
WHERE archived = FALSE
GROUP BY user_id;

-- ================================================================
--  TRIGGERS
-- ================================================================

DO $$
DECLARE tbl TEXT;
BEGIN
  FOREACH tbl IN ARRAY ARRAY[
    'profiles','user_settings','transaction_categories',
    'transactions','bills','goals','investments',
    'monthly_snapshots'
  ] LOOP
    EXECUTE format(
      'DROP TRIGGER IF EXISTS trg_upd_%1$I ON public.%1$I;
       CREATE TRIGGER trg_upd_%1$I
         BEFORE UPDATE ON public.%1$I
         FOR EACH ROW EXECUTE FUNCTION public.fn_updated_at();',
      tbl
    );
  END LOOP;
END $$;

DROP TRIGGER IF EXISTS trg_new_user ON auth.users;
CREATE TRIGGER trg_new_user
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.fn_handle_new_user();

DROP TRIGGER IF EXISTS trg_salary_hist ON public.profiles;
CREATE TRIGGER trg_salary_hist
  AFTER UPDATE OF salario ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.fn_salary_history();

DROP TRIGGER IF EXISTS trg_goal_contrib_ins ON public.goal_contributions;
CREATE TRIGGER trg_goal_contrib_ins
  AFTER INSERT ON public.goal_contributions
  FOR EACH ROW EXECUTE FUNCTION public.fn_goal_contribution();

DROP TRIGGER IF EXISTS trg_goal_contrib_del ON public.goal_contributions;
CREATE TRIGGER trg_goal_contrib_del
  AFTER DELETE ON public.goal_contributions
  FOR EACH ROW EXECUTE FUNCTION public.fn_goal_contribution();

DROP TRIGGER IF EXISTS trg_audit_tx ON public.transactions;
CREATE TRIGGER trg_audit_tx
  AFTER INSERT OR UPDATE OR DELETE ON public.transactions
  FOR EACH ROW EXECUTE FUNCTION public.fn_audit_log();

DROP TRIGGER IF EXISTS trg_audit_bills ON public.bills;
CREATE TRIGGER trg_audit_bills
  AFTER INSERT OR UPDATE OR DELETE ON public.bills
  FOR EACH ROW EXECUTE FUNCTION public.fn_audit_log();

-- ================================================================
--  ROW LEVEL SECURITY
-- ================================================================

DO $$
DECLARE tbl TEXT;
BEGIN
  FOREACH tbl IN ARRAY ARRAY[
    'profiles','user_settings','salary_history',
    'transaction_categories','transactions','bills',
    'goals','goal_contributions','investments',
    'monthly_snapshots','notifications',
    'backup_snapshots','audit_logs','activity_logs'
  ] LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', tbl);
  END LOOP;
END $$;

-- Políticas para tabelas com user_id
DO $$
DECLARE tbl TEXT;
BEGIN
  FOREACH tbl IN ARRAY ARRAY[
    'user_settings','salary_history',
    'transaction_categories','transactions','bills',
    'goals','goal_contributions','investments',
    'monthly_snapshots','notifications',
    'backup_snapshots','audit_logs','activity_logs'
  ] LOOP
    EXECUTE format(
      'DROP POLICY IF EXISTS pol_%1$I_sel ON public.%1$I;
       CREATE POLICY pol_%1$I_sel ON public.%1$I
         FOR SELECT USING (user_id = auth.uid());

       DROP POLICY IF EXISTS pol_%1$I_ins ON public.%1$I;
       CREATE POLICY pol_%1$I_ins ON public.%1$I
         FOR INSERT WITH CHECK (user_id = auth.uid());

       DROP POLICY IF EXISTS pol_%1$I_upd ON public.%1$I;
       CREATE POLICY pol_%1$I_upd ON public.%1$I
         FOR UPDATE USING (user_id = auth.uid());

       DROP POLICY IF EXISTS pol_%1$I_del ON public.%1$I;
       CREATE POLICY pol_%1$I_del ON public.%1$I
         FOR DELETE USING (user_id = auth.uid());',
      tbl
    );
  END LOOP;
END $$;

-- profiles: PK = id
DROP POLICY IF EXISTS pol_profiles_sel ON public.profiles;
CREATE POLICY pol_profiles_sel ON public.profiles
  FOR SELECT USING (id = auth.uid());
DROP POLICY IF EXISTS pol_profiles_ins ON public.profiles;
CREATE POLICY pol_profiles_ins ON public.profiles
  FOR INSERT WITH CHECK (id = auth.uid());
DROP POLICY IF EXISTS pol_profiles_upd ON public.profiles;
CREATE POLICY pol_profiles_upd ON public.profiles
  FOR UPDATE USING (id = auth.uid());
DROP POLICY IF EXISTS pol_profiles_del ON public.profiles;
CREATE POLICY pol_profiles_del ON public.profiles
  FOR DELETE USING (id = auth.uid());

-- ================================================================
--  MIGRAÇÃO SEGURA — adiciona colunas sem quebrar dados existentes
-- ================================================================

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS full_name       TEXT,
  ADD COLUMN IF NOT EXISTS avatar_url      TEXT,
  ADD COLUMN IF NOT EXISTS salario         NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS currency        TEXT NOT NULL DEFAULT 'BRL',
  ADD COLUMN IF NOT EXISTS locale          TEXT NOT NULL DEFAULT 'pt-BR',
  ADD COLUMN IF NOT EXISTS onboarding_done BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE public.user_settings
  ADD COLUMN IF NOT EXISTS invest_acum      NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS invest_taxa      NUMERIC(8,4)  NOT NULL DEFAULT 1,
  ADD COLUMN IF NOT EXISTS show_saldo_graph BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS auto_snapshot    BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS bill_alert_days  INTEGER NOT NULL DEFAULT 3,
  ADD COLUMN IF NOT EXISTS dark_mode        BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS show_cents       BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS default_tab      TEXT    NOT NULL DEFAULT 'visao';

ALTER TABLE public.transaction_categories
  ADD COLUMN IF NOT EXISTS color       TEXT    NOT NULL DEFAULT '#6366f1',
  ADD COLUMN IF NOT EXISTS manual_value NUMERIC(14,2),
  ADD COLUMN IF NOT EXISTS usa_manual  BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS sort_order  INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS archived    BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE public.transactions
  ADD COLUMN IF NOT EXISTS name             TEXT,
  ADD COLUMN IF NOT EXISTS transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
  ADD COLUMN IF NOT EXISTS notes            TEXT,
  ADD COLUMN IF NOT EXISTS tags             TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS is_recurring     BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS attachment_url   TEXT;

ALTER TABLE public.bills
  ADD COLUMN IF NOT EXISTS due_day     INTEGER NOT NULL DEFAULT 1,
  ADD COLUMN IF NOT EXISTS category    TEXT    NOT NULL DEFAULT 'outro',
  ADD COLUMN IF NOT EXISTS is_paid     BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS paid_at     TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS auto_pay    BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS remind_days INTEGER NOT NULL DEFAULT 3,
  ADD COLUMN IF NOT EXISTS archived    BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE public.goals
  ADD COLUMN IF NOT EXISTS deadline_months INTEGER NOT NULL DEFAULT 12,
  ADD COLUMN IF NOT EXISTS is_completed    BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS completed_at    TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS color           TEXT    NOT NULL DEFAULT '#6366f1',
  ADD COLUMN IF NOT EXISTS notes           TEXT,
  ADD COLUMN IF NOT EXISTS archived        BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS sort_order      INTEGER NOT NULL DEFAULT 0;

ALTER TABLE public.investments
  ADD COLUMN IF NOT EXISTS institution   TEXT    NOT NULL DEFAULT '',
  ADD COLUMN IF NOT EXISTS total_invested NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS current_value  NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS monthly_rate   NUMERIC(8,4)  NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS ticker         TEXT,
  ADD COLUMN IF NOT EXISTS broker         TEXT,
  ADD COLUMN IF NOT EXISTS is_active      BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS color          TEXT    NOT NULL DEFAULT '#10b981',
  ADD COLUMN IF NOT EXISTS sort_order     INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS archived       BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE public.monthly_snapshots
  ADD COLUMN IF NOT EXISTS saldo_livre       NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS total_cats        NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS total_tx_saidas   NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS total_tx_entradas NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS total_bills_pago  NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS invest_total      NUMERIC(14,2) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS payload           JSONB,
  ADD COLUMN IF NOT EXISTS snapshot_date     DATE NOT NULL DEFAULT CURRENT_DATE;

-- ================================================================
--  REALTIME (tolerante a tabelas já na publicação)
-- ================================================================

DO $$
DECLARE tbl TEXT;
BEGIN
  FOREACH tbl IN ARRAY ARRAY[
    'transactions','bills','goals','goal_contributions',
    'investments','transaction_categories','monthly_snapshots',
    'notifications','profiles'
  ] LOOP
    BEGIN
      EXECUTE format('ALTER PUBLICATION supabase_realtime ADD TABLE public.%I;', tbl);
    EXCEPTION WHEN others THEN
      NULL;
    END;
  END LOOP;
END $$;

-- ================================================================
--  FIM — Cofre v3 Schema Definitivo
-- ================================================================
