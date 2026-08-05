━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# CLAUDE.md — Inspire Academic Platform Context
## Read this before every session. This is the standing brief.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## WHO WE ARE

Inspire Vision™ is a world-class learning and character formation 
ecosystem. The mission: to equip individuals — particularly young people 
— to excel academically, grow in character and faith, flourish in health 
and wellbeing, and lead with purpose.

The ambition: to be one of the top two organisations in its field 
globally. The benchmark organisations are Apple (design excellence and 
ecosystem thinking), NASA (mission clarity and engineering rigour), and 
Khan Academy (educational reach and accessibility).

The driving conviction:
"Take Africa by storm. Leave Europe speechless. Get North America 
thinking: what in the world just happened here?"

Africa has 1.4 billion people. Over 60% are under 25. This platform is 
built for them — not as a charitable gesture, but as a world-class 
response. Built by Africa, for Africa, offered to the world.

---

## THE FOUR CARDINALS

Everything Inspire Vision does flows from four dimensions of calling:

| Cardinal | Theme | Domain |
|---|---|---|
| Inspire Academic™ | Rigour & Excellence | inspireacademic.org |
| Mentorship & Formation™ | Meaning & Character | inspirevision.org/mentorship/ |
| Health & Wellbeing™ | Healing & Innovation | inspirevision.org/health/ |
| Faith & Spiritual Formation™ | Truth & Transformation | inspirevision.org/faith/ |

Inspire Academic™ is the first and most developed cardinal. The other 
three live as modules within inspirevision.org and will graduate to 
their own domains as the organisation grows.

---

## THIS REPOSITORY

**Repo:** inspire-academic (github.com/inspire-academic/inspire-academic)
**Live site:** inspireacademic.org
**Deployed via:** Netlify (auto-deploy on push to main)
**Staging branch:** staging → staging.inspireacademic.org
**Stack:** Vanilla HTML/CSS/JS + Supabase + Netlify Functions

NEVER push directly to main. Always push to staging first, 
verify, then merge to main.

---

## TECHNICAL PRINCIPLES — NON-NEGOTIABLE

These govern every decision made in this repo:

1. MOBILE-FIRST
   All CSS written for mobile (320px) first. Media queries only ever 
   add styles for larger screens using min-width. Never desktop-first.
   Test on Safari iOS and Chrome Android before any feature is complete.

2. DESIGN TOKENS AS SINGLE SOURCE OF TRUTH
   assets/css/tokens.css defines every colour, font, spacing value, 
   and breakpoint. No other file redefines these. When the brand 
   evolves, one file changes and the platform updates.

3. API-FIRST BACKEND
   Every Netlify function is a clean REST API endpoint — not a 
   page-specific helper. Named by resource and action:
   /api/v1/assessment/generate — never /netlify/functions/generate-question
   Every function has documented inputs, consistent JSON outputs, and 
   graceful error handling: { success: false, error: { code, message } }
   The future mobile app will call these same endpoints.

4. CARDINAL MODULE PATTERN
   Each cardinal follows the same folder pattern:
   public pages at module root → onboarding/ → dashboard/ → portal/ → admin/
   Consistency means any developer who knows one cardinal can navigate 
   another immediately.

5. PROGRESSIVE WEB APP (PWA)
   Both sites are PWAs. Students can install on iOS and Android without 
   an app store. Service workers cache subject modules for offline use.
   A student in rural Kano with intermittent connectivity deserves the 
   same quality experience as a student in central London.

6. SEPARATION OF CONCERNS
   HTML for structure. CSS for appearance. JavaScript for behaviour.
   No inline styles. No inline scripts. Ever.

7. NEVER BUILD A DEAD END
   Every technical decision must be reversible or forward-compatible.
   Dead ends to avoid:
   - Storing user data in localStorage instead of Supabase
   - Hardcoding content in HTML instead of loading from database
   - Building Netlify functions that are page-specific, not resource-specific
   - Any pattern that works at 100 users but requires a rebuild at 10,000

---

## TARGET FILE STRUCTURE

This is the agreed target structure. All work moves toward this:

