-- ============================================================
-- COFRE — Supabase Schema
-- Cole todo este arquivo no SQL Editor do seu projeto Supabase
-- e clique em "Run". Só precisa fazer isso uma vez.
-- ============================================================

-- Estado global do usuário (salário, configurações)
create table if not exists public.cofre_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  salario       numeric(12,2) default 0,
  invest_acum   numeric(12,2) default 0,
  invest_taxa   numeric(8,4)  default 1,
  updated_at    timestamptz   default now()
);

-- Categorias de alocação
create table if not exists public.cofre_cats (
  uid       uuid    default gen_random_uuid() primary key,
  user_id   uuid    references auth.users(id) on delete cascade not null,
  cat_id    integer not null,
  name      text    not null,
  pct       numeric(8,4) default 0,
  emoji     text    default '📁',
  manual    numeric(12,2),
  sort_order integer default 0,
  unique(user_id, cat_id)
);

-- Transações (Pix, despesas, entradas)
create table if not exists public.cofre_txs (
  uid       uuid    default gen_random_uuid() primary key,
  user_id   uuid    references auth.users(id) on delete cascade not null,
  tx_id     integer not null,
  name      text    not null,
  val       numeric(12,2) not null,
  tipo      text    not null,
  obs       text    default '',
  date_str  text,
  created_at timestamptz default now(),
  unique(user_id, tx_id)
);

-- Contas a pagar
create table if not exists public.cofre_bills (
  uid       uuid    default gen_random_uuid() primary key,
  user_id   uuid    references auth.users(id) on delete cascade not null,
  bill_id   integer not null,
  name      text    not null,
  val       numeric(12,2) not null,
  dia       integer default 1,
  cat       text    default 'outro',
  rec       text    default 'mensal',
  paid      boolean default false,
  unique(user_id, bill_id)
);

-- Metas financeiras
create table if not exists public.cofre_goals (
  uid       uuid    default gen_random_uuid() primary key,
  user_id   uuid    references auth.users(id) on delete cascade not null,
  goal_id   integer not null,
  name      text    not null,
  emoji     text    default '🎯',
  alvo      numeric(12,2) not null,
  atual     numeric(12,2) default 0,
  prazo     integer default 12,
  unique(user_id, goal_id)
);

-- Snapshots de histórico (payload JSON completo)
create table if not exists public.cofre_snapshots (
  uid       uuid    default gen_random_uuid() primary key,
  user_id   uuid    references auth.users(id) on delete cascade not null,
  snap_id   bigint  not null,
  title     text,
  date_str  text,
  payload   jsonb   not null default '{}',
  created_at timestamptz default now(),
  unique(user_id, snap_id)
);

-- ============================================================
-- Row Level Security — cada usuário acessa apenas seus dados
-- ============================================================
alter table public.cofre_state     enable row level security;
alter table public.cofre_cats      enable row level security;
alter table public.cofre_txs       enable row level security;
alter table public.cofre_bills     enable row level security;
alter table public.cofre_goals     enable row level security;
alter table public.cofre_snapshots enable row level security;

-- Policies (select + insert + update + delete via "all")
create policy "own_state"     on cofre_state     for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own_cats"      on cofre_cats      for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own_txs"       on cofre_txs       for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own_bills"     on cofre_bills     for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own_goals"     on cofre_goals     for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own_snapshots" on cofre_snapshots for all using (auth.uid()=user_id) with check (auth.uid()=user_id);

-- ============================================================
-- Realtime (habilita broadcast de mudanças nas tabelas)
-- ============================================================
begin;
  drop publication if exists supabase_realtime;
  create publication supabase_realtime;
commit;

alter publication supabase_realtime add table cofre_cats;
alter publication supabase_realtime add table cofre_txs;
alter publication supabase_realtime add table cofre_bills;
alter publication supabase_realtime add table cofre_goals;
alter publication supabase_realtime add table cofre_snapshots;
