-- ═══════════════════════════════════════════════════════════════
--  FinanceFlow — Script de criação de banco de dados no Supabase
--  100% IDEMPOTENTE: pode ser executado quantas vezes for preciso
--  sem gerar erro de "já existe".
--
--  Como usar:
--  Supabase → SQL Editor → New Query → cole tudo → Run
-- ═══════════════════════════════════════════════════════════════

-- ──────────────────────────────────────────────────────────────
-- EXTENSÕES
-- ──────────────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ──────────────────────────────────────────────────────────────
-- 1. TABELA: salary_months
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.salary_months (
    id               UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id          UUID        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    month            INTEGER     NOT NULL,
    year             INTEGER     NOT NULL,
    gross_amount     NUMERIC(12,2) NOT NULL DEFAULT 0,
    notes            TEXT,
    created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- Constraints (idempotentes via DO block)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_month_check'
    ) THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_month_check CHECK (month BETWEEN 1 AND 12);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_year_check'
    ) THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_year_check CHECK (year BETWEEN 2000 AND 2100);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'salary_months_user_month_year_key'
    ) THEN
        ALTER TABLE public.salary_months
            ADD CONSTRAINT salary_months_user_month_year_key UNIQUE (user_id, month, year);
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 2. TABELA: movements
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.movements (
    id               UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id          UUID        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    salary_month_id  UUID        REFERENCES public.salary_months(id) ON DELETE CASCADE,
    description      TEXT        NOT NULL,
    amount           NUMERIC(12,2) NOT NULL,
    category         TEXT        NOT NULL DEFAULT 'outros',
    type             TEXT        NOT NULL,
    date             DATE        DEFAULT CURRENT_DATE,
    created_at       TIMESTAMPTZ DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'movements_amount_check'
    ) THEN
        ALTER TABLE public.movements
            ADD CONSTRAINT movements_amount_check CHECK (amount >= 0);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'movements_type_check'
    ) THEN
        ALTER TABLE public.movements
            ADD CONSTRAINT movements_type_check
            CHECK (type IN ('entrada','saida','investimento','reserva'));
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 3. TABELA: investments
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.investments (
    id               UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id          UUID        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    name             TEXT        NOT NULL,
    product          TEXT,
    amount_invested  NUMERIC(12,2) NOT NULL DEFAULT 0,
    current_value    NUMERIC(12,2) NOT NULL DEFAULT 0,
    quantity         NUMERIC(16,6),
    unit_value       NUMERIC(12,2),
    return_rate      NUMERIC(10,4),
    purchase_date    DATE,
    created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- ──────────────────────────────────────────────────────────────
-- 4. TABELA: debts
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.debts (
    id                  UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id             UUID        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    description         TEXT        NOT NULL,
    total_amount        NUMERIC(12,2) NOT NULL,
    installment_amount  NUMERIC(12,2) NOT NULL,
    installments_total  INTEGER     NOT NULL,
    installments_paid   INTEGER     NOT NULL DEFAULT 0,
    due_day             INTEGER,
    start_date          DATE        DEFAULT CURRENT_DATE,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'debts_installments_total_check'
    ) THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_installments_total_check CHECK (installments_total > 0);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'debts_installments_paid_check'
    ) THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_installments_paid_check CHECK (installments_paid >= 0);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'debts_due_day_check'
    ) THEN
        ALTER TABLE public.debts
            ADD CONSTRAINT debts_due_day_check CHECK (due_day IS NULL OR due_day BETWEEN 1 AND 31);
    END IF;
END $$;

