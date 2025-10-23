-- TABELL
create table if not exists public.bets (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  date date not null,
  bookie text not null,
  event text not null,
  pick text not null,
  stake numeric not null check (stake >= 0),
  odds numeric not null check (odds >= 1),
  status text not null check (status in ('pending','win','loss'))
);
alter table public.bets enable row level security;

-- Alle kan lese
create policy if not exists "Public can read bets"
on public.bets for select
using (true);

-- Kun disse admin-UIDs kan skrive
drop policy if exists "Only admin can write" on public.bets;
create policy "Only admin can write"
on public.bets for all
to authenticated
using (auth.uid() in ('d8733af0-b889-498b-9c76-6b5d602df5f8'::uuid, 'ded5aa78-4651-4841-a717-eaaf880672a1'::uuid))
with check (auth.uid() in ('d8733af0-b889-498b-9c76-6b5d602df5f8'::uuid, 'ded5aa78-4651-4841-a717-eaaf880672a1'::uuid));
