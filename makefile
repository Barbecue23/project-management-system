up:
	docker-compose up -d

image:
	docker build -t test .

down:
	docker-compose down

rs:
	rails server

test:
	rails test