-- ──────────────────────────────────────────────────────────────
-- 5. TABELA: debt_payments
-- ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.debt_payments (
    id                  UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    debt_id             UUID        REFERENCES public.debts(id) ON DELETE CASCADE NOT NULL,
    user_id             UUID        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    amount              NUMERIC(12,2) NOT NULL,
    payment_date        DATE        DEFAULT CURRENT_DATE,
    installment_number  INTEGER     NOT NULL,
    notes               TEXT,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

-- ═══════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY (RLS)
-- Idempotente: habilita RLS (sem erro se já habilitado) e cria
-- as policies apenas se elas ainda não existirem.
-- ═══════════════════════════════════════════════════════════════
ALTER TABLE public.salary_months   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.movements       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.investments     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.debts           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.debt_payments   ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public' AND tablename = 'salary_months'
          AND policyname = 'Usuario acessa so seus meses'
    ) THEN
        CREATE POLICY "Usuario acessa so seus meses"
            ON public.salary_months FOR ALL
            USING (auth.uid() = user_id)
            WITH CHECK (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public' AND tablename = 'movements'
          AND policyname = 'Usuario acessa so seus movimentos'
    ) THEN
        CREATE POLICY "Usuario acessa so seus movimentos"
            ON public.movements FOR ALL
            USING (auth.uid() = user_id)
            WITH CHECK (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public' AND tablename = 'investments'
          AND policyname = 'Usuario acessa so seus investimentos'
    ) THEN
        CREATE POLICY "Usuario acessa so seus investimentos"
            ON public.investments FOR ALL
            USING (auth.uid() = user_id)
            WITH CHECK (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public' AND tablename = 'debts'
          AND policyname = 'Usuario acessa so suas dividas'
    ) THEN
        CREATE POLICY "Usuario acessa so suas dividas"
            ON public.debts FOR ALL
            USING (auth.uid() = user_id)
            WITH CHECK (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public' AND tablename = 'debt_payments'
          AND policyname = 'Usuario acessa so seus pagamentos'
    ) THEN
        CREATE POLICY "Usuario acessa so seus pagamentos"
            ON public.debt_payments FOR ALL
            USING (auth.uid() = user_id)
            WITH CHECK (auth.uid() = user_id);
    END IF;
END $$;

-- ═══════════════════════════════════════════════════════════════
-- ÍNDICES (já idempotentes com IF NOT EXISTS)
-- ═══════════════════════════════════════════════════════════════
CREATE INDEX IF NOT EXISTS idx_salary_months_user
    ON public.salary_months(user_id, year DESC, month DESC);

CREATE INDEX IF NOT EXISTS idx_movements_user
    ON public.movements(user_id, salary_month_id);

CREATE INDEX IF NOT EXISTS idx_movements_type
    ON public.movements(user_id, type);

CREATE INDEX IF NOT EXISTS idx_investments_user
    ON public.investments(user_id);

CREATE INDEX IF NOT EXISTS idx_debts_user
    ON public.debts(user_id);

CREATE INDEX IF NOT EXISTS idx_debt_payments_debt
    ON public.debt_payments(debt_id);

-- ═══════════════════════════════════════════════════════════════
-- FUNÇÃO: preenche user_id automaticamente se vier nulo
-- (CREATE OR REPLACE já é idempotente)
-- ═══════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.set_user_id()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
    IF NEW.user_id IS NULL THEN
        NEW.user_id := auth.uid();
    END IF;
    RETURN NEW;
END;
$$;

-- ═══════════════════════════════════════════════════════════════
-- TRIGGERS — dropados e recriados para garantir idempotência
-- ═══════════════════════════════════════════════════════════════
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
-- VIEW: resumo_mensal (CREATE OR REPLACE já é idempotente)
-- ═══════════════════════════════════════════════════════════════
CREATE OR REPLACE VIEW public.resumo_mensal AS
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
-- PRONTO!
-- Este script pode ser executado quantas vezes quiser sem erro.
--
-- Próximo passo: no arquivo financeflow.html, edite as constantes:
--   const SUPABASE_URL      = "https://SEU-PROJETO.supabase.co";
--   const SUPABASE_ANON_KEY = "SUA_CHAVE_ANON_PUBLIC_AQUI";
--
-- Essas informações ficam SOMENTE no código-fonte, nunca visíveis
-- ou configuráveis pelo usuário final do site.
--
-- Dica: em Authentication → Providers → Email, desmarque
-- "Confirm email" se quiser que o usuário entre imediatamente
-- após criar a conta (sem precisar confirmar o e-mail).
-- ═══════════════════════════════════════════════════════════════
