-- ═══════════════════════════════════════════════════════════════
--  FinanceFlow — Esquema de banco de dados (Supabase / PostgreSQL)
--
--  100% IDEMPOTENTE. Pode ser executado quantas vezes forem
--  necessárias sem gerar erro de "já existe" (inclui o erro
--  42710 "policy already exists" que ocorria na versão anterior).
--
--  Estratégia de idempotência:
--    • Tabelas / índices ...... CREATE ... IF NOT EXISTS
--    • Constraints ............ verificação em pg_constraint
--    • Policies ............... DROP POLICY IF EXISTS + CREATE
--    • Funções / views ........ CREATE OR REPLACE
--    • Triggers ............... DROP TRIGGER IF EXISTS + CREATE
--
--  Como usar:
--    Supabase → SQL Editor → New Query → cole tudo → Run
-- ═══════════════════════════════════════════════════════════════

-- ──────────────────────────────────────────────────────────────
-- EXTENSÕES
-- ──────────────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ══════════════════════════════════════════════════════════════
-- 0. TABELA: profiles  (perfil criado automaticamente no cadastro)
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.profiles (
    id           UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name    TEXT,
    avatar_url   TEXT,
    created_at   TIMESTAMPTZ DEFAULT NOW(),
    updated_at   TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────────
-- 1. TABELA: salary_months
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.salary_months (
    id               UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id          UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    month            INTEGER       NOT NULL,
    year             INTEGER       NOT NULL,
    gross_amount     NUMERIC(12,2) NOT NULL DEFAULT 0,
    notes            TEXT,
    created_at       TIMESTAMPTZ   DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_month_check') THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_month_check CHECK (month BETWEEN 1 AND 12);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_year_check') THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_year_check CHECK (year BETWEEN 2000 AND 2100);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_gross_check') THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_gross_check CHECK (gross_amount >= 0);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_user_month_year_key') THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_user_month_year_key UNIQUE (user_id, month, year);
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 2. TABELA: movements
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.movements (
    id               UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id          UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    salary_month_id  UUID          REFERENCES public.salary_months(id) ON DELETE CASCADE,
    description      TEXT          NOT NULL,
    amount           NUMERIC(12,2) NOT NULL,
    category         TEXT          NOT NULL DEFAULT 'outros',
    type             TEXT          NOT NULL,
    date             DATE          DEFAULT CURRENT_DATE,
    created_at       TIMESTAMPTZ   DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'movements_amount_check') THEN
        ALTER TABLE public.movements
            ADD CONSTRAINT movements_amount_check CHECK (amount >= 0);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'movements_type_check') THEN
        ALTER TABLE public.movements
            ADD CONSTRAINT movements_type_check
            CHECK (type IN ('entrada','saida','investimento','reserva'));
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 3. TABELA: investments
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.investments (
    id               UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id          UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    name             TEXT          NOT NULL,
    product          TEXT,
    amount_invested  NUMERIC(12,2) NOT NULL DEFAULT 0,
    current_value    NUMERIC(12,2) NOT NULL DEFAULT 0,
    quantity         NUMERIC(16,6),
    unit_value       NUMERIC(12,2),
    return_rate      NUMERIC(10,4),
    purchase_date    DATE,
    created_at       TIMESTAMPTZ   DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'investments_amount_check') THEN
        ALTER TABLE public.investments
            ADD CONSTRAINT investments_amount_check CHECK (amount_invested >= 0 AND current_value >= 0);
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 4. TABELA: debts
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.debts (
    id                  UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id             UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    description         TEXT          NOT NULL,
    total_amount        NUMERIC(12,2) NOT NULL,
    installment_amount  NUMERIC(12,2) NOT NULL,
    installments_total  INTEGER       NOT NULL,
    installments_paid   INTEGER       NOT NULL DEFAULT 0,
    due_day             INTEGER,
    start_date          DATE          DEFAULT CURRENT_DATE,
    created_at          TIMESTAMPTZ   DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'debts_installments_total_check') THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_installments_total_check CHECK (installments_total > 0);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'debts_installments_paid_check') THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_installments_paid_check
            CHECK (installments_paid >= 0 AND installments_paid <= installments_total);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'debts_amount_check') THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_amount_check CHECK (total_amount >= 0 AND installment_amount >= 0);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'debts_due_day_check') THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_due_day_check CHECK (due_day IS NULL OR due_day BETWEEN 1 AND 31);
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 5. TABELA: debt_payments
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.debt_payments (
    id                  UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
    debt_id             UUID          NOT NULL REFERENCES public.debts(id) ON DELETE CASCADE,
    user_id             UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    amount              NUMERIC(12,2) NOT NULL,
    payment_date        DATE          DEFAULT CURRENT_DATE,
    installment_number  INTEGER       NOT NULL,
    notes               TEXT,
    created_at          TIMESTAMPTZ   DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'debt_payments_amount_check') THEN
        ALTER TABLE public.debt_payments
            ADD CONSTRAINT debt_payments_amount_check CHECK (amount >= 0);
    END IF;
