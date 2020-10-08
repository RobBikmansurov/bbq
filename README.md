
# BBQ - training project

[![Build Status](https://travis-ci.com/RobBikmansurov/bbq.svg?branch=master)](https://travis-ci.com/RobBikmansurov/bbq)

## Getting started

Try the app on [Heroku](https://bbq-robb.herokuapp.com/)
or [there](https://bbq.bikmansurov.ru/)
or [here](http://161.35.93.15/)

### Install

Development environment requirements :
* Ruby version 2.7.1
* Rails 6.0.3
* gem Devise

```bash
$ git clone git@github.com:RobBikmansurov/bbq.git
$ sudo apt install nodejs libpq-dev
$ sudo apt-get install imagemagick libmagickwand-dev
$ sudo apt install postgresql postgresql-contrib libpq-dev # only for production
$ cd bbq
$ bundle config set without 'production'
$ bundle install
$ rails db:setup
$ rails db:seed
```

### Dependensies
#### Install nodejs
```
curl -sL https://deb.nodesource.com/setup_14.x |sudo -E bash -
sudo apt-get install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
```

#### Install yarn
```
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
yarn install --check-files
```

#### Create backup-files
```
touch shared/public/assets/.manifest.json
touch shared/public/assets/.sprockets-manifest.json
```

Now you can access the application with your browser on: http://localhost:3000


&copy; 2020 [Robert Bikmansurov](https://bikmansurov.ru/)
