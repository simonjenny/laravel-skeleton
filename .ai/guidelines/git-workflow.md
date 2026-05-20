# Git Workflow & CI/CD Guidelines

## Conventional Commits — MANDATORY

All commits in this project use the **Conventional Commits** format.
This is automatically enforced by `commitlint` in the CI pipeline on every PR.

**Format:**
```
<type>[optional scope]: <description>
```

**Types and their effect on versioning:**

| Type | Description | Release |
|------|-------------|---------|
| `feat:` | New feature for the user | Minor (`1.x.0`) |
| `fix:` | Bug fix for the user | Patch (`1.0.x`) |
| `feat!:` | Breaking change | Major (`x.0.0`) |
| `chore:` | Maintenance, dependency updates | — |
| `docs:` | Documentation only | — |
| `refactor:` | Code restructuring, no new feature | — |
| `style:` | Formatting, whitespace, Pint fixes | — |
| `test:` | Adding or updating tests | — |
| `perf:` | Performance improvements | — |
| `ci:` | CI/CD pipeline changes | — |

**Examples:**
```bash
git commit -m "feat: add CSV export to user list"
git commit -m "fix: validation fails when phone number contains spaces"
git commit -m "chore: update pest to 3.1"
git commit -m "test: add smoke tests for dashboard resource"
git commit -m "refactor: move invoice logic into InvoiceService"
git commit -m "feat!: rename API endpoints to follow REST conventions"
```

**Breaking changes** (major version bump):
```bash
# Option 1: ! after type
git commit -m "feat!: drop support for PHP 8.3"

# Option 2: BREAKING CHANGE footer
git commit -m "feat: redesign auth flow

BREAKING CHANGE: session tokens are no longer accepted, use bearer tokens"
```

When prompted to write a commit message, always use this format.
Never use vague messages like "update", "fix stuff", "wip", or "changes".

## Branch Strategy

```
main                    ← protected, only via PR
└── feature/my-feature  ← work here, open PR when ready
└── fix/login-bug       ← bugfix branches
└── chore/update-deps   ← maintenance branches
```

## Pull Request Flow

1. Open PR from feature branch → `main`
2. CI runs automatically:
   - **commitlint**: validates all commit messages in the PR
   - **tests**: runs `./vendor/bin/pest`
   - **pint**: runs `./vendor/bin/pint --test`
3. All checks must pass before merging
4. Merge to `main` → semantic-release runs automatically

## Automated Release via semantic-release

After a PR is merged to `main`, the `release.yml` workflow analyses all commits since the last release:

- Contains `feat:` → new minor release (e.g. `v1.3.0`)
- Contains `fix:` → new patch release (e.g. `v1.2.1`)
- Contains `feat!:` or `BREAKING CHANGE` → new major release (e.g. `v2.0.0`)
- Only `chore:`, `docs:`, `style:`, etc. → **no release created**

semantic-release automatically:
- Calculates the next version (semver)
- Creates a GitHub Release with generated release notes
- Tags the commit

## Docker CI (if enabled)

When a GitHub Release is published, `docker.yml` runs **only if** the repository variable `ENABLE_DOCKER_BUILD=true` is set (Settings → Secrets and variables → Actions → Variables).

Steps:
1. Login to GHCR
2. Build Docker image tagged with release version + `latest`
3. Trivy security scan (blocks on CRITICAL/HIGH vulnerabilities)
4. Push both tags to `ghcr.io/<owner>/<repo>`

## Dependency Updates (Dependabot)

Dependabot opens PRs weekly for:
- Composer packages (`composer.json`)
- npm packages (`package.json`)
- GitHub Actions (monthly)

These PRs run through the full CI pipeline. Review and merge if tests pass.
Since Dependabot commits follow Conventional Commits format (`chore(deps): ...`), they do not trigger a release.