inspire-academic/
│
├── index.html                  ← Homepage / landing
├── dashboard.html              ← Student dashboard (post-login)
├── manifest.json               ← PWA manifest
├── sw.js                       ← Service worker
├── CLAUDE.md                   ← This file
├── netlify.toml
│
├── subjects/                   ← Subject dashboard pages
│   ├── physics.html
│   ├── chemistry.html
│   ├── biology.html
│   └── maths.html
│
├── student/                    ← Student-facing tool pages
│   ├── assessment.html
│   ├── flashcards.html
│   ├── quiz.html
│   ├── revision.html
│   ├── revision-pack.html
│   ├── required-practicals.html
│   ├── progress.html
│   └── lessons.html
│
├── teacher/                    ← Teacher-facing pages
│   ├── teacher.html
│   ├── teaching-cockpit.html
│   ├── teacher-assessment-create.html
│   ├── teacher-revision.html
│   └── admin-teacher-mgmt.html
│
├── parent/                     ← Parent-facing pages
│   ├── parent-dashboard.html
│   ├── parent-login.html
│   └── parent-child-details.html
│
├── tools/                      ← Standalone learning tools
│
├── icons/                      ← PWA icons
│   ├── icon-192.png
│   ├── icon-512.png
│   ├── apple-touch-icon.png
│   └── favicon.ico
│
├── assets/
│   ├── css/
│   │   ├── tokens.css          ← Single source of truth for all tokens
│   │   ├── global.css
│   │   ├── components.css
│   │   └── utilities.css
│   ├── js/
│   │   ├── app.js
│   │   ├── supabase.js
│   │   └── perf-utils.js
│   └── images/
│       ├── physics/
│       ├── chemistry/
│       ├── biology/
│       └── maths/
│
├── netlify/
│   ├── edge-functions/
│   └── functions/
│
└── supabase/
    └── academic_schema.sql

Files to leave in place temporarily (do not move yet):
  property/     — will move to separate private repo later
  mileiq.html   — will remove later

---

## DESIGN SYSTEM

Brand: Inspire Academic™
Typography: Fraunces (display/headings) + Plus Jakarta Sans (body)
Base colour: #0b1628 (dark navy)
Gold accent: #c9a84c (brand moments only — never overused)

Subject accent colours:
  Physics:   #1d4ed8 → #06b6d4 (blue to cyan gradient)
  Chemistry: #059669 → #34d399 (deep to light green)
  Biology:   #7c3aed → #a78bfa (deep to light purple)
  Maths:     #d97706 → #fbbf24 (deep to light amber)

Dark/light theme toggle is present on all subject pages.
  localStorage key: "ia-theme" — values: "dark" | "light"

  Design philosophy: Apple-level craft. Every pixel intentional.
  Whitespace is not empty space — it is breathing room.
  3D depth via inset shadows, not drop shadows.
  Spring physics on all interactive elements:
    --spring-out: cubic-bezier(.34,1.56,.64,1)
    --spring-in:  cubic-bezier(.36,0,.66,-.56)

  Afrofuturism is the long-term design direction — bold with purpose,
  culturally grounded, future-forward. Every design decision should
  make a young person in Accra feel this was built for them.

---

## LEARNING PHILOSOPHY

  Mastery, not time. Students do not move to the next concept until
  they have genuinely understood the current one. The platform knows
  the difference.

  Culturally grounded content. Examples, scientists, word problems,
  and case studies are rewritten around African context wherever
  possible. Excellence must feel native, not foreign.

  Ubuntu learning. Learning is a community act — not a transaction
  between an individual and a platform. Students belong to pods of
  5-7 peers. Teaching others is built into the progression system.

  The whole person. Academic, mentorship, health, faith — four
  dimensions of one person. The unified Life Dashboard shows a
  learner across all four cardinals.

---

## SUPABASE DATABASE

  Project: inspect via existing supabase.js client in assets/js/
  Auth: Supabase Auth (email + Google OAuth)
  Storage: "avatars" bucket for profile photos

  Schema is NOT fully version-controlled. Only lessons/lesson_progress
  (supabase/academic_schema.sql) and leads (supabase/leads_schema*.sql)
  have tracked migrations — everything else was created directly in the
  Supabase dashboard, so it can drift out from under any list written
  here. Before assuming a table's columns or relationships, grep the
  codebase for `.from('table_name')` to see how it's actually used —
  that's the only thing that can't go stale the way this list did.

  A sample of tables nearly everything touches, illustrative only —
  not the full schema, and not authoritative on exact columns:
    profiles         — unified user row (role: student/teacher/parent/admin)
    subjects, topics, quizzes, questions — content + question bank
    quiz_attempts, topic_progress, streaks — student progress/mastery
    srs_cards, srs_stats — flashcard spaced-repetition state
    parent_profiles, student_parent_links — parent-child account linking

  Tables to add (Phase 2):
    learning_events   — every interaction timestamped
    learner_profiles  — adaptive profile per student
    ai_conversations  — AI tutor history
    intervention_flags — at-risk signals

  RLS: Every table must have Row Level Security policies.
  Students read only their own data.
  Teachers read only their assigned students data.
  Admins have full access within their cardinal.

  Current reality: one shared Supabase project, hosted in London
  (eu-west-2), serves all learners — UK and African alike. UK data
  therefore stays in the UK; African learner data is transferred to
  and stored in the UK under appropriate legal safeguards.
  Regional storage for African learners (e.g. a Cape Town region)
  is a future goal, not yet built — treat it as a real infrastructure
  project (new project + data migration + cutover) if it's picked up,
  not a quick config change.

