---
name: visual-docs
description: Use when asked to explain, document, visualize, map, or make an HTML explainer for a repo, feature, module, agent system, prompt stack, provider routing, business flow, or code pipeline. Produces fact-first standalone HTML from source evidence, with graph.json, examples, system map, domain flow, guided read order, and click-to-explain nodes.
---

# Visual Docs

Make code understandable fast. Facts first. Short text. No server.

Main mental model: **progressive disclosure + domain ladder + scenarios**.

- First screen starts with one plain sentence: what repo does. No intro fluff.
- Start from one entry point. Then branch.
- Start from domain/business meaning, not code internals.
- Every block has a concrete example.
- Every block answers: what enters, what happens, what comes out.
- Context: what problem the repo solves.
- Containers/folders: top folders and packages.
- Components/abstractions: modules, classes, commands, services, prompts, schemas.
- Code nodes: key files/functions only.
- Scenarios: real examples traced through structure.

## Language

- `SKILL.md` stays English.
- Generated docs use the user's requested language.
- If user language is unknown, use the repo's README language; fallback English.
- No emoji in generated docs, README, section titles, labels, or examples.
- Use ASCII punctuation in the skill itself.

## Runtime Dependencies

The skill itself must have no runtime dependency.

- Do not require Python, Node, npm, a browser server, or a package install to use the skill.
- Python/Node helper scripts are allowed only as optional convenience for large repos or validation.
- If Python is missing, still produce `graph.json` and `index.html` directly with available editor/shell tools.
- Generated `index.html` must be standalone and work from `file://`.
- Manual install must always be possible by copying `skills/visual-docs/` into the target agent's skill directory.

## Understanding Mechanics

Use these proven shapes, but keep them tiny:

- **Golden path**: one normal path from entry point to output. Show first.
- **Branch map**: 2-4 important forks after the golden path.
- **C4-lite**: Context -> Containers/Folders -> Components/Abstractions -> Code nodes.
- **Domain story**: actor -> action -> object -> result. Good for non-dev view.
- **Sequence/swimlane**: Entry -> Command/API -> Core -> Data -> UI/Tests.
- **Dependency map**: who owns, who calls, who depends, what breaks.
- **Focus map**: one fixed clickable web. Center = repo job. Ring = domain, flows, layers, abstractions, artifacts. Click opens side detail.
- **Hot spots**: risky files/functions, why risky, test evidence.
- **Diataxis split**: examples teach, flow helps do, anatomy describes, unusual concepts explain.

Do not name these frameworks in the HTML unless useful. Use their shape.

Two lenses:

- **Human view**: what problem it solves, main flow, visible output, examples.
- **Developer view**: folders, abstractions, data model, call/dependency flow, tests, risks.

Default page shape must go simple -> detailed:

```text
one-line repo job
-> project input/output
-> domain/business view
-> focus map / clickable structure web
-> product/use-case flows
-> system/layer map
-> repo anatomy
-> abstractions
-> examples + code drilldown
```

## Content Structure Rules

Do not dive into files first. Build an understanding ladder:

1. **Project job**
   - one sentence: what this repo does
   - no implementation words unless they are the product
2. **Project I/O**
   - what enters the project
   - what the project does to it
   - what comes out
   - real example
3. **Domain / business view**
   - actors, objects, actions, outcomes
   - not folder names
   - example: Developer -> runs `/understand` -> gets graph + dashboard
4. **Focus map / clickable structure web**
   - one compact visual map, not a huge mind map
   - center node: repo job or feature job
   - surrounding groups: Domain, Flows, Layers, Abstractions, Artifacts
   - 12-18 nodes max by default
   - each node click opens side detail: what, why, input, output, example, source
   - source evidence is required for every node
   - on mobile, collapse the map to a simple list with the same click detail
5. **Product / use-case flows**
   - 3-5 user workflows
   - each workflow: trigger -> steps -> output -> source
   - each workflow has a real example
6. **System layers**
   - Entry -> Commands/API -> Workers/Services -> Core -> Data -> UI -> Tests
   - show where each flow crosses layers
   - include one example path across layers
7. **Repo anatomy**
   - folders and responsibilities
   - each folder row has example file/command/test
8. **Abstraction map**
   - commands/classes/functions/schemas/stores/components
   - each abstraction has input, output, used by, example
9. **Code drilldown**
   - only after the above
   - clickable node details

Every major section must include an **Example** block:

```text
Example
Input: /understand
Path: command -> agents -> core schema -> graph JSON -> dashboard
Output: searchable knowledge graph
Source: README.md:130
```

