up:
	docker compose up -d
	@make front-dev
create-next-app:
	docker compose run --rm frontend npx create-next-app@13.1.1 src --use-npm --ts
migrate:
	docker compose run --rm backend python3 manage.py migrate
down:
	docker-compose down --remove-orphans
restart:
	@make down
	@make up
front-dev:
	docker compose exec frontend bash -c "cd src && npm run dev"
front-build:
	docker compose exec frontend bash -c "cd src && npm run build"
front-prod:
	docker compose exec frontend bash -c "cd src && npm run start"
