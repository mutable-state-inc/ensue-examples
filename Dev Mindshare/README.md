# Dev Mindshare Example

This repo shows in 3 steps how to wire Ensue as a persistent memory network for coding agents (Codex, Claude) so you can get a “memory-first” experience and share/see how other developers think about coding (style, infra decisions, patterns). The notes below explain how to set up, run, and what to say to your agent. 

<img width="600" alt="image" src="https://github.com/user-attachments/assets/da5911d7-12d1-497c-8233-d97c64930a2e" />


## What you get
- A ready-to-use Ensue instruction set for coding agents, such as Claude Code or Codex.
- Starter prompts so first-time users know what to say.

## Prerequisites
- Codex CLI or Claude with MCP support installed.

## Getting Started

### Step 1: Set the API Key and Add the MCP Server

Set the API key:

```bash
export ENSUE_API_KEY="lmn_695bff5b5b6d4bfe82ffaf2ee9c1167c"
```

Then add the Ensue MCP server:

Claude:
```bash
claude mcp add --transport http ensue-memory \
  https://www.ensue-network.ai/api/ \
  --header "Authorization: Bearer $ENSUE_API_KEY"
```

Codex:
```bash
codex mcp add ensue-memory \
  --url https://www.ensue-network.ai/api/ \
  --bearer-token-env-var ENSUE_API_KEY
```

### Step 2: Download instructions and start Claude/Codex
- Claude users: download `CLAUDE.md` into your project directory before starting Claude.
- Codex users: download `AGENTS.md` into your project directory before starting Codex.
- Open the project in your agent and start; the file is auto-loaded as high-priority instructions.

### Step 3: Start coding

- Ask Claude or Codex:  
```bash
Hey, load any Ensue memories for this project and give me a one-line status on what you already know.
```

- After a few prompts after you've started coding, ask Claude or Codex the following to verify it's working:
  - “What did you save to Ensue for this project? Any general takeaways or feedback for me?”
  - "Based on the memories on Ensue, how are others thinking about [infra and aws deployments]?"

## What the agent will do (per `dev-mindshare.md`)
- On session start: load relevant memories (coding style, preferences, mistakes, architecture, todo, tools, experiments).
- During work: automatically store preferences, tool choices, mistakes fixed, decisions, and experiments with structured keys (e.g., `personal/coding-style/<project>/<slug>`), embedding summaries for search.
- Use correct visibility prefixes (`personal/`, `friends/`, `coworkers/`) based on context; defaults to `friends/` unless clearly private (then `personal/`), or explicitly team-shared (`coworkers/`).
- If Ensue is unavailable, it will mention that memory is disabled and continue stateless.

## Repo contents
- `AGENTS.md` — Auto-applied instructions for Codex users (copied from `dev-mindshare.md`).
- `CLAUDE.md` — Auto-applied instructions for Claude users (copied from `dev-mindshare.md`).
- `README.md` — This overview and quick-start guide.

## Tips for a smooth first run
- Keep your first task small (“audit the API routes” or “add a new React page”) so you can see memories being created.
- Ask: “What did you save to Ensue for this project?” after a few prompts to verify memory is working.
- If you’re collaborating, decide whether project-level memories should live under `coworkers/` (shared) or stay `personal/` (private).

## Next steps / advanced
- Get your own `ENSUE_API_KEY` and swap it into the install commands. The included demo key has restricted permissions; your own key lets you update keys, create private-only memories (e.g., personal front-end preferences), and control visibility per prefix.
DM me (https://x.com/christinetyip) or submit this form (https://forms.gle/d4Cg5LEP9scs6XJE6) to get your own personal key. I'll probably try to automate this process later, but for now, you can expect a response within 24 hours.
- Package the core flow as a Skill in Claude or Codex if you want a reusable toggle you can carry across repos or share with teammates. Use it to quickly enable/disable Ensue behaviors without renaming files.
