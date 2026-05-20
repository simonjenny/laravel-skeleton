# Laravel Skeleton – Claude Code Context

This is an opinionated Laravel 12 skeleton used as a `composer create-project` template.
Projects created from this skeleton inherit all configuration, workflows, and guidelines.

## Project Stack

- **PHP** ^8.4 · **Laravel** ^12.0
- **Frontend** Tailwind CSS 4 · Vite 5
- **Server** FrankenPHP + Caddy (Alpine Docker image)
- **Database** SQLite (default for new projects)
- **Testing** Pest 3 + pest-plugin-laravel
- **Code Style** Laravel Pint
- **Dev Terminal** SoloTerm (Solo)

## Key Conventions

### Directory Structure
- Routes live in `routes/` (Laravel standard — NOT in `app/Routes/`)
- No `app/Console/` directory by default — add commands as needed
- Config overrides in `config/` (see `solo.php`, `envexample.php` for custom configs)

### Commit Messages — REQUIRED FORMAT
**All commits MUST follow [Conventional Commits](https://www.conventionalcommits.org).**
This is enforced by `commitlint` in CI on every pull request.

```
<type>: <short description>

Types:
  feat:     new feature          → triggers minor release (1.x.0)
  fix:      bug fix              → triggers patch release (1.0.x)
  chore:    maintenance, deps    → no release
  docs:     documentation only  → no release
  refactor: code restructure     → no release
  style:    formatting, pint     → no release
  test:     adding/fixing tests  → no release
  perf:     performance          → no release

Breaking changes → add ! after type or BREAKING CHANGE in footer:
  feat!: redesign API structure  → triggers major release (x.0.0)
```

Examples:
```
feat: add user profile picture upload
fix: password reset link expires too early
chore: update tailwind to 4.2
docs: add deployment instructions to README
refactor: extract payment logic into service class
test: add smoke tests for admin panel resources
```

### Development Workflow
1. Create a feature branch
2. Write code + tests
3. Commit using Conventional Commits format
4. Open a Pull Request → CI runs automatically (commitlint + tests + pint)
5. Merge to `main` → semantic-release creates a GitHub Release automatically
6. GitHub Release → Docker image built + Trivy scanned + pushed to GHCR
7. Deploy manually

### Testing
- Framework: **Pest 3**
- Run tests: `./vendor/bin/pest`
- Always write tests for new features
- See `.ai/guidelines/` for framework-specific testing rules

### Code Style
- Formatter: **Laravel Pint**
- Run locally: `./vendor/bin/pint`
- CI will reject PRs that fail `pint --test`

## GitHub Actions (Templates for New Projects)

All workflows in `.github/workflows/` are templates copied to new projects via `composer create-project`.

| File | Trigger | Purpose |
|------|---------|---------|
| `ci.yml` | Pull Request | commitlint + Pest + Pint |
| `release.yml` | Push to `main` | semantic-release → GitHub Release |
| `docker.yml` | GitHub Release published | Build → Trivy → Push to GHCR |
| `dependabot.yml` | Weekly | Dependency update PRs |

**Docker builds are opt-in:** Set repository variable `ENABLE_DOCKER_BUILD=true` in GitHub Settings to activate `docker.yml`.

## Optional Packages (not pre-installed)

These are NOT in `composer.json` by default — add per project:

```bash
# Admin panel
composer require filament/filament:"^5.0"
php artisan filament:install --panels

# Reactive components (included via Filament if installed)
composer require livewire/livewire:"^4.0"
```

See `.ai/guidelines/filament.md` for Filament-specific coding rules.

## Environment

- Default locale: `de` (Swiss German projects)
- Default DB: SQLite (`database/database.sqlite` — gitignored)
- HTTPS forced in non-local environments (`AppServiceProvider`)
- All proxies trusted (`trustProxies(at: '*')`) for containerised deployments

## Deployment

```bash
# On server — pull latest image and restart
echo $TOKEN | docker login ghcr.io -u $USER --password-stdin
docker compose pull
docker compose up -d --remove-orphans
```