END $$;

-- ═══════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY (RLS)
--
-- Todas as tabelas isolam dados por auth.uid() = user_id.
-- Nenhum usuário consegue ler/gravar dados de outro.
--
-- IDEMPOTÊNCIA: usamos DROP POLICY IF EXISTS antes de cada CREATE.
-- Isto resolve definitivamente o erro 42710.
-- ═══════════════════════════════════════════════════════════════
ALTER TABLE public.profiles        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.salary_months   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.movements       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.investments     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.debts           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.debt_payments   ENABLE ROW LEVEL SECURITY;

-- profiles: o usuário só enxerga e edita o próprio perfil
DROP POLICY IF EXISTS "profiles_select_own" ON public.profiles;
CREATE POLICY "profiles_select_own" ON public.profiles
    FOR SELECT USING (auth.uid() = id);

DROP POLICY IF EXISTS "profiles_insert_own" ON public.profiles;
CREATE POLICY "profiles_insert_own" ON public.profiles
    FOR INSERT WITH CHECK (auth.uid() = id);

DROP POLICY IF EXISTS "profiles_update_own" ON public.profiles;
CREATE POLICY "profiles_update_own" ON public.profiles
    FOR UPDATE USING (auth.uid() = id) WITH CHECK (auth.uid() = id);

-- salary_months
DROP POLICY IF EXISTS "salary_months_all_own" ON public.salary_months;
CREATE POLICY "salary_months_all_own" ON public.salary_months
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- movements
DROP POLICY IF EXISTS "movements_all_own" ON public.movements;
CREATE POLICY "movements_all_own" ON public.movements
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- investments
DROP POLICY IF EXISTS "investments_all_own" ON public.investments;
CREATE POLICY "investments_all_own" ON public.investments
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- debts
DROP POLICY IF EXISTS "debts_all_own" ON public.debts;
CREATE POLICY "debts_all_own" ON public.debts
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- debt_payments
DROP POLICY IF EXISTS "debt_payments_all_own" ON public.debt_payments;
CREATE POLICY "debt_payments_all_own" ON public.debt_payments
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════
-- ÍNDICES
-- ═══════════════════════════════════════════════════════════════
CREATE INDEX IF NOT EXISTS idx_salary_months_user
    ON public.salary_months(user_id, year DESC, month DESC);
CREATE INDEX IF NOT EXISTS idx_movements_user
    ON public.movements(user_id, salary_month_id);
CREATE INDEX IF NOT EXISTS idx_movements_type
    ON public.movements(user_id, type);
