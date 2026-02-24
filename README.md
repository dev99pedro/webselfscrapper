# README

## Autenticação JWT (backend)

O projeto possui autenticação JWT via API em `api/v1`.

### Endpoints

- `POST /api/v1/auth/register`
	- body JSON:
		- `user.email`
		- `user.password`
		- `user.password_confirmation`
- `POST /api/v1/auth/login`
	- body JSON:
		- `email`
		- `password`
- `GET /api/v1/auth/me`
	- requer header: `Authorization: Bearer <token>`

### Resposta de login/register

Retorna:

- `token` (JWT)
- `user.id`
- `user.email`

### Setup

1. `bundle config set --local path vendor/bundle`
2. `bundle install`
3. `bundle exec rails db:migrate`

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
