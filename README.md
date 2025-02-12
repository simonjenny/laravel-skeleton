# Opinionated Laravel Skeleton

### A opinionated skeleton for Laravel projects based on my own preferences.

It includes the following:

- Moved Routes
- Removed Health Checks Routes
- FrankenPHP [Dockerfile](Dockerfile) with [Caddyfile](Caddyfile)
- Modified [composer.json](composer.json) to install Nodejs Packages
- Modified [.gitignore](.gitignore)

### Added Packages

Look at [composer.json](composer.json)

### Create a new Project with this Skeleton

```bash
composer create-project simonjenny/laravel-skeleton NAME
```

### Create Filament Panel and User

```bash
php artisan filament:install --panels
php artisan make:filament-user
```
