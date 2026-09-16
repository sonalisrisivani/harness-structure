# Next.js Fullstack Engineering Workspace

## Tech Stack
- Next.js 14+ (App Router)
- React Server Components (RSC) & Server Actions
- Tailwind CSS
- TypeScript (Strict Mode)

## Engineering Standards
- Default to **Server Components**. Use `'use client'` only when React hooks (useState, useEffect) or browser APIs are required.
- Do NOT use React Class Components.
- Implement Server Actions for data mutations instead of API Routes where possible.
- Use Tailwind utility classes for all styling.
- Follow mobile-first responsive design.

## Claude Actions & Harness
- Run `/pr` when ready to submit pull requests.
- Engage `@architecture-reviewer` for major React tree changes.
- Prettier/ESLint formatting scripts are configured via hooks.
