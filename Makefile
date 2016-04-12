KEY=~/.ssh/id_rsa

up: docker-compose.override.yml
	docker-compose up -d

docker-compose.override.yml: docker-compose.override.template
	cp $< $@