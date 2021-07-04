# LearnLaravelSail
検証用リポジトリ

## How to install composer dependencies

`cp .env.example .env`

```
docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v $(pwd):/opt \
    -w /opt \
    laravelsail/php80-composer:latest \
    composer install --ignore-platform-reqs
```

`sail artisan key:generate`

`sail artisan migrate --seed`
