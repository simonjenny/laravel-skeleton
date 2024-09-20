<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        @vite(['resources/css/app.css', 'resources/js/app.js'])

    </head>
    <body class="font-sans antialiased dark:bg-black dark:text-white/50">
        <div class="h-screen flex items-center justify-center bg-gray-50 text-black/50 dark:bg-black dark:text-white/50">

            <div class="text-3xl">
                Laravel Skeleton App
            </div>

        </div>
    </body>
</html>
