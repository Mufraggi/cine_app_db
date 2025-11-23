DB_CONTAINER_NAME := my-postgres
DB_VOLUME_NAME := my-postgres-volume
DB_PORT := 5432
DB_NAME := mydb
DB_USER := user
DB_PWD := password

.PHONY: start-db-container
start-db-container:
	docker run --name $(DB_CONTAINER_NAME) \
		-v $(CURDIR)/data:/var/lib/postgresql/data \
		-e POSTGRES_USER=$(DB_USER) \
		-e POSTGRES_PASSWORD=$(DB_PWD) \
		-e POSTGRES_DB=$(DB_NAME) \
		-p $(DB_PORT):$(DB_PORT) \
		-d postgres


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
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  start-db-container    : Start PostgreSQL container."
	@echo "  stop-db-container     : Stop and remove PostgreSQL container."
	@echo "  migrate               : Run database migrations."
	@echo "  rollback              : Rollback the last database migration."
