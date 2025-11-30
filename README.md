# Task Management App

A simple task management application built with Ruby on Rails.

## Ruby version

- Ruby 3.4.5 (`.ruby-version`)

## System dependencies

- Rails ~> 7.2.1 ([Gemfile](Gemfile))
- PostgreSQL (see [config/database.yml](config/database.yml))
- Node.js (for asset compilation if needed)
- Bootstrap 5.3 ([Gemfile](Gemfile))
- Other gems: `bcrypt`, `dartsass-rails`, `importmap-rails`, `turbo-rails`, `stimulus-rails`, `brakeman`, `rubocop-rails-omakase`

## Configuration

- Copy `config/database.yml.sample` to `config/database.yml` and update credentials if needed.
- Set up environment variables for database and secrets (see `.env*` and `config/master.key`).

## Database creation & initialization

```sh
bin/rails db:setup
```

## How to run the test suite

```sh
bin/rails test
```

## Example curl request for submatrix API

To find the largest submatrix of 1s in a binary matrix, you can use the following curl command.

The API accepts an input matrix (N x M) containing only 1s and 0s as elements, and returns a submatrix of maximum size with all 1s.

**Example input matrix:**
```ruby
matrix = [
  [1, 0, 1, 1],
  [0, 1, 0, 1],
  [1, 1, 1, 0],
  [1, 1, 1, 1]
]
```

**Expected largest submatrix of 1s:**
```ruby
[
  [1, 1, 1],
  [1, 1, 1]
]
```

**Curl request:**
```sh
curl -X POST http://localhost:3000/max_submatrix \
  -H "Content-Type: application/json" \
  -d '{"matrix": [[1,0,1,1],[1,1,1,0],[0,1,1,1]]}'
```