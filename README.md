# Opinionated Laravel Skeleton

### A opinionated skeleton for Laravel projects based on my own preferences.

It includes the following:

- Standard `routes/` directory (Laravel convention)
- Health Check Route (`/up`) — used by Docker healthcheck
- FrankenPHP [Dockerfile](Dockerfile) with [Caddyfile](Caddyfile)
- Modified [composer.json](composer.json) to install Node.js packages
- Modified [.gitignore](.gitignore)

### Added Packages

Look at [composer.json](composer.json)

### Create a new Project with this Skeleton

```bash
composer create-project simonjenny/laravel-skeleton NAME
```

> **Note:** During project creation, `laravel/boost` automatically installs Claude AI skills
> from [`jeffallan/claude-skills`](https://github.com/jeffallan/claude-skills) (Laravel Specialist).
> This gives Claude Code context about Laravel best practices for this project.
> Remove the `boost:add-skill` line from `composer.json` if you don't want this.

### GitHub Actions (included as templates)

Every project gets these workflows out of the box:

| Workflow | Trigger | What it does |
|----------|---------|--------------|
| [`ci.yml`](.github/workflows/ci.yml) | Pull Request | commitlint + Pest tests + Pint code style |
| [`release.yml`](.github/workflows/release.yml) | Push to `main` | Creates a GitHub Release via [semantic-release](https://semantic-release.gitbook.io) |
| [`docker.yml`](.github/workflows/docker.yml) | GitHub Release published | Builds Docker image, Trivy scan, pushes to GHCR |
| [`dependabot.yml`](.github/dependabot.yml) | Weekly (scheduled) | PRs for outdated Composer, npm & Action dependencies |

Commits follow the **[Conventional Commits](https://www.conventionalcommits.org)** format:

```
feat: add user profile picture upload   → minor release (1.x.0)
fix: fix password reset link expiry     → patch release (1.0.x)
chore: update tailwind to 4.2           → no release
```

**Required GitHub secrets & variables:**
- `GITHUB_TOKEN` — built-in, no setup needed (for semantic-release)
- `TOKEN` — GitHub PAT with `write:packages` scope (for pushing to GHCR)
- `ENABLE_DOCKER_BUILD` — Repository Variable (not secret), set to `true` to activate `docker.yml`
  → Settings → Secrets and variables → Actions → Variables → New repository variable

**Recommended branch protection for `main`:**
- Require pull request before merging
- Require status checks: `commitlint`, `tests`, `pint`

### Deploy with Docker

Edit [compose.yml](compose.yml) and set:
- `container_name` — your project name
- `image` — your full GHCR image path (e.g. `ghcr.io/simonjenny/yourproject:latest`)

### Create Database and Run Migrations
```bash
php artisan migrate
```

### Optionally: Install Filament Admin Panel

```bash
composer require filament/filament:"^5.0"
php artisan filament:install --panels
php artisan make:filament-user
```

### Update Languages
```bash
php artisan lang:update
```

### Install Laravel Boost
```bash
php artisan boost:install
```
