# Air Armillary Seat

This application is made using [Sinatra Active Record Starter Kit](https://github.com/LaunchAcademy/sinatra-activerecord-starter-kit)


## Getting Started

### Installation

1. RVM

    ```sh
    curl -L get.rvm.io | bash -s stable
    source ~/.bash_profile
    ```

    Then run this command and follow the instructions

    ```sh
    rvm requirements
    ```

2. Ruby 2.6.3

    ```sh
    rvm install 2.6.3
    rvm use 2.6.3
    ```

3. Install Bundler and Foreman

    ```sh
    gem install bundler
    gem install foreman
    ```

4. Install Gems

    ```sh
    bundle install
    ```

### Run Services

1. Serve API

    ```sh
    ruby app.rb
    ```

2. Run Test (Spec)

    ```sh
    rspec
    ```

### Using Docker

1. Create and Start with Docker and listen on port 4567

    ```sh
    docker-compose up
    ```

2. Start with Docker and listen on port 4567

    ```sh
    docker-compose start
    ```

3. Stop with Docker

    ```sh
    docker-compose stop
    ```
