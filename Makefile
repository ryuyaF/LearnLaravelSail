sail = ./vendor/bin/sail

init:
	cp .env.example .env
	docker run --rm \
		-u "$(shell id -u):$(shell id -g)" \
		-v $(shell pwd):/opt \
		-w /opt \
		laravelsail/php80-composer:latest \
		composer install --ignore-platform-reqs
	$(sail) up -d
	$(sail) artisan key:generate
	$(sail) artisan storage:link
	$(sail) exec laravel.test chmod -R 777 storage bootstrap/cache
	@migrate
	@seed
migrate:
	$(sail) artisan migrate
seed:
	$(sail) artisan db:seed
