-- ============================================================
-- COFRE v3 — Schema Completo e Robusto
-- Execute no SQL Editor do Supabase (Run)
-- Compatível com fresh install e migração do v2.
-- ============================================================

-- ─── EXTENSÕES ───────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- full-text search

-- ─── TIPOS CUSTOMIZADOS ───────────────────────────────────────
DO $$ BEGIN
  CREATE TYPE tx_type AS ENUM ('entrada','saida','transferencia','pix','investimento');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE bill_recurrence AS ENUM ('unica','diaria','semanal','quinzenal','mensal','bimestral','trimestral','semestral','anual');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE goal_type AS ENUM ('economia','investimento','compra','viagem','emergencia','aposentadoria','personalizado');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE invest_type AS ENUM ('renda_fixa','acoes','fii','criptomoedas','fundos','exterior','tesouro','previdencia','outro');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE log_action AS ENUM ('CREATE','UPDATE','DELETE','LOGIN','LOGOUT','EXPORT','IMPORT','BACKUP','RESTORE','PAYMENT');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ═══════════════════════════════════════════════════════════════
--  TABELAS
-- ═══════════════════════════════════════════════════════════════

-- ─── profiles ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.profiles (
  id              UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name       TEXT,
  avatar_url      TEXT,
  phone           TEXT,
  salario         NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (salario >= 0),
  currency        TEXT NOT NULL DEFAULT 'BRL',
  locale          TEXT NOT NULL DEFAULT 'pt-BR',
  timezone        TEXT NOT NULL DEFAULT 'America/Sao_Paulo',
  onboarding_done BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── user_settings ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.user_settings (
  user_id                 UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  show_saldo_graph        BOOLEAN NOT NULL DEFAULT FALSE,
  auto_snapshot           BOOLEAN NOT NULL DEFAULT TRUE,
  bill_alert_days         INTEGER NOT NULL DEFAULT 3,
  invest_acum             NUMERIC(14,2) NOT NULL DEFAULT 0,
  invest_taxa             NUMERIC(8,4)  NOT NULL DEFAULT 1,
  dark_mode               BOOLEAN NOT NULL DEFAULT TRUE,
  compact_view            BOOLEAN NOT NULL DEFAULT FALSE,
  show_cents              BOOLEAN NOT NULL DEFAULT TRUE,
  default_tab             TEXT NOT NULL DEFAULT 'visao',
  notification_email      BOOLEAN NOT NULL DEFAULT TRUE,
  notification_push       BOOLEAN NOT NULL DEFAULT FALSE,
  budget_alert_pct        INTEGER NOT NULL DEFAULT 80,
  updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── salary_history ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.salary_history (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  salario         NUMERIC(14,2) NOT NULL CHECK (salario >= 0),
  note            TEXT,
  effective_date  DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── transaction_categories ──────────────────────────────────
CREATE TABLE IF NOT EXISTS public.transaction_categories (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  emoji           TEXT NOT NULL DEFAULT '📁',
  color           TEXT NOT NULL DEFAULT '#6366f1',
  pct             NUMERIC(5,2) NOT NULL DEFAULT 0 CHECK (pct >= 0 AND pct <= 100),
  valor_manual    NUMERIC(14,2),
  usa_manual      BOOLEAN NOT NULL DEFAULT FALSE,
  sort_order      INTEGER NOT NULL DEFAULT 0,
  is_system       BOOLEAN NOT NULL DEFAULT FALSE,
  archived        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── transactions ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.transactions (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id     UUID REFERENCES public.transaction_categories(id) ON DELETE SET NULL,
  bill_id         UUID,  -- FK adicionada após criar bills
  type            tx_type NOT NULL DEFAULT 'saida',
  description     TEXT NOT NULL CHECK (length(trim(description)) > 0),
  amount          NUMERIC(14,2) NOT NULL CHECK (amount > 0),
  date            DATE NOT NULL DEFAULT CURRENT_DATE,
  notes           TEXT,
  tags            TEXT[] DEFAULT '{}',
  is_recurring    BOOLEAN NOT NULL DEFAULT FALSE,
  recurring_id    UUID,
  attachment_url  TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── bills ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.bills (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id     UUID REFERENCES public.transaction_categories(id) ON DELETE SET NULL,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  amount          NUMERIC(14,2) NOT NULL CHECK (amount > 0),
  due_date        DATE NOT NULL,
  recurrence      bill_recurrence NOT NULL DEFAULT 'mensal',
  paid            BOOLEAN NOT NULL DEFAULT FALSE,
  paid_at         TIMESTAMPTZ,
  paid_tx_id      UUID REFERENCES public.transactions(id) ON DELETE SET NULL,
  auto_pay        BOOLEAN NOT NULL DEFAULT FALSE,
  notes           TEXT,
  tags            TEXT[] DEFAULT '{}',
  remind_days     INTEGER NOT NULL DEFAULT 3,
  archived        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Agora adiciona FK de transactions.bill_id → bills.id
ALTER TABLE public.transactions
  ADD CONSTRAINT IF NOT EXISTS fk_transactions_bill
  FOREIGN KEY (bill_id) REFERENCES public.bills(id) ON DELETE SET NULL;

-- ─── goals ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.goals (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  emoji           TEXT NOT NULL DEFAULT '🎯',
  type            goal_type NOT NULL DEFAULT 'personalizado',
  target_amount   NUMERIC(14,2) NOT NULL CHECK (target_amount > 0),
  current_amount  NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (current_amount >= 0),
  target_date     DATE,
  monthly_contrib NUMERIC(14,2),
  color           TEXT NOT NULL DEFAULT '#6366f1',
  notes           TEXT,
  completed       BOOLEAN NOT NULL DEFAULT FALSE,
  completed_at    TIMESTAMPTZ,
  archived        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── goal_contributions ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.goal_contributions (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  goal_id         UUID NOT NULL REFERENCES public.goals(id) ON DELETE CASCADE,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  amount          NUMERIC(14,2) NOT NULL CHECK (amount != 0),
  note            TEXT,
  date            DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── investments ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.investments (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  type            invest_type NOT NULL DEFAULT 'outro',
  ticker          TEXT,
  invested_amount NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (invested_amount >= 0),
  current_value   NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (current_value >= 0),
  quantity        NUMERIC(18,8),
  avg_price       NUMERIC(14,4),
  broker          TEXT,
  notes           TEXT,
  color           TEXT NOT NULL DEFAULT '#10b981',
  archived        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── investment_history ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.investment_history (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  investment_id   UUID NOT NULL REFERENCES public.investments(id) ON DELETE CASCADE,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  operation       TEXT NOT NULL CHECK (operation IN ('aporte','resgate','atualizacao')),
  amount          NUMERIC(14,2) NOT NULL CHECK (amount > 0),
  quantity        NUMERIC(18,8),
  price           NUMERIC(14,4),
  date            DATE NOT NULL DEFAULT CURRENT_DATE,
  note            TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── budgets ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.budgets (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  period_start    DATE NOT NULL,
  period_end      DATE NOT NULL,
  total_limit     NUMERIC(14,2) NOT NULL CHECK (total_limit > 0),
  notes           TEXT,
  active          BOOLEAN NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT chk_budget_period CHECK (period_end > period_start)
);

-- ─── budget_items ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.budget_items (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  budget_id       UUID NOT NULL REFERENCES public.budgets(id) ON DELETE CASCADE,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id     UUID REFERENCES public.transaction_categories(id) ON DELETE SET NULL,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  limit_amount    NUMERIC(14,2) NOT NULL CHECK (limit_amount >= 0),
  spent_amount    NUMERIC(14,2) NOT NULL DEFAULT 0 CHECK (spent_amount >= 0),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── notes ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.notes (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title           TEXT NOT NULL DEFAULT 'Nota',
  content         TEXT NOT NULL DEFAULT '',
  color           TEXT NOT NULL DEFAULT '#fbbf24',
  pinned          BOOLEAN NOT NULL DEFAULT FALSE,
  archived        BOOLEAN NOT NULL DEFAULT FALSE,
  tags            TEXT[] DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── tags ─────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.tags (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name            TEXT NOT NULL CHECK (length(trim(name)) > 0),
  color           TEXT NOT NULL DEFAULT '#6366f1',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, name)
);

-- ─── recurring_transactions ───────────────────────────────────
CREATE TABLE IF NOT EXISTS public.recurring_transactions (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category_id     UUID REFERENCES public.transaction_categories(id) ON DELETE SET NULL,
  type            tx_type NOT NULL DEFAULT 'saida',
  description     TEXT NOT NULL CHECK (length(trim(description)) > 0),
  amount          NUMERIC(14,2) NOT NULL CHECK (amount > 0),
  recurrence      bill_recurrence NOT NULL DEFAULT 'mensal',
  start_date      DATE NOT NULL DEFAULT CURRENT_DATE,
  end_date        DATE,
  next_date       DATE NOT NULL,
  last_generated  DATE,
  active          BOOLEAN NOT NULL DEFAULT TRUE,
  notes           TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── recurring_bills ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.recurring_bills (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  bill_id         UUID NOT NULL REFERENCES public.bills(id) ON DELETE CASCADE,
  original_due    DATE NOT NULL,
  generated_due   DATE NOT NULL,
  generated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(bill_id, generated_due)
);

-- ─── monthly_snapshots ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.monthly_snapshots (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title           TEXT NOT NULL,
  salario         NUMERIC(14,2) NOT NULL DEFAULT 0,
  total_entrada   NUMERIC(14,2) NOT NULL DEFAULT 0,
  total_saida     NUMERIC(14,2) NOT NULL DEFAULT 0,
  saldo           NUMERIC(14,2) NOT NULL DEFAULT 0,
  contas_pagas    INTEGER NOT NULL DEFAULT 0,
  contas_total    INTEGER NOT NULL DEFAULT 0,
  metas_ativas    INTEGER NOT NULL DEFAULT 0,
  invest_total    NUMERIC(14,2) NOT NULL DEFAULT 0,
  snapshot_date   DATE NOT NULL DEFAULT CURRENT_DATE,
  data_json       JSONB,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, snapshot_date)
);

-- ─── financial_history ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.financial_history (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  event_type      TEXT NOT NULL,
  entity_type     TEXT NOT NULL,
  entity_id       UUID,
  description     TEXT NOT NULL,
  old_value       JSONB,
  new_value       JSONB,
  amount          NUMERIC(14,2),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── attachments ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.attachments (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  entity_type     TEXT NOT NULL CHECK (entity_type IN ('transaction','bill','goal','note','investment')),
  entity_id       UUID NOT NULL,
  file_name       TEXT NOT NULL,
  file_url        TEXT NOT NULL,
  file_size       INTEGER,
  mime_type       TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── notifications ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.notifications (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type            TEXT NOT NULL,
  title           TEXT NOT NULL,
  body            TEXT NOT NULL,
  entity_type     TEXT,
  entity_id       UUID,
  read            BOOLEAN NOT NULL DEFAULT FALSE,
  read_at         TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── activity_logs ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.activity_logs (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  action          log_action NOT NULL,
  entity_type     TEXT,
  entity_id       UUID,
  description     TEXT NOT NULL,
  metadata        JSONB,
  ip_address      INET,
  user_agent      TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── audit_logs ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  table_name      TEXT NOT NULL,
  record_id       UUID NOT NULL,
  operation       TEXT NOT NULL CHECK (operation IN ('INSERT','UPDATE','DELETE')),
  old_data        JSONB,
  new_data        JSONB,
  changed_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── backup_snapshots ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.backup_snapshots (
  id              UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id         UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  label           TEXT NOT NULL DEFAULT 'Backup Manual',
  backup_type     TEXT NOT NULL DEFAULT 'manual' CHECK (backup_type IN ('manual','auto','pre_reset')),
  data_json       JSONB NOT NULL,
  byte_size       INTEGER,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ═══════════════════════════════════════════════════════════════
--  ÍNDICES
-- ═══════════════════════════════════════════════════════════════

-- transactions
CREATE INDEX IF NOT EXISTS idx_tx_user_date   ON public.transactions(user_id, date DESC);
CREATE INDEX IF NOT EXISTS idx_tx_user_type   ON public.transactions(user_id, type);
CREATE INDEX IF NOT EXISTS idx_tx_category    ON public.transactions(category_id);
CREATE INDEX IF NOT EXISTS idx_tx_bill        ON public.transactions(bill_id);
CREATE INDEX IF NOT EXISTS idx_tx_tags        ON public.transactions USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_tx_desc_trgm   ON public.transactions USING GIN(description gin_trgm_ops);

-- bills
CREATE INDEX IF NOT EXISTS idx_bills_user     ON public.bills(user_id, due_date);
CREATE INDEX IF NOT EXISTS idx_bills_paid     ON public.bills(user_id, paid);

-- goals
CREATE INDEX IF NOT EXISTS idx_goals_user     ON public.goals(user_id);
CREATE INDEX IF NOT EXISTS idx_gc_goal        ON public.goal_contributions(goal_id);
CREATE INDEX IF NOT EXISTS idx_gc_user        ON public.goal_contributions(user_id);

-- investments
CREATE INDEX IF NOT EXISTS idx_inv_user       ON public.investments(user_id);
CREATE INDEX IF NOT EXISTS idx_invh_inv       ON public.investment_history(investment_id);

-- categories
CREATE INDEX IF NOT EXISTS idx_cats_user      ON public.transaction_categories(user_id, sort_order);

-- history / logs
CREATE INDEX IF NOT EXISTS idx_finhist_user   ON public.financial_history(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_actlog_user    ON public.activity_logs(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_notif_user     ON public.notifications(user_id, read, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_audit_table    ON public.audit_logs(table_name, record_id);

-- snapshots
CREATE INDEX IF NOT EXISTS idx_snap_user_date ON public.monthly_snapshots(user_id, snapshot_date DESC);
CREATE INDEX IF NOT EXISTS idx_backup_user    ON public.backup_snapshots(user_id, created_at DESC);

-- notes
CREATE INDEX IF NOT EXISTS idx_notes_user     ON public.notes(user_id, pinned DESC, updated_at DESC);

-- ═══════════════════════════════════════════════════════════════
--  FUNÇÕES
-- ═══════════════════════════════════════════════════════════════

-- Atualiza updated_at automaticamente
CREATE OR REPLACE FUNCTION public.fn_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- Cria perfil e settings automaticamente ao registrar
CREATE OR REPLACE FUNCTION public.fn_handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (NEW.id, COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email,'@',1)))
  ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.user_settings (user_id)
  VALUES (NEW.id)
  ON CONFLICT (user_id) DO NOTHING;

  RETURN NEW;
END;
$$;

-- Registra histórico de salário quando salario muda
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

-- Atualiza current_amount das metas ao inserir/deletar contribuição
CREATE OR REPLACE FUNCTION public.fn_goal_contribution()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE public.goals
    SET current_amount = current_amount + NEW.amount,
        completed = (current_amount + NEW.amount >= target_amount),
        completed_at = CASE WHEN (current_amount + NEW.amount >= target_amount) AND completed = FALSE THEN NOW() ELSE completed_at END,
        updated_at = NOW()
    WHERE id = NEW.goal_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE public.goals
    SET current_amount = GREATEST(0, current_amount - OLD.amount),
        completed = (GREATEST(0, current_amount - OLD.amount) >= target_amount),
        updated_at = NOW()
    WHERE id = OLD.goal_id;
  END IF;
  RETURN NULL;
END;
$$;

-- Audit trigger genérico
CREATE OR REPLACE FUNCTION public.fn_audit_log()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO public.audit_logs (user_id, table_name, record_id, operation, old_data, new_data)
  VALUES (
    COALESCE(NEW.user_id, OLD.user_id),
    TG_TABLE_NAME,
    COALESCE(NEW.id, OLD.id),
    TG_OP,
    CASE WHEN TG_OP != 'INSERT' THEN to_jsonb(OLD) ELSE NULL END,
    CASE WHEN TG_OP != 'DELETE' THEN to_jsonb(NEW) ELSE NULL END
  );
  RETURN NULL;
END;
$$;

-- Marca conta como paga e gera transação
CREATE OR REPLACE FUNCTION public.fn_pay_bill(
  p_bill_id UUID,
  p_user_id UUID,
  p_paid_date DATE DEFAULT CURRENT_DATE
)
RETURNS UUID LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_bill public.bills%ROWTYPE;
  v_tx_id UUID;
BEGIN
  SELECT * INTO v_bill FROM public.bills WHERE id = p_bill_id AND user_id = p_user_id;
  IF NOT FOUND THEN RAISE EXCEPTION 'Conta não encontrada'; END IF;

  -- Gera transação de saída
  INSERT INTO public.transactions (user_id, category_id, bill_id, type, description, amount, date)
  VALUES (p_user_id, v_bill.category_id, p_bill_id, 'saida', 'Pagamento: ' || v_bill.name, v_bill.amount, p_paid_date)
  RETURNING id INTO v_tx_id;

  -- Marca como pago
  UPDATE public.bills
  SET paid = TRUE, paid_at = NOW(), paid_tx_id = v_tx_id, updated_at = NOW()
  WHERE id = p_bill_id;

  -- Se recorrente, gera próxima
  IF v_bill.recurrence != 'unica' THEN
    INSERT INTO public.bills (user_id, category_id, name, amount, due_date, recurrence, remind_days, notes)
    VALUES (
      p_user_id, v_bill.category_id, v_bill.name, v_bill.amount,
      CASE v_bill.recurrence
        WHEN 'diaria'      THEN v_bill.due_date + INTERVAL '1 day'
        WHEN 'semanal'     THEN v_bill.due_date + INTERVAL '7 days'
        WHEN 'quinzenal'   THEN v_bill.due_date + INTERVAL '15 days'
        WHEN 'mensal'      THEN v_bill.due_date + INTERVAL '1 month'
        WHEN 'bimestral'   THEN v_bill.due_date + INTERVAL '2 months'
        WHEN 'trimestral'  THEN v_bill.due_date + INTERVAL '3 months'
        WHEN 'semestral'   THEN v_bill.due_date + INTERVAL '6 months'
        WHEN 'anual'       THEN v_bill.due_date + INTERVAL '1 year'
        ELSE v_bill.due_date + INTERVAL '1 month'
      END,
      v_bill.recurrence, v_bill.remind_days, v_bill.notes
    );
  END IF;

  RETURN v_tx_id;
END;
$$;

-- View: resumo mensal calculado
CREATE OR REPLACE VIEW public.vw_monthly_summary AS
SELECT
  user_id,
  DATE_TRUNC('month', date) AS month,
  SUM(CASE WHEN type IN ('entrada') THEN amount ELSE 0 END) AS total_entrada,
  SUM(CASE WHEN type IN ('saida','pix') THEN amount ELSE 0 END) AS total_saida,
  SUM(CASE WHEN type IN ('entrada') THEN amount ELSE 0 END) -
  SUM(CASE WHEN type IN ('saida','pix') THEN amount ELSE 0 END) AS saldo,
  COUNT(*) AS total_txs,
  COUNT(CASE WHEN type IN ('saida','pix') THEN 1 END) AS total_despesas,
  COUNT(CASE WHEN type = 'entrada' THEN 1 END) AS total_entradas
FROM public.transactions
GROUP BY user_id, DATE_TRUNC('month', date);

-- View: contas vencendo nos próximos 7 dias
CREATE OR REPLACE VIEW public.vw_bills_due_soon AS
SELECT b.*, p.full_name, p.salario
FROM public.bills b
JOIN public.profiles p ON p.id = b.user_id
WHERE b.paid = FALSE
  AND b.archived = FALSE
  AND b.due_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days';

-- View: patrimônio por usuário
CREATE OR REPLACE VIEW public.vw_patrimonio AS
SELECT
  user_id,
  SUM(current_value) AS total_investido_valor_atual,
  SUM(invested_amount) AS total_aportado,
  SUM(current_value - invested_amount) AS lucro_total,
  CASE WHEN SUM(invested_amount) > 0
    THEN ROUND((SUM(current_value) - SUM(invested_amount)) / SUM(invested_amount) * 100, 2)
    ELSE 0
  END AS rentabilidade_pct
FROM public.investments
WHERE archived = FALSE
GROUP BY user_id;

-- ═══════════════════════════════════════════════════════════════
--  TRIGGERS
-- ═══════════════════════════════════════════════════════════════

-- updated_at
CREATE OR REPLACE FUNCTION public.fn_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$;

DO $$ DECLARE t TEXT; BEGIN
  FOREACH t IN ARRAY ARRAY['profiles','user_settings','transaction_categories','transactions','bills','goals','investments','budgets','budget_items','notes','recurring_transactions'] LOOP
    EXECUTE format(
      'DROP TRIGGER IF EXISTS trg_updated_at_%I ON public.%I;
       CREATE TRIGGER trg_updated_at_%I BEFORE UPDATE ON public.%I
       FOR EACH ROW EXECUTE FUNCTION public.fn_updated_at();',
      t, t, t, t
    );
  END LOOP;
END $$;

-- novo usuário → perfil + settings
DROP TRIGGER IF EXISTS trg_new_user ON auth.users;
CREATE TRIGGER trg_new_user
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.fn_handle_new_user();

-- mudança de salário → histórico
DROP TRIGGER IF EXISTS trg_salary_hist ON public.profiles;
CREATE TRIGGER trg_salary_hist
  AFTER UPDATE OF salario ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.fn_salary_history();

-- aportes em metas → atualiza current_amount
DROP TRIGGER IF EXISTS trg_goal_contrib_ins ON public.goal_contributions;
CREATE TRIGGER trg_goal_contrib_ins
  AFTER INSERT ON public.goal_contributions
  FOR EACH ROW EXECUTE FUNCTION public.fn_goal_contribution();

DROP TRIGGER IF EXISTS trg_goal_contrib_del ON public.goal_contributions;
CREATE TRIGGER trg_goal_contrib_del
  AFTER DELETE ON public.goal_contributions
  FOR EACH ROW EXECUTE FUNCTION public.fn_goal_contribution();

-- audit log em transações e contas (principais)
DROP TRIGGER IF EXISTS trg_audit_tx ON public.transactions;
CREATE TRIGGER trg_audit_tx
  AFTER INSERT OR UPDATE OR DELETE ON public.transactions
  FOR EACH ROW EXECUTE FUNCTION public.fn_audit_log();

DROP TRIGGER IF EXISTS trg_audit_bills ON public.bills;
CREATE TRIGGER trg_audit_bills
  AFTER INSERT OR UPDATE OR DELETE ON public.bills
  FOR EACH ROW EXECUTE FUNCTION public.fn_audit_log();

-- ═══════════════════════════════════════════════════════════════
--  ROW LEVEL SECURITY (RLS)
-- ═══════════════════════════════════════════════════════════════

DO $$ DECLARE t TEXT; BEGIN
  FOREACH t IN ARRAY ARRAY[
    'profiles','user_settings','salary_history',
    'transaction_categories','transactions','bills',
    'goals','goal_contributions',
    'investments','investment_history',
    'budgets','budget_items',
    'notes','tags',
    'recurring_transactions','recurring_bills',
    'monthly_snapshots','financial_history',
    'attachments','notifications',
    'activity_logs','audit_logs',
    'backup_snapshots'
  ] LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', t);
  END LOOP;
END $$;

-- Helper: retorna user_id do JWT atual
CREATE OR REPLACE FUNCTION public.current_user_id() RETURNS UUID
LANGUAGE sql STABLE AS $$ SELECT auth.uid(); $$;

-- Macro para criar políticas padrão de CRUD pessoal
DO $$ DECLARE t TEXT; uid_col TEXT; BEGIN
  FOREACH t IN ARRAY ARRAY[
    'user_settings','salary_history',
    'transaction_categories','transactions','bills',
    'goals','goal_contributions',
    'investments','investment_history',
    'budgets','budget_items',
    'notes','tags',
    'recurring_transactions','recurring_bills',
    'monthly_snapshots','financial_history',
    'attachments','notifications',
    'activity_logs','audit_logs',
    'backup_snapshots'
  ] LOOP
    -- Detecta coluna de user_id
    uid_col := CASE t
      WHEN 'profiles' THEN 'id'
      WHEN 'user_settings' THEN 'user_id'
      ELSE 'user_id'
    END;

    EXECUTE format(
      'DROP POLICY IF EXISTS pol_%I_select ON public.%I;
       CREATE POLICY pol_%I_select ON public.%I FOR SELECT USING (%I = auth.uid());
       DROP POLICY IF EXISTS pol_%I_insert ON public.%I;
       CREATE POLICY pol_%I_insert ON public.%I FOR INSERT WITH CHECK (%I = auth.uid());
       DROP POLICY IF EXISTS pol_%I_update ON public.%I;
       CREATE POLICY pol_%I_update ON public.%I FOR UPDATE USING (%I = auth.uid());
       DROP POLICY IF EXISTS pol_%I_delete ON public.%I;
       CREATE POLICY pol_%I_delete ON public.%I FOR DELETE USING (%I = auth.uid());',
      t, t, t, t, uid_col,
      t, t, t, t, uid_col,
      t, t, t, t, uid_col,
      t, t, t, t, uid_col
    );
  END LOOP;
END $$;

-- profiles: policy separada (PK = id)
DROP POLICY IF EXISTS pol_profiles_select ON public.profiles;
CREATE POLICY pol_profiles_select ON public.profiles FOR SELECT USING (id = auth.uid());
DROP POLICY IF EXISTS pol_profiles_insert ON public.profiles;
CREATE POLICY pol_profiles_insert ON public.profiles FOR INSERT WITH CHECK (id = auth.uid());
DROP POLICY IF EXISTS pol_profiles_update ON public.profiles;
CREATE POLICY pol_profiles_update ON public.profiles FOR UPDATE USING (id = auth.uid());
DROP POLICY IF EXISTS pol_profiles_delete ON public.profiles;
CREATE POLICY pol_profiles_delete ON public.profiles FOR DELETE USING (id = auth.uid());

-- ═══════════════════════════════════════════════════════════════
--  MIGRAÇÃO v2 → v3 (segura, sem perda de dados)
-- ═══════════════════════════════════════════════════════════════

-- Adiciona colunas ausentes no profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS avatar_url TEXT,
  ADD COLUMN IF NOT EXISTS phone TEXT,
  ADD COLUMN IF NOT EXISTS locale TEXT NOT NULL DEFAULT 'pt-BR',
  ADD COLUMN IF NOT EXISTS timezone TEXT NOT NULL DEFAULT 'America/Sao_Paulo',
  ADD COLUMN IF NOT EXISTS onboarding_done BOOLEAN NOT NULL DEFAULT FALSE;

-- Adiciona colunas ausentes no user_settings
ALTER TABLE public.user_settings
  ADD COLUMN IF NOT EXISTS dark_mode BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS compact_view BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS show_cents BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS default_tab TEXT NOT NULL DEFAULT 'visao',
  ADD COLUMN IF NOT EXISTS notification_email BOOLEAN NOT NULL DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS notification_push BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS budget_alert_pct INTEGER NOT NULL DEFAULT 80;

-- Adiciona colunas ausentes em transaction_categories
ALTER TABLE public.transaction_categories
  ADD COLUMN IF NOT EXISTS color TEXT NOT NULL DEFAULT '#6366f1',
  ADD COLUMN IF NOT EXISTS sort_order INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS is_system BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS archived BOOLEAN NOT NULL DEFAULT FALSE;

-- Adiciona colunas ausentes em transactions
ALTER TABLE public.transactions
  ADD COLUMN IF NOT EXISTS notes TEXT,
  ADD COLUMN IF NOT EXISTS tags TEXT[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS is_recurring BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS recurring_id UUID,
  ADD COLUMN IF NOT EXISTS attachment_url TEXT;

-- Adiciona colunas ausentes em bills
ALTER TABLE public.bills
  ADD COLUMN IF NOT EXISTS auto_pay BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS tags TEXT[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS remind_days INTEGER NOT NULL DEFAULT 3,
  ADD COLUMN IF NOT EXISTS archived BOOLEAN NOT NULL DEFAULT FALSE;

-- Adiciona colunas ausentes em goals
ALTER TABLE public.goals
  ADD COLUMN IF NOT EXISTS type goal_type NOT NULL DEFAULT 'personalizado',
  ADD COLUMN IF NOT EXISTS monthly_contrib NUMERIC(14,2),
  ADD COLUMN IF NOT EXISTS color TEXT NOT NULL DEFAULT '#6366f1',
  ADD COLUMN IF NOT EXISTS notes TEXT,
  ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS archived BOOLEAN NOT NULL DEFAULT FALSE;

-- Adiciona colunas ausentes em investments
ALTER TABLE public.investments
  ADD COLUMN IF NOT EXISTS ticker TEXT,
  ADD COLUMN IF NOT EXISTS quantity NUMERIC(18,8),
  ADD COLUMN IF NOT EXISTS avg_price NUMERIC(14,4),
  ADD COLUMN IF NOT EXISTS broker TEXT,
  ADD COLUMN IF NOT EXISTS color TEXT NOT NULL DEFAULT '#10b981',
  ADD COLUMN IF NOT EXISTS archived BOOLEAN NOT NULL DEFAULT FALSE;

-- ═══════════════════════════════════════════════════════════════
--  DADOS INICIAIS (SEEDS) — inseridos apenas se vazio
-- ═══════════════════════════════════════════════════════════════
-- (Seeds de categorias padrão são criados pelo frontend no onboarding)

-- ═══════════════════════════════════════════════════════════════
--  REALTIME — habilita publicação via canal
-- ═══════════════════════════════════════════════════════════════
ALTER PUBLICATION supabase_realtime ADD TABLE public.transactions;
ALTER PUBLICATION supabase_realtime ADD TABLE public.bills;
ALTER PUBLICATION supabase_realtime ADD TABLE public.goals;
ALTER PUBLICATION supabase_realtime ADD TABLE public.goal_contributions;
ALTER PUBLICATION supabase_realtime ADD TABLE public.investments;
ALTER PUBLICATION supabase_realtime ADD TABLE public.transaction_categories;
ALTER PUBLICATION supabase_realtime ADD TABLE public.monthly_snapshots;
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;
ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;
ALTER PUBLICATION supabase_realtime ADD TABLE public.notes;

-- ═══════════════════════════════════════════════════════════════
--  STORAGE BUCKET (execute via Supabase Dashboard ou API)
-- ═══════════════════════════════════════════════════════════════
-- INSERT INTO storage.buckets (id, name, public)
-- VALUES ('cofre-attachments', 'cofre-attachments', false)
-- ON CONFLICT (id) DO NOTHING;

-- Fim do schema Cofre v3
