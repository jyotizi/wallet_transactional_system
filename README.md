# Project Name - Wallet Transactional System

The Wallet Transactional System is a secure application that enables seamless management of digital wallet transactions, including credits and debits, for users.

## Table of Contents

- [Technology Stack](#technology-stack)
- [Setup](#setup)
- [API Endpoints](#api-endpoints)

## Technology Stack

### RUBY
  Installed ruby version
- **Ruby 3.0.0**: Programming language used in Rails development.
  ### with RVM
  - \curl -sSL https://get.rvm.io -o rvm.sh
  - rvm install ruby-x.x.x
  ### with rbenv
  - curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
  - rbenv install rbenv-x.x.x


### Prerequisites
  Needed to run the appplication on the machine:
  - ruby-3.0.0
  - rails-7.1.3.4

  1. Clone the repository:
  - git clone https://github.com/jyotizi/wallet_transactional_system.git

  2. `cd wallet_transactional_system`

  3. Run `bundle install`

  4. `create database.yml from example_database.yml and update the usename and password`

  5. Run `rails db:create`

  6. Run `rails db:migrate`

  7. Run `rails db:seed`

  8. Run `rails s`

## API Endpoints

 ### `POST \login`
  #### Request URL -
    http://localhost:3000/login
  #### Request BODY - 
    {
      "email": "johndoe@example.com",
      "password": "john@123",
    }
  #### Response -
    {
      "message": "Loged in successfully!",
      "data": {
        "user_id": 2
      },
      "errors": null
    }
 ### `DELETE \logout`
  #### Request URL -
    http://localhost:3000/logout
  #### Request BODY - 
    {
        "email": "test@example.com",
        "password": "john@123"
    }
  
  ### `POST \transactions`
  #### Request URL -
    http://localhost:3000/transactions
  #### Request BODY - 
    {
      "walletable_type": "User",
      "walletable_id": 1,
      "amount": 300,
      "transaction_type": "debit"
    }

## Run Rspec
  Run `bundle exec rspec spec`