CREATE INDEX IF NOT EXISTS idx_movements_created
    ON public.movements(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_investments_user
    ON public.investments(user_id);
CREATE INDEX IF NOT EXISTS idx_debts_user
    ON public.debts(user_id);
CREATE INDEX IF NOT EXISTS idx_debt_payments_debt
    ON public.debt_payments(debt_id);

-- ═══════════════════════════════════════════════════════════════
-- FUNÇÃO: preenche user_id automaticamente se vier nulo
-- ═══════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.set_user_id()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public AS $$
BEGIN
    IF NEW.user_id IS NULL THEN
        NEW.user_id := auth.uid();
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_salary_months_uid ON public.salary_months;
CREATE TRIGGER trg_salary_months_uid
    BEFORE INSERT ON public.salary_months
    FOR EACH ROW EXECUTE FUNCTION public.set_user_id();

DROP TRIGGER IF EXISTS trg_movements_uid ON public.movements;
CREATE TRIGGER trg_movements_uid
    BEFORE INSERT ON public.movements
    FOR EACH ROW EXECUTE FUNCTION public.set_user_id();

DROP TRIGGER IF EXISTS trg_investments_uid ON public.investments;
CREATE TRIGGER trg_investments_uid
    BEFORE INSERT ON public.investments
    FOR EACH ROW EXECUTE FUNCTION public.set_user_id();

DROP TRIGGER IF EXISTS trg_debts_uid ON public.debts;
CREATE TRIGGER trg_debts_uid
    BEFORE INSERT ON public.debts
    FOR EACH ROW EXECUTE FUNCTION public.set_user_id();

DROP TRIGGER IF EXISTS trg_debt_payments_uid ON public.debt_payments;
CREATE TRIGGER trg_debt_payments_uid
    BEFORE INSERT ON public.debt_payments
    FOR EACH ROW EXECUTE FUNCTION public.set_user_id();

-- ═══════════════════════════════════════════════════════════════
-- FUNÇÃO + TRIGGER: cria o profile automaticamente no cadastro
-- (chamado quando um novo usuário é inserido em auth.users)
-- ═══════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public AS $$
BEGIN
    INSERT INTO public.profiles (id, full_name, avatar_url)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'name',
                 NEW.raw_user_meta_data->>'full_name',
                 split_part(NEW.email, '@', 1)),
        NEW.raw_user_meta_data->>'avatar_url'
    )
    ON CONFLICT (id) DO NOTHING;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ═══════════════════════════════════════════════════════════════
-- FUNÇÃO + TRIGGER: mantém profiles.updated_at
-- ═══════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.touch_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_profiles_touch ON public.profiles;
CREATE TRIGGER trg_profiles_touch
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.touch_updated_at();

-- ═══════════════════════════════════════════════════════════════
-- BACKFILL: cria profile para usuários que já existiam antes deste
-- script (evita perfil faltando em contas antigas).
-- ═══════════════════════════════════════════════════════════════
INSERT INTO public.profiles (id, full_name)
SELECT u.id, COALESCE(u.raw_user_meta_data->>'name', split_part(u.email, '@', 1))
FROM auth.users u
LEFT JOIN public.profiles p ON p.id = u.id
WHERE p.id IS NULL;

-- ═══════════════════════════════════════════════════════════════
-- VIEW: resumo_mensal  (agregado por mês, respeitando RLS via
-- security_invoker para não vazar dados entre usuários)
-- ═══════════════════════════════════════════════════════════════
CREATE OR REPLACE VIEW public.resumo_mensal
WITH (security_invoker = true) AS
SELECT
    sm.user_id,
    sm.id            AS salary_month_id,
    sm.month,
    sm.year,
    sm.gross_amount  AS salario,
    COALESCE(SUM(CASE WHEN m.type = 'entrada'      THEN m.amount ELSE 0 END), 0) AS total_entradas,
    COALESCE(SUM(CASE WHEN m.type = 'saida'        THEN m.amount ELSE 0 END), 0) AS total_saidas,
    COALESCE(SUM(CASE WHEN m.type = 'investimento' THEN m.amount ELSE 0 END), 0) AS total_investido,
    COALESCE(SUM(CASE WHEN m.type = 'reserva'      THEN m.amount ELSE 0 END), 0) AS total_reservas,
    COUNT(m.id)      AS total_movimentos
FROM public.salary_months sm
LEFT JOIN public.movements m ON m.salary_month_id = sm.id
GROUP BY sm.user_id, sm.id, sm.month, sm.year, sm.gross_amount;

