up: image
	docker compose up -d

image:
	docker build -t test .

down:
	docker compose down -v

rs:
	rails server

test:
	rails test

lint:
	bundler exec rubocop -A