APP_NAME := sigs
SRC := src/cmd/main.go
OUTPUT_DIR := build

.PHONY: all build clean

all: build

build:
	@mkdir -p $(OUTPUT_DIR)
	GOOS=linux GOARCH=amd64 go build -o $(OUTPUT_DIR)/$(APP_NAME)-linux-amd64 $(SRC)
	GOOS=linux GOARCH=arm64 go build -o $(OUTPUT_DIR)/$(APP_NAME)-linux-arm64 $(SRC)
	GOOS=darwin GOARCH=amd64 go build -o $(OUTPUT_DIR)/$(APP_NAME)-darwin-amd64 $(SRC)
	GOOS=darwin GOARCH=arm64 go build -o $(OUTPUT_DIR)/$(APP_NAME)-darwin-arm64 $(SRC)
	GOOS=windows GOARCH=amd64 go build -o $(OUTPUT_DIR)/$(APP_NAME)-windows-amd64.exe $(SRC)

docker-build:
	docker build -t $(APP_NAME):latest .

docker-publish: docker-build
	docker tag $(APP_NAME):latest ghcr.io/$(APP_NAME):latest
	docker push  ghcr.io/$(APP_NAME):latest

run:
	docker run --rm -it -p 8080:8080 $(APP_NAME):latest

clean:
	rm -rf $(OUTPUT_DIR)