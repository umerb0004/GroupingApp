# Local Development Setup

## Technology stack

- Ruby 3.0.6
- Ruby on Rails 7.0
- Application Server: Puma
- Component Library from Tailwind + Flowbite [Flowbite Documentation](https://flowbite.com/docs/getting-started/introduction/)

## Requirements

Before you get started, the following needs to be installed:
- **Ruby**. Version 3.0.6 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) is recommended.
- **Bundler**: `gem install bundler`
- **A database**. PostgreSQL

## Setting up the development environment

1. Install the required gems by running the following command in the project root directory:

    ```shell
    bundle install
    ```

2. Create and populate database with seeds using:

    ```shell
    rails db:create db:migrate db:seed
    ```

3. Run server:

    ```shell
    ./bin/dev
    ```

## Unit Test cases

1. Run RSpec test cases:

    ```shell
    bundle exec rspec
    ```

Congratulations! Meetup App should now be up and running for development purposes on [http://localhost:3000/](http://localhost:3000/).
