# Project memory

## Product intent & audience

- **Doce Estoque**: inventory/order management app in Portuguese for small confectionery/sweet-making businesses.
- Manages products, stock, orders (encomendas), recipes (receitas), and customers (clientes).
- Authenticated users access only their own data per Supabase RLS.

## Brand personality & voice

- Simple, direct Portuguese (pt-BR) UI labels: “Entrar no Doce Estoque”, “Cadastrar”, “Novo Produto”, “Montar encomenda”, “Voltar”.
- Production-quality but unfussy; identity is preserved across corrective changes.

## Visual design & UX direction

- Stack: Vite + React (JSX), Tailwind CSS, Lucide React icons; `@/` alias → `src/`.
- Shared CSS in `src/index.css` drives reusable patterns: search field icon centered vertically with text recede; icon-only buttons fixed square with centered icon; page header stacks Voltar above title with 12px gap (10px mobile).
- Primary accent color: rose/pink (hover/focus-visible indicators use darker rose and pink outline).
- Spacing convention: 16px between last form field and primary button; 12px header gap.
- Login/Cadastro toggle is a real button: cursor pointer, visible hover, focus-visible outline.
- Responsive: icon alignment and spacing validated for desktop and mobile breakpoints.

## Decisions, constraints & rationale

- Avoid duplicate UI package installs; use only lucide-react for icons, Tailwind for styling.
- Reuse shared containers/components to fix cross-screen issues (search field, icon buttons, page header) rather than per-screen patches.
- Orders list reload: `ClientOrderScreens.tsx` emits a save-confirmed signal; `App.tsx` listens and re-fetches via existing data routine (same used for product save / order delivery).
- No duplicate rows: Supabase creates the order once; reload is read-only.
- Filters/pagination respected on reload; if new order is hidden by filters, save confirmation still shows.
- On save failure: error message shown, form data preserved.
- Supabase security: all tables (incl. clientes) restricted to authenticated users via RLS; anonymous grants revoked.

## Open questions & assumptions

- Visual/interaction testing deferred to user preview (no browser in agent environment); type-check, production build, and Supabase config validated programmatically.
- Assumes existing data-fetch/invalidation routine in App.tsx is the canonical refresh path for all list views.