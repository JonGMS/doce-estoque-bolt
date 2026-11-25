/*
# Revoke anon privileges on clientes

1. Purpose
- The `clientes` table was created with default grants that included the `anon` role,
  unlike every other table in the Doce Estoque schema, which is authenticated-only.
- Although RLS policies scope all rows to `auth.uid() = user_id` (so anon sees no rows),
  the lingering grants are inconsistent with the authenticated-only access model.

2. Security changes
- REVOKE SELECT, INSERT, UPDATE, DELETE ON clientes FROM anon.
- No changes to `authenticated` grants or policies; no data is modified.

3. Notes
- Idempotent: revoking from a role without privileges is a no-op.
*/

REVOKE SELECT, INSERT, UPDATE, DELETE ON clientes FROM anon;
