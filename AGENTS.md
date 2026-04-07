# AGENTS.md
Guidance for autonomous coding agents working in this repository.

## Repository Snapshot
- Primary language: Bash shell scripts.
- Supporting assets: AppleScript (`close_all_apps.scpt`) and Docker Compose (`docker-compose.yml`).
- Build systems detected: none (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml` absent).
- Test framework: none configured.
- Lint/format framework: none configured in-repo.

## Source Layout
- `alv-all`: runs AppleScript to close apps on macOS.
- `el sif`: creates or deactivates Python virtual environments.
- `run-docker-cmd`: parses Dockerfile `CMD` lines and executes them.
- `set_env_vars.sh`: sets GitHub environment secrets from `.env`.
- `close_all_apps.scpt`: compiled AppleScript (binary format).
- `docker-compose.yml`: local Postgres/Redis/Mongo stack.

## Build, Lint, and Test Commands
This repo has no formal build pipeline; use script-level checks.

### Build
- No compile/build step required for Bash scripts.
- Optional local infra commands:
  - `docker compose up -d`
  - `docker compose down`

### Lint
- Preferred lint: `shellcheck` for every changed shell script.
- Lint all scripts:
  - `shellcheck "alv-all" "el sif" "run-docker-cmd" "set_env_vars.sh"`
- Lint one script:
  - `shellcheck "set_env_vars.sh"`
- If `shellcheck` is unavailable, run syntax checks with `bash -n`.

### Test
- No automated tests are present.
- Use focused runtime checks plus syntax checks.
- Syntax-check all scripts:
  - `bash -n "alv-all"`
  - `bash -n "el sif"`
  - `bash -n "run-docker-cmd"`
  - `bash -n "set_env_vars.sh"`

### Single-Test Guidance (Important)
Because there is no test harness, a "single test" means one focused scenario.

- `set_env_vars.sh` argument validation:
  - `bash "set_env_vars.sh"`
  - Expect usage output and non-zero exit.
- `el sif` create venv branch:
  - `bash "el sif" testenv`
  - Verify `testenv/` exists, then clean up.
- `el sif` deactivate branch:
  - `bash "el sif" --off`
- `run-docker-cmd` parsing/execution path:
  - `bash "run-docker-cmd" /path/to/Dockerfile`
  - Use a harmless Dockerfile fixture.
- `alv-all` smoke check (macOS only):
  - `bash "alv-all"`
  - Expect `osascript` to run without path errors.

## Runtime and Tooling Expectations
- Bash is the execution shell (`#!/bin/bash` in scripts).
- `alv-all` is macOS-specific (`osascript`).
- `set_env_vars.sh` requires `gh` CLI and authenticated GitHub session.
- `run-docker-cmd` requires `jq`.
- `el sif` requires `python` with `venv` support.
- `docker compose` is only needed for compose workflows.

## Code Style Guidelines
Apply these rules to all new or edited scripts.

### Shebang and Script Safety
- Use `#!/bin/bash`.
- Prefer `set -euo pipefail` near top of file.
- If strict mode is intentionally not used, include a short reason.

### Formatting
- Use 2-space indentation inside control structures.
- Keep lines around 100 chars or less when practical.
- Keep one command per line.
- Separate logical sections with a blank line.

### Imports / Dependencies
- Bash has no imports; dependency checks must be explicit.
- Validate required tools early, near entrypoint.
- Pattern:
  - `command -v gh >/dev/null || { echo "gh is required" >&2; exit 1; }`
- Fail with actionable, user-facing messages.

### Quoting and Expansion
- Quote variables: `"$var"`, `"${arr[@]}"`.
- Use `${var}` for non-trivial expansions.
- Prefer `$(...)` over backticks.
- Avoid `eval`; if unavoidable, sanitize inputs and document risk.

### Types and Data Handling (Bash)
- Treat all variables as strings unless arithmetic is explicit.
- Use `local` inside functions to avoid global leakage.
- Use arrays for tokenized command parts rather than string concatenation.
- Parse line-based input with `while IFS= read -r line; do ... done`.

### Naming Conventions
- New filenames should be lowercase and hyphenated or underscored.
- Do not add new filenames containing spaces.
- Use uppercase for env/config constants (`REPO`, `ENVIRONMENT`).
- Use lowercase snake_case for locals/functions (`parse_args`, `dockerfile_path`).

### Argument Parsing
- Provide `usage()` for help and invalid args.
- Parse args with `while [[ "$#" -gt 0 ]]; do case "$1" in ...`.
- Validate required args immediately after parsing.
- Return non-zero exit code for invalid invocation.

### Error Handling
- Send error messages to stderr (`>&2`).
- Use explicit checks for file existence/readability before processing.
- Separate user errors (bad input) from runtime errors (missing tool, command failure).
- Exit non-zero on unrecoverable failures.

### Security and Secrets
- Never print secret values.
- Avoid storing real credentials in `.env` within the repo.
- In secret-sync flows, log only key names.
- Be careful executing text parsed from user-controlled files.

### Platform and Portability
- Keep Bash-first approach; do not silently downgrade to POSIX `sh`.
- Isolate platform-specific behavior behind OS checks when adding new logic.
- Preserve existing macOS behavior where script intent is macOS-only.

## Docker Compose Conventions
- Keep YAML indentation at 2 spaces.
- Keep service names lowercase and descriptive.
- Use named volumes for persistent state.
- Keep port mappings explicit.

## Documentation Expectations
- Update `README.md` when script behavior or arguments change.
- Include at least one copy-paste usage example for new scripts.
- Keep examples aligned with actual filenames in this repo.

## Cursor/Copilot Rules
- `.cursor/rules/`: not present.
- `.cursorrules`: not present.
- `.github/copilot-instructions.md`: not present.
- If these files appear later, merge their instructions here and treat them as higher priority.

## Agent Workflow Checklist
- Run `bash -n` on each touched script.
- Run `shellcheck` on each touched script when available.
- Execute at least one focused runtime scenario per changed script.
- Keep changes minimal and avoid unrelated refactors.
- Do not rewrite script behavior unless task explicitly asks for it.