If a section has no real example, do not invent one. Write:

```text
No real example found.
Searched: tests, README, fixtures, demos.
```

## Visual Layout Rules

Goal: readable first. Clean, compact, developer-readable. More graphics, less prose. No bloated cards.

Default visual style: **Clay-minimal**.

Use only the useful parts of Clay-style systems:

- Warm cream canvas, not cold gray: `#fffaf0` or close.
- Near-black ink: `#0a0a0a`.
- Body text uses Inter/system sans, 16px, line-height about 1.55.
- Display text uses weight 500-600, not heavy 800.
- Rounded cards: 16px normal cards, 24px feature/flow cards.
- No heavy shadows. Depth comes from background color, border, and spacing.
- Saturated accent cards are allowed, but only for key flows/examples.
- Use 4-6 accent colors max: pink, teal, lavender, peach, ochre, cream.
- Do not repeat the same accent color twice in a row.
- Use product/code/UI fragments inside colored cards instead of decorative blobs.
- Do not invent 3D illustrations, mascots, icons, or fake screenshots.
- Keep footer/light ending cream; no dark footer.
- No emojis.

Use a small design contract in every standalone HTML:

```css
:root {
  --s1: 4px; --s2: 8px; --s3: 12px; --s4: 16px;
  --s5: 24px; --s6: 32px; --s7: 48px; --s8: 64px;
  --section: 96px;
  --page: 1280px;
  --read: 760px;
  --radius: 16px;
  --radius-xl: 24px;
  --canvas: #fffaf0;
  --ink: #0a0a0a;
  --body: #3a3a3a;
  --muted: #6a6a6a;
  --hairline: #e5e0d3;
}
```

Rules:

- Use only the spacing scale above for margin, padding, gap, and section rhythm.
- Page max width: 1180-1280px. Never let content sprawl full-width on large screens.
- Reading width for prose/detail areas: 640-820px. Do not stretch short text across a huge panel.
- Section rhythm: 64-96px between major sections, 16-24px between heading and content.
- First viewport must show headline, stats, Golden Path start, and a hint of Repo Anatomy.
- Use readable cards. Default card padding 20-24px. Use 28-32px only for feature/flow cards.
- Avoid giant equal-height cards. If cards get tall, convert to rows/table/rail.
- Grid items should not stretch just because a neighbor is tall. Use `align-items: start`.
- Empty space is okay between sections, not inside cards/panels.
- Max columns:
  - Golden Path: 3 columns default for text-heavy docs. Use 5 only for tiny icon-like steps.
  - Examples: 2-3 columns.
  - Folder/abstraction maps: 3-4 columns, or compact table if more than 8 items.
  - Stats: chips only.
- Typography scale:
  - H1 48-72px desktop, 34-42px mobile.
  - H2 32-44px.
  - Card H3 18-24px.
  - Body 16px.
  - Evidence/source 11-12px mono.
  - Line height 1.45-1.6.
- Evidence is metadata, not main content. Put it in small mono footer/chip, never as big text.
- Long paths must wrap safely: `overflow-wrap: anywhere`.
- Long prose must stay normal: avoid `overflow-wrap:anywhere` on headings/body unless a long path requires it.
- Use tables/definition rows for repeated data (`Path`, `Owns`, `Used by`, `Source`).
- If definition rows make values wrap badly, switch them to one-column metadata rows.
- Use left-to-right rail/sequence for flows, not random card clouds.
- Do not nest cards inside cards.
- Keep shadows minimal or zero; use border + background layering for structure.
- Use warm canvas plus limited saturated accent cards. Do not make the page monochrome.
- Use icons only if already available locally; no CDN, no external assets.
- Do not use emojis.
- On mobile, collapse to one column and keep every section readable without horizontal scroll, except fixed System Map may scroll.

Visual primitives to prefer:

- `rail`: numbered steps connected left-to-right.
- `table`: folder/abstraction rows with aligned columns.
- `swimlane`: Entry -> Command/API -> Core -> Data -> UI/Test.
- `matrix`: who owns / who calls / what breaks.
- `detail drawer`: click node -> why, callers, deps, risk, evidence.

Node Explorer readability:

- Sidebar item height 52-76px, not huge cards.
- Sidebar item shows: title, type, short path. No paragraph blocks.
- Detail panel uses one readable column for summary + facts.
- Use definition rows for facts: Why, Called by, Depends on, Risk, Source.
- Do not make `Why/Called by/Depends on/Risk` into separate big cards if content is short.
- Detail panel height follows content. It must not stretch to match the sidebar list.
- If there is little detail, show a small `What to inspect next` list instead of blank space.