---

## CURRENT LIVE PAGES

  Subject dashboards (inspireacademic.org):
    /physics.html    — Physics v2.0, fully designed, images live
    /chemistry.html  — Chemistry v1.0, images live
    /biology.html    — Biology v1.0, images live
    /maths.html      — Maths v1.0, images live

  All four subject pages feature:
    - Full-bleed hero banner with real photography
    - Apple Watch-style 3-ring progress indicator
    - 8 topic cards with real images, progress bars, status
    - Continue Your Journey with lesson thumbnail
    - Skills Lab 2x3 grid
    - Subject quote with background image
    - Liquid glass sidebar with dark/light theme toggle
    - Hardcoded placeholder data — Supabase wiring is Phase 2

  Student-facing rules (non-negotiable):
    - Students must always be greeted by their registered first name
    - Never display "Student" or an email address as a name
    - The initial avatar is the fallback — real photo upload is Phase 3

---

## MIGRATION ROADMAP

  Phase 1 — Foundation & Restructure (CURRENT)
    File structure reorganisation into target folder layout
    PWA files: manifest.json, sw.js, icons/
    supabase/academic_schema.sql stub
    Root cleanup
    All internal links updated
    Deploy staging → verify → merge to main

  Phase 2 — Design Tokens & CSS Architecture
    Extract shared CSS from all HTML files into:
      assets/css/tokens.css     — all design tokens
      assets/css/components.css — all shared components
      assets/css/global.css     — base/reset styles
    Each subject page links these files, keeps subject-specific
    overrides only. Eliminates 4x duplicated CSS.

  Phase 3 — Live Supabase Data
    Wire all subject dashboards to real student data:
      student name, year, avatar, progress %, streak,
      quiz counts, grade, topic completion per subject
    Follow existing auth patterns in dashboard.html

  Phase 4 — Mentorship Module Build (inspirevision.org)
    6 public pages, onboarding, dashboard, mentor-portal, admin
    mentorship_schema.sql with full RLS

  Phase 5 — AI Learning Engine
    learning_events schema activated
    Adaptive learning paths
    AI tutor integration (Anthropic API)
    Early warning system for struggling students

  Phase 6 — Ubuntu Social Layer
    Learning pods (5-7 students)
    Pay-It-Forward engine
    Community recognition and badges

  Phase 7 — Continental Scale
    Cloudflare CDN (African PoP: Lagos, Nairobi, Johannesburg)
    Performance budgets enforced on every PR
    Supabase Cape Town as primary region

  Phase 8 — Inspire Mobile App
    React Native calling the same Supabase + Netlify API
    Same auth, same data, same AI — only the UI is new

---

## PERFORMANCE BUDGETS

  These are hard limits. Do not ship a feature that breaks them:

    Time to First Contentful Paint:  < 1.5s on 3G mobile
    Time to Interactive:             < 3.5s on 3G mobile
    Total initial page weight:       < 200KB compressed
    LCP (Core Web Vitals):           < 2.5s
    CLS (Core Web Vitals):           < 0.1
    Image weight per page:           < 100KB total (WebP, lazy-loaded)
    JS bundle (initial load):        < 80KB compressed

  All images must be WebP. Never commit JPEG or PNG as defaults.
  Always use loading="lazy" on below-fold images.
  Always use fetchpriority="high" on hero images.

---

## BRANCHING & DEPLOYMENT

  main     → production (inspireacademic.org) — NEVER commit directly
  staging  → preview — all work lands here first
  feature/ → feature branches, merged to staging when complete

  Commit message convention:
    feat:     new feature
    fix:      bug fix
    refactor: restructure without behaviour change
    style:    CSS/design changes only
    chore:    config, tooling, cleanup

  One file at a time rule — never modify perf-utils.js and
  dashboard.html in the same commit without confirming both
  are consistent. A previous site-breaking incident was caused
  by inconsistent simultaneous edits to these files.

---

## KEY CONSTRAINT TO ALWAYS REMEMBER

  This platform serves students on mobile devices with
  intermittent connectivity across Africa. Every technical
  decision must pass this test:

  "Does this work for a student in rural Kano on a
   mid-range Android phone with 2G connection?"

  If the answer is no, the decision needs to change.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
End of CLAUDE.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
