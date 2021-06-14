# README

# App schema
### Model : task

belongs_to:user
has_many:labels

| Colums | Description |
| --- | ----------- |
| user_id | integer |
| label_id | integer |
| task_name | string |
| description | string |
| deadline | date |
| status | string |
| priority | string |



### Model : User

has_many:task

| Colums | Description |
| --- | ----------- |
| name | string |
| email | string |

| password_digest | string |

### Model labels

has_many:tasks
| Colums | Description |
| --- | ----------- |
| user_id | integer |
| name | string |

# How to deploy on heroku
Deployment on heroku follows some steps describe below.


### Creation of the app on heroku
Just do on the terminal these commands

```
$ heroku login
$ heroku create
```
### Change the stack because we use ruby version 2.6.5
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
$ heroku stack:set heroku-18
```

### Compile the app and push it on heroku
```
$ rails assets:precompile RAILS_ENV=production
$ git add -A
$ git commit -m "message"
$ git push heroku master
```
### Migrate database and open app link

```
$ heroku run rails db:migrate
$ heroku open
```
That is all! Thanks.