# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

`2.3.1`

* System dependencies

- paperclip
- postgresql

* Configuration

We use next environment variables for configuration:

- `DATABASE_PASSWORD` for database password in production


* Database creation

```
cp config/database.yml.sample config/database.yml
rake db:create:all
```

* Database initialization

`rake db:migrate db:seed`

* How to run the test suite

`rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

Deployment will be implemented using Capistrano
