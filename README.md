# Homework

EC website homework

## Run this Project

```
# clone project
git clone git@github.com:timfanda35/artstore.git

# install dependency gems
bundle install

# migrate database schema
cd artstore
cp config/database.yml.example config/database.yml
bundle exec rake db:migrate

# create test user
rails runner 'User.create( \
:email=> "yyy@xxx.com", \
:password => "12345678", \
:password_confirmation => "12345678", \
:is_admin => true)'

# start rails server
rails server
```

Home Page: [http://localhost:3000/](http://localhost:3000/)

Admin Page: [http://localhost:3000/admin/products](http://localhost:3000/admin/products)
