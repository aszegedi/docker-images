default: build-image;

list-builders:
	docker buildx ls

create-mybuilder:
	docker buildx create --name mybuilder

switch-to-mybuilder:
	docker buildx use mybuilder

start-mybuilder:
	docker buildx inspect --bootstrap

stop-mybuilder:
	docker buildx stop mybuilder

build-images:
	docker buildx build --platform linux/amd64,linux/arm64 -t aszegedi/node-yarn-jre . --push
