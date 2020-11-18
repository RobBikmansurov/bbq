
# BBQ - Let's go to the barbecue! training project

[![Build Status](https://travis-ci.com/RobBikmansurov/bbq.svg?branch=master)](https://travis-ci.com/RobBikmansurov/bbq)

## Getting started

Try the app on [Digital Ocean](https://bbq.bikmansurova.ru/)
or [Heroku](https://bbq-robb.herokuapp.com/)

### Install

Development environment requirements :
* Ruby version 2.7.1
* Rails 6.0.3
* Devise, Pundit, OmniAuth

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

#### Create selfsigned cerificates for development
vi config/environments/development.rb
```
config.force_ssl = true
config.action_controller.asset_host = 'https://lvh.me:3000'
```

Create certificate and key (be sure to fill FQDN):
`openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`

```
Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:Perm Region
Locality Name (eg, city) []:Perm
Organization Name (eg, company) [Internet Widgits Pty Ltd]:.
Organizational Unit Name (eg, section) []:.
Common Name (e.g. server FQDN or YOUR name) []:lvh.me
Email Address []:robb@mail.ru
```

Two new files will appear in the current directory:
`localhost.key` and `localhost.crt`

Run application:
```
bundle exec rails s -b 'ssl://lvh.me:3000?key=./localhost.key&cert=./localhost.crt'
```
Now you can access the application with your browser on: `https://lvh:3000`

Enjoy!

#### Create backup-files (only for VDS)
```
touch shared/public/assets/.manifest.json
touch shared/public/assets/.sprockets-manifest.json
```



&copy; 2020 [Robert Bikmansurov](https://bikmansurov.ru/)