Before final, visually check:

- no big empty holes
- no text overflow
- no giant cards with one short sentence
- headings align to the same left edge
- related items have smaller gaps than unrelated sections
- source/evidence is visible but visually quiet
- page looks good at 1440px and mobile width

Default output:

```text
docs/{feature}/
  graph.json   # source data for audit/agents
  index.html   # standalone, works with file:// double-click
```

Only create extra files if user asks:

```text
ONBOARDING.md  # optional
PLAN.md        # optional
```

## Non-Negotiable

- `index.html` must work from `file://`. No local server.
- Build `graph.json` first.
- Embed exact `graph.json` copy inside `index.html`:

```html
<script type="application/json" id="graph-data">
{...}
</script>
```

- `fetch("./graph.json")` is optional only. Embedded JSON is required.
- Every claim has source evidence.
- Every doc has examples. Minimum 2, target 3-5.
- No invented examples. If none found, show "No real examples found" + searched places.
- Keep text short, caveman-clear: "what", "why", "risk", "source".
- Do not make huge mind map. Use fixed System Map.
- Do not require build tools, Vite, React, local HTTP, CDN, or external assets.
- Do not write fragile generator scripts unless repo size makes manual HTML impossible.
- Do not use browser-global element ids in JS (`title.textContent`, `stats.innerHTML`). Always use `document.getElementById` or a local `$()` helper.
- Validate inline JS syntax before opening: extract non-JSON scripts and run `new Function(script)`.

## Ignore Noise

Skip unless user asks:

```text
node_modules/ .git/ dist/ build/ out/ coverage/ .next/ .nuxt/
.turbo/ .cache/ target/ vendor/ venv/ .venv/ __pycache__/
*.lock package-lock.json yarn.lock pnpm-lock.yaml bun.lockb
*.min.js *.min.css *.map *.generated.* *.gen.* *.snap
*.png *.jpg *.jpeg *.gif *.webp *.svg *.ico *.woff *.woff2 *.ttf
*.mp4 *.mov *.zip *.tar *.gz
```

Respect `.gitignore`. Do not skip `.claude`, `.codex`, `.agents`, `.wolf` when documenting agent/plugin systems; these often contain useful rules.

## Workflow

1. Scope exact feature/repo.
2. Build repo anatomy first:
   - top folders
   - package/workspace layout
   - where runtime code lives
   - where commands/skills live
   - where UI lives
   - where tests/examples live
   - where generated/state files live
3. Read entry points:
   - README usage
   - package scripts
   - CLI commands
   - route handlers
   - exported handlers
   - skill/plugin definitions
4. Find real abstractions:
   - classes
   - exported functions
   - modules/packages
   - commands/skills
   - agents/prompts
   - schemas/types
   - stores/context/builders
5. Find real examples:
   - tests
   - fixtures
   - demo commands
   - README examples
   - sample JSON
   - constants/config
6. Trace live path:
   - imports
   - calls
   - reads/writes
   - config/env
   - prompts/tools/providers for AI systems
7. Build compact `graph.json`.
8. Build standalone `index.html` with embedded `graph-data`.
9. Open `index.html`.
10. Verify folder map, abstractions, examples, click/search work.

## graph.json Shape

Keep small. 15-60 useful nodes by default. More only when needed.

