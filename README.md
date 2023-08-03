# Bulletin Board 2

## Install Devise

```
rails generate devise:install
```
## Set a root route

```ruby
# config/routes.rb

root "boards#index"
```

## Generate user account

```
rails generate devise user
```

## Set sign out to GET

```
# config/initializers/devise.rb, Line 269

config.sign_out_via = :get
```
