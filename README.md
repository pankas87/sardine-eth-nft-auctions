# README

## System Requirements

* [rvm](https://rvm.io/): Ruby Version Manager (or Ruby v3.1.0 with Bundler) 
* [SQLite](https://www.sqlite.org/index.html) (Mandatory)

## Installation


```bash
# Install the required Ruby Version
rvm install 3.1.0
rvm use 3.1.0

# Install the project dependencies
bundle install

# Execute the migrations
bundle exec rake db:migrate
```

## Starting up the server

```bash
bundle exec rails s -p 8080
```

## Test Suite

```bash
bundle exec rspec
```