```json
{
  "project": {
    "name": "string",
    "feature": "string",
    "summary": "string",
    "generatedAt": "ISO string",
    "gitCommit": "string or unknown",
    "sourceRoot": "string"
  },
  "stats": [{ "label": "Entry Points", "value": "3" }],
  "folders": [
    {
      "path": "packages/core",
      "role": "Graph schema/search core",
      "owns": ["schema", "SearchEngine"],
      "relatesTo": ["packages/dashboard", "skills/*"],
      "evidence": ["packages/core/src/schema.ts:1"]
    }
  ],
  "layers": [{ "id": "core", "name": "Core", "description": "Main logic" }],
  "abstractions": [
    {
      "id": "SearchEngine",
      "kind": "class|function|module|schema|command|agent|component|store",
      "filePath": "packages/core/src/search.ts",
      "line": 27,
      "what": "Fuzzy search over graph nodes",
      "usedBy": ["context-builder"],
      "dependsOn": ["Fuse.js", "GraphNode"],
      "exampleIds": ["ask-question"]
    }
  ],
  "nodes": [
    {
      "id": "file:src/index.ts",
      "type": "file|function|class|route|component|config|prompt|service|agent|skill|data|test|domain|flow|step",
      "layer": "core",
      "name": "index.ts",
      "filePath": "src/index.ts",
      "line": 1,
      "summary": "Short factual summary.",
      "why": "Why this exists.",
      "calledBy": ["node-id"],
      "dependsOn": ["node-id"],
      "risk": "low|medium|high",
      "riskReason": "What can break.",
      "evidence": ["src/index.ts:1"]
    }
  ],
  "edges": [
    {
      "source": "node-id",
      "target": "node-id",
      "type": "imports|calls|contains|routes_to|reads|writes|validates|configures|spawns|uses_prompt|uses_model|tests|flow_step|depends_on|documents",
      "confidence": "EXTRACTED|INFERRED|AMBIGUOUS",
      "evidence": "src/index.ts:1",
      "why": "direct import/call/etc"
    }
  ],
  "examples": [
    {
      "name": "Real use case",
      "source": "test.ts:42",
      "input": "real input",
      "path": ["entry", "step", "step", "output"],
      "output": "real output",
      "whyItMatters": "What this proves."
    }
  ],
  "goldenPath": {
    "title": "Main path",
    "entry": "README command / API route / UI action",
    "steps": ["Entry point", "Handler", "Core logic", "Data artifact", "Visible output"],
    "output": "what user gets",
    "evidence": ["README.md:10"]
  },
  "branchFlows": [
    {
      "name": "Error path or secondary use case",
      "steps": ["Start", "Decision", "Branch", "Output"],
      "why": "why this branch matters",
      "evidence": ["test.ts:42"]
    }
  ],
  "guidedTour": [
    { "order": 1, "title": "Start here", "nodeIds": ["node-id"], "reason": "why read first" }
  ],
  "domain": {
    "flows": [
      {
        "name": "Business or technical flow",
        "steps": ["Request", "Validate", "Process", "Persist", "Respond"],
        "sourceNodeIds": ["node-id"],
        "evidence": ["README.md:10"]
      }
    ]
  },
  "focusMap": {
    "nodes": [
      {
        "id": "repo",
        "label": "Repo job",
        "group": "center",
        "x": 50,
        "y": 50,
        "what": "Short factual node meaning.",
        "why": "Why this node matters.",
        "input": "What enters.",
        "output": "What comes out.",
        "example": "Real example from README/test/source.",
        "source": "README.md:10"
      }
    ],
    "links": [{ "source": "repo", "target": "node-id", "type": "contains" }]
  },
  "hotspots": [{ "nodeId": "node-id", "reason": "why risky", "risk": "high" }],
  "unknowns": ["unproven fact or ambiguity"]
}
```

## HTML Must Have

One standalone `index.html`. Short labels. Dense but readable.

Sections:

1. **What This Repo Does**
   - required first block
   - one sentence, plain
   - no marketing, no "powerful", no intro
   - example: "This repo scans a codebase, builds a knowledge graph, and opens a dashboard so an AI assistant can understand files, links, flows, and change risk."
2. **Golden Path**
   - required
   - one normal path from first entry point to output
   - 4-6 cards max
   - each card: actor/entry, action, data, next step, source
   - this answers ordinary-person view first
3. **Repo Anatomy**
   - required
   - folder tree/table
   - each folder: role, owns, relates to, source evidence
   - show only useful folders; skip assets/build noise
4. **Focus Map**
   - required for non-trivial repos
   - fixed clickable web, not physics, not a giant mind map
   - center node: repo job
   - groups: Domain, Flows, Layers, Abstractions, Artifacts
   - node click opens right-side detail drawer
   - detail shows: what, why, input, output, real example, source
   - max 18 nodes unless user asks for deep map
5. **Branch Flow**
   - required
   - from golden path to important forks
   - use 2-4 clean pipeline cards
   - each card: start, owner folder, abstraction, data, output, source
6. **Examples**
   - required
   - real scenarios from tests/README/fixtures
   - each example: input, path, output, what it proves
7. **Abstraction Map**
   - required
   - modules/classes/functions/commands/agents/schemas/components
   - show who owns what and who uses what
   - this answers: "what abstraction lives where?"
8. **System Map**
   - fixed columns, no physics
   - suggested columns: Entry -> UI/API -> Commands -> Core -> Data -> External -> Tests
   - node click opens detail
