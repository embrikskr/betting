create table if not exists public.bets (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  date date not null,
  stake numeric not null check (stake >= 0),
  type text not null check (type in ('single','combo')),
  status text not null default 'pending' check (status in ('pending','win','loss')),
  note text
);
create table if not exists public.bet_legs (
  id uuid primary key default gen_random_uuid(),
  bet_id uuid not null references public.bets(id) on delete cascade,
  bookie text not null,
  event text not null,
  pick text not null,
  odds numeric not null check (odds >= 1),
  status text not null default 'pending' check (status in ('pending','win','loss'))
);
alter table public.bets enable row level security;
alter table public.bet_legs enable row level security;
drop policy if exists "Public can read bets" on public.bets;
drop policy if exists "Only admin can write bets" on public.bets;
drop policy if exists "Public can read bet_legs" on public.bet_legs;
drop policy if exists "Only admin can write bet_legs" on public.bet_legs;
create policy "Public can read bets" on public.bets for select using (true);
create policy "Public can read bet_legs" on public.bet_legs for select using (true);
create policy "Only admin can write bets" on public.bets for all to authenticated using (auth.uid() in ('d8733af0-b889-498b-9c76-6b5d602df5f8'::uuid,'ded5aa78-4651-4841-a717-eaaf880672a1'::uuid)) with check (auth.uid() in ('d8733af0-b889-498b-9c76-6b5d602df5f8'::uuid,'ded5aa78-4651-4841-a717-eaaf880672a1'::uuid));
create policy "Only admin can write bet_legs" on public.bet_legs for all to authenticated using (auth.uid() in ('d8733af0-b889-498b-9c76-6b5d602df5f8'::uuid,'ded5aa78-4651-4841-a717-eaaf880672a1'::uuid)) with check (auth.uid() in ('d8733af0-b889-498b-9c76-6b5d602df5f8'::uuid,'ded5aa78-4651-4841-a717-eaaf880672a1'::uuid));
