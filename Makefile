DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

build:
	mkdir -p /home/crasche/data/mariadb
	mkdir -p /home/crasche/data/wordpress
	# MacOS:
	# mkdir -p /Users/christian.rasche/crasche/data/mariadb
	# mkdir -p /Users/christian.rasche/crasche/data/wordpress
	docker compose  -f $(DOCKER_COMPOSE_FILE) up --build -d
kill:
	docker compose -f $(DOCKER_COMPOSE_FILE) kill
down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down
clean:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	rm -rf /home/crasche/data/mariadb
	rm -rf /home/crasche/data/wordpress
	# MacOS:
	# rm -rf /Users/christian.rasche/crasche/data/mariadb
	# rm -rf /Users/christian.rasche/crasche/data/wordpress
	docker system prune -a -f

restart: clean build

.PHONY: kill build down clean restart