9. **Unusual Concepts**
   - required when repo has non-obvious concepts
   - short dev-focused cards
   - example: "graph as durable context", "1-hop expansion", "domain view"
10. **Architecture Notes**
   - required
   - short dev-focused notes: workspace/package layout, runtime boundaries, data artifacts
11. **Guided Tour**
   - read order: entry -> core -> data/external -> UI/API -> tests
12. **Domain View**
   - business/technical flow, not file tree
   - example: Payment -> Checkout -> Validate -> Charge -> Receipt
13. **Useful Dev Notes**
   - short facts: where to change commands, where graph schema lives, where tests live, what is risky
14. **Node Explorer**
   - search
   - layer/type filter
   - click node detail:
     - why exists
     - called by
     - depends on
     - risk
     - source evidence
     - related examples

Optional if useful:
- "Hot spots" small section
- "Unknowns" small section

## Repo Anatomy Required

Do not start with abstract node graph. Start with folder/module structure.

Good shape:

```text
repo/
  understand-anything-plugin/     owns actual plugin
    skills/                       user commands: /understand, /understand-diff
    agents/                       prompts used by pipeline
    packages/core/                schema/search/validation
    packages/dashboard/           React graph viewer
    src/                          chat/diff/explain/onboard helper builders
    src/__tests__/                proof examples
  homepage/                       marketing/demo site, not plugin runtime
  install.sh                      installer/symlink setup
```

For each folder show:

```text
Path: packages/core
What: graph schema + search core
Owns: schema.ts, search.ts, validation
Used by: dashboard, chat, diff, explain
Evidence: packages/core/src/schema.ts:1
```

## Abstraction Map Required

Show actual abstractions, not just files.

For TypeScript/JS repos include:
- exported functions/classes
- React components
- schemas/types
- stores/context builders
- CLI/skill commands
- agents/prompts

Good shape:

```text
Command /understand
  -> agent project-scanner
  -> agent file-analyzer
  -> schema validateGraph
  -> writes knowledge-graph.json

SearchEngine
  file: packages/core/src/search.ts
  used by: buildChatContext()
  input: query + graph nodes
  output: relevant node ids
```

If repo has no classes, use modules/functions/commands as abstractions. Do not force OOP terms.

## Better Than Mind Map

Default is System Map, not radial mind map.

Good:

```text
Entry        Commands        Core              Data           Tests
README   ->  /understand ->  schema.ts    ->   graph.json <-  builder.test.ts
```

Rules:
- left-to-right
- fixed columns
- no force physics
- no moving nodes
- no hover layout shift
- max 60 visible nodes by default
- if dense, show important nodes only

## Example Rule

Examples must be scenarios, not loose cards. Each scenario must connect folder -> abstraction -> files -> output.

Example card required:

```text
Use case: Diff impact
Source: diff-analyzer.test.ts:38
Input: changed file src/service.ts
Path: changed file -> changed node -> child nodes -> affected nodes -> affected layers
Output: risk analysis
Why it matters: proves blast-radius flow
```

Must be real. Derived examples allowed only if labeled `derived from code` and source cited.

For each repo, prefer 4 scenario examples:

1. Happy path: main command/request/user action.
2. Search/query path.
3. Change/diff/error path.
4. UI/dashboard/render path or domain/business flow.

Each scenario must answer:
- where starts
- which folder owns it
- which abstraction handles it
- what data moves
- where output lands
- source evidence

## Caveman Text Rule

Use short UI copy:

```text
Does: scans repo -> builds graph -> opens dashboard
Why: lets AI understand code without reading everything
Risk: stale graph = bad answers
Source: README.md:134
```

Avoid:
- long paragraphs
- marketing copy
- vague "powerful insights"
- repeated explanations

## Validation

Before final:

- `graph.json` parses.
- `index.html` contains `id="graph-data"`.
- `index.html` opens directly via `file://`.
- inline JS syntax validates; no DOM id globals.
- No required server.
- First block is one plain sentence saying what repo does.
- Golden Path exists and starts from one entry point.
- Repo Anatomy exists and names folders + roles.
- Branch Flow exists before examples.
- Abstraction Map exists and names real modules/classes/functions/commands.
- Examples visible near top.
- Every example has source.
- Every example links to folder + abstraction + output.
- Search works.
- Node click shows detail.
- Domain flow exists.
- Guided tour exists.
- No placeholder text.
- No invented facts.
- No console error if checked.

Open:

```bash
open docs/{feature}/index.html
```

If local server needed, output is wrong. Fix embedded JSON.