-- ═══════════════════════════════════════════════════════════════
-- STORAGE: bucket de avatares (para troca de foto de perfil)
-- ═══════════════════════════════════════════════════════════════
INSERT INTO storage.buckets (id, name, public)
VALUES ('avatars', 'avatars', true)
ON CONFLICT (id) DO NOTHING;

-- Cada usuário só grava/atualiza/apaga a própria pasta:  {uid}/arquivo
DROP POLICY IF EXISTS "avatars_public_read" ON storage.objects;
CREATE POLICY "avatars_public_read" ON storage.objects
    FOR SELECT USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "avatars_insert_own" ON storage.objects;
CREATE POLICY "avatars_insert_own" ON storage.objects
    FOR INSERT WITH CHECK (
        bucket_id = 'avatars'
        AND auth.uid()::text = (storage.foldername(name))[1]
    );

DROP POLICY IF EXISTS "avatars_update_own" ON storage.objects;
CREATE POLICY "avatars_update_own" ON storage.objects
    FOR UPDATE USING (
        bucket_id = 'avatars'
        AND auth.uid()::text = (storage.foldername(name))[1]
    );

DROP POLICY IF EXISTS "avatars_delete_own" ON storage.objects;
CREATE POLICY "avatars_delete_own" ON storage.objects
    FOR DELETE USING (
        bucket_id = 'avatars'
        AND auth.uid()::text = (storage.foldername(name))[1]
    );

-- ══════════════════════════════════════════════════════════════
-- 6. TABELA: investment_contributions  (histórico de aportes)
--    Relaciona-se ao investimento sem alterar a tabela existente.
--    Cada linha é um aporte: valor, data e observação.
-- ══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.investment_contributions (
    id                UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
    investment_id     UUID          NOT NULL REFERENCES public.investments(id) ON DELETE CASCADE,
    user_id           UUID          NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    amount            NUMERIC(12,2) NOT NULL,
    contribution_date DATE          DEFAULT CURRENT_DATE,
    notes             TEXT,
    created_at        TIMESTAMPTZ   DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'inv_contrib_amount_check') THEN
        ALTER TABLE public.investment_contributions
            ADD CONSTRAINT inv_contrib_amount_check CHECK (amount >= 0);
    END IF;
END $$;

ALTER TABLE public.investment_contributions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "inv_contrib_all_own" ON public.investment_contributions;
CREATE POLICY "inv_contrib_all_own" ON public.investment_contributions
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS idx_inv_contrib_inv
    ON public.investment_contributions(investment_id, contribution_date DESC);
CREATE INDEX IF NOT EXISTS idx_inv_contrib_user
    ON public.investment_contributions(user_id);

DROP TRIGGER IF EXISTS trg_inv_contrib_uid ON public.investment_contributions;
CREATE TRIGGER trg_inv_contrib_uid
    BEFORE INSERT ON public.investment_contributions
    FOR EACH ROW EXECUTE FUNCTION public.set_user_id();

-- Backfill opcional: cria o "aporte inicial" para investimentos que já
-- existiam antes desta atualização e ainda não têm nenhum aporte
-- registrado, usando o valor já aportado e a data de compra. Assim o
-- histórico fica coerente sem alterar os cálculos atuais.
INSERT INTO public.investment_contributions (investment_id, user_id, amount, contribution_date, notes)
SELECT i.id, i.user_id, i.amount_invested,
       COALESCE(i.purchase_date, i.created_at::date), 'Aporte inicial'
FROM public.investments i
LEFT JOIN public.investment_contributions c ON c.investment_id = i.id
WHERE c.id IS NULL AND i.amount_invested > 0;

-- ═══════════════════════════════════════════════════════════════
-- PRONTO. Script seguro para reexecução ilimitada.
--
-- Observações:
--  • Para o usuário entrar imediatamente após o cadastro (sem
--    confirmar e-mail): Authentication → Providers → Email →
--    desmarque "Confirm email".
--  • Para o link de recuperação de senha voltar para o app:
--    Authentication → URL Configuration → adicione a URL do site
--    em "Redirect URLs".
-- ═══════════════════════════════════════════════════════════════
