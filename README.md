
# BBQ - training project

## Getting started

Try the app on [Heroku](https://bbq-robb.herokuapp.com/)

### Install

Development environment requirements :
* Ruby version 2.7.1
* Rails 6.0.3
* gem Devise

```bash
$ git clone git@github.com:RobBikmansurov/bbq.git
$ sudo apt install nodejs libpq-dev
$ sudo apt-get install imagemagick libmagickwand-dev
$ cd bbq
$ bundle config set without 'production'
$ bundle install
$ rails db:setup
$ rails db:seed
```

Now you can access the application with your browser on: http://localhost:3000


&copy; 2020 [Robert Bikmansurov](https://bikmansurov.ru/)
