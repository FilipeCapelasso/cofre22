-- ╔══════════════════════════════════════════════════════════════════╗
-- ║  FLUXO — Configuração do banco de dados (Supabase / PostgreSQL)     ║
-- ║                                                                    ║
-- ║  Como usar:                                                        ║
-- ║   1. Abra o painel do Supabase do seu projeto                      ║
-- ║   2. Menu lateral → SQL Editor → New query                         ║
-- ║   3. Cole TODO este arquivo e clique em "Run"                      ║
-- ║                                                                    ║
-- ║  Pode rodar mais de uma vez sem problema (é idempotente).          ║
-- ╚══════════════════════════════════════════════════════════════════╝

-- Extensão para gerar UUIDs (já vem habilitada na maioria dos projetos)
create extension if not exists pgcrypto;

-- ────────────────────────────────────────────────────────────────────
-- 1. TABELAS
-- ────────────────────────────────────────────────────────────────────

-- Perfil do usuário (1 linha por conta). Guarda salário e preferências.
create table if not exists public.profiles (
  id               uuid primary key references auth.users(id) on delete cascade,
  full_name        text,
  salario          numeric      default 0,
  invest_acum      numeric      default 0,
  invest_taxa      numeric      default 1,
  show_free_graph  boolean      default false,
  created_at       timestamptz  default now()
);

-- Categorias de distribuição do salário
create table if not exists public.transaction_categories (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  name          text not null,
  emoji         text,
  pct           numeric default 0,
  manual_value  numeric,
  sort_order    integer default 0,
  created_at    timestamptz default now()
);

-- Lançamentos (pix, despesas, pagamentos, entradas)
create table if not exists public.transactions (
  id                uuid primary key default gen_random_uuid(),
  user_id           uuid not null references auth.users(id) on delete cascade,
  name              text not null,
  amount            numeric default 0,
  type              text,
  notes             text,
  transaction_date  date default current_date,
  created_at        timestamptz default now()
);

-- Contas fixas / recorrentes
create table if not exists public.bills (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  name        text not null,
  amount      numeric default 0,
  due_day     integer default 1,
  category    text,
  recurrence  text,
  is_paid     boolean default false,
  created_at  timestamptz default now()
);

-- Metas / objetivos
create table if not exists public.goals (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid not null references auth.users(id) on delete cascade,
  name             text not null,
  emoji            text,
  target_amount    numeric default 0,
  current_amount   numeric default 0,
  deadline_months  integer default 12,
  is_completed     boolean default false,
  sort_order       integer default 0,
  created_at       timestamptz default now()
);

-- Investimentos / ativos
create table if not exists public.investments (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references auth.users(id) on delete cascade,
  name            text not null,
  type            text,
  institution     text,
  total_invested  numeric default 0,
  current_value   numeric default 0,
  monthly_rate    numeric default 0,
  notes           text,
  is_active       boolean default true,
  sort_order      integer default 0,
  created_at      timestamptz default now()
);

-- Fotografias mensais (histórico / fechamento de mês)
create table if not exists public.monthly_snapshots (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid not null references auth.users(id) on delete cascade,
  title               text,
  salario             numeric default 0,
  saldo_livre         numeric default 0,
  total_cats          numeric default 0,
  total_tx_saidas     numeric default 0,
  total_tx_entradas   numeric default 0,
  total_bills_pago    numeric default 0,
  payload             jsonb,
  created_at          timestamptz default now()
);

-- Índices úteis para as consultas por usuário
create index if not exists idx_cats_user   on public.transaction_categories(user_id);
create index if not exists idx_tx_user     on public.transactions(user_id);
create index if not exists idx_bills_user  on public.bills(user_id);
create index if not exists idx_goals_user  on public.goals(user_id);
create index if not exists idx_inv_user    on public.investments(user_id);
create index if not exists idx_snap_user   on public.monthly_snapshots(user_id);

-- ────────────────────────────────────────────────────────────────────
-- 2. ROW LEVEL SECURITY (cada usuário só enxerga os próprios dados)
-- ────────────────────────────────────────────────────────────────────

alter table public.profiles               enable row level security;
alter table public.transaction_categories enable row level security;
alter table public.transactions           enable row level security;
alter table public.bills                  enable row level security;
alter table public.goals                  enable row level security;
alter table public.investments            enable row level security;
alter table public.monthly_snapshots      enable row level security;

-- profiles: a chave de dono é a própria coluna id
drop policy if exists "profiles_own" on public.profiles;
create policy "profiles_own" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

-- Demais tabelas: a chave de dono é user_id
drop policy if exists "cats_own" on public.transaction_categories;
create policy "cats_own" on public.transaction_categories
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "tx_own" on public.transactions;
create policy "tx_own" on public.transactions
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "bills_own" on public.bills;
create policy "bills_own" on public.bills
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "goals_own" on public.goals;
create policy "goals_own" on public.goals
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "inv_own" on public.investments;
create policy "inv_own" on public.investments
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "snap_own" on public.monthly_snapshots;
create policy "snap_own" on public.monthly_snapshots
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ────────────────────────────────────────────────────────────────────
-- 3. CRIAÇÃO AUTOMÁTICA DE PERFIL NO CADASTRO
--    (cria a linha em profiles assim que o usuário se registra)
-- ────────────────────────────────────────────────────────────────────

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ────────────────────────────────────────────────────────────────────
-- 4. REALTIME (sincronização ao vivo entre abas / dispositivos)
-- ────────────────────────────────────────────────────────────────────

do $$
declare t text;
begin
  foreach t in array array[
    'profiles','transaction_categories','transactions',
    'bills','goals','investments','monthly_snapshots'
  ] loop
    begin
      execute format('alter publication supabase_realtime add table public.%I', t);
    exception
      when duplicate_object then null;  -- já está na publicação, tudo certo
      when undefined_object then null;  -- publicação inexistente; ignore
    end;
  end loop;
end $$;

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║  Pronto! Tabelas, segurança, trigger de cadastro e realtime ok.    ║
-- ╚══════════════════════════════════════════════════════════════════╝
