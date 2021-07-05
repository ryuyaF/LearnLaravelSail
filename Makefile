init:
	cp .env.example .env
	docker run --rm \
		-u "$(id -u):$(id -g)" \
		-v $(pwd):/opt \
		-w /opt \
		laravelsail/php80-composer:latest \
		composer install --ignore-platform-reqs
	./vendor/bin/sail up -d
	./vendor/bin/sail artisan key:generate
	./vendor/bin/sail artisan storage:link
	./vendor/bin/sail exec laravel.test chmod -R 777 storage bootstrap/cache
	@migrate
	@seed
migrate:
	./vendor/bin/sail artisan migrate
seed:
	./vendor/bin/sail artisan db:seed
