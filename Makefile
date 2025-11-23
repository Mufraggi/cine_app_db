DB_CONTAINER_NAME := cine_app
DB_VOLUME_NAME := my-postgres-volume
DB_PORT := 5432
DB_NAME := cine_app
DB_USER := user
DB_PWD := password

.PHONY: start-db-container
start-db-container:
	docker run --name $(DB_CONTAINER_NAME) \
		-v $(CURDIR)/data:/var/lib/postgresql \
		-e POSTGRES_USER=$(DB_USER) \
		-e POSTGRES_PASSWORD=$(DB_PWD) \
		-e POSTGRES_DB=$(DB_NAME) \
		-p $(DB_PORT):$(DB_PORT) \
		-d pgvector/pgvector:0.8.1-pg18-trixie
	

.PHONY: stop-db-container
stop-db-container:
	docker stop $(DB_CONTAINER_NAME)
	docker rm $(DB_CONTAINER_NAME)

.PHONY: new
new:
	dbmate -u "postgres://$(DB_USER):$(DB_PWD)@localhost:$(DB_PORT)/$(DB_NAME)" new $(migration_name)

.PHONY: migrate
migrate:
	dbmate -u "postgres://$(DB_USER):$(DB_PWD)@localhost:$(DB_PORT)/$(DB_NAME)?sslmode=disable" up

.PHONY: rollback
rollback:
	dbmate -u "postgres://$(DB_USER):$(DB_PWD)@127.0.0.1:$(DB_PORT)/$(DB_NAME)?sslmode=disable" down

.PHONY: print_url
print:
	echo "postgres://$(DB_USER):$(DB_PWD)@localhost:$(DB_PORT)/$(DB_NAME)"


.PHONY: dump_ci
dump_ci:
	dbmate -u "postgres://$(DB_USER):$(DB_PWD)@localhost:$(DB_PORT)/$(DB_NAME)?sslmode=disable" dump > postgres_test.sql

.PHONY: migrate_ci_doc
migrate_ci_doc:
	dbmate -u "postgres://$(DB_USER):$(DB_PWD)@postgres:$(DB_PORT)/$(DB_NAME)?sslmode=disable" up


.PHONY: help
help:
	@echo "Available targets:"
	@echo "  start-db-container    : Start PostgreSQL container."
	@echo "  stop-db-container     : Stop and remove PostgreSQL container."
	@echo "  migrate               : Run database migrations."
	@echo "  rollback              : Rollback the last database migration."
