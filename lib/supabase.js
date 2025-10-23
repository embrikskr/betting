const { createClient } = window.supabase;
const { SUPABASE_URL, SUPABASE_ANON_KEY } = window.APP_CONFIG;
window.sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: { persistSession: true, autoRefreshToken: true }
});
