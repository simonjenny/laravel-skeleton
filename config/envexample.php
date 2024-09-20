<?php

return [

    /* Create a copy/backup of current env.example at start */

    'create_bakup' => false,
    'backup_file_name' => 'env.example.bak',

    /* All keys in this array will not be cleared upon copying to .env.example */

    'keep' => [
        'APP_NAME',
        'APP_ENV',
        'APP_DEBUG',
        'APP_TIMEZONE',
        'APP_MAINTENANCE_DRIVER',
        'BCRYPT_ROUNDS',
        'APP_LOCALE',
        'APP_FALLBACK_LOCALE',
        'APP_FAKER_LOCALE',
        'LOG_CHANNEL',
        'LOG_STACK',
        'LOG_DEPRECATIONS_CHANNEL',
        'LOG_LEVEL',
        'DEBUGBAR_ENABLED',
        'VITE_APP_NAME',
        'SESSION_DRIVER',
        'SESSION_LIFETIME',
        'SESSION_ENCRYPT',
        'SESSION_PATH',
        'SESSION_DOMAIN',
        'BROADCAST_CONNECTION',
        'FILESYSTEM_DISK',
        'QUEUE_CONNECTION',
        'CACHE_STORE',
        'CACHE_PREFIX',
        'MEMCACHED_HOST'
    ],

    /* All keys in this array will not be copyied to .env.example */

    'ignore' => [],

];
