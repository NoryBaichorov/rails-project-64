setup:
	bin/setup
	bin/rails db:seed
	yarn

start:
	bin/dev

console:
	bin/rails console

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bin/rails test

lint:
	rubocop

.PHONY: test