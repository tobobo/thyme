#### thyme-backend

A backend for a time tracker.

### Heroku Deployment

Create a heroku app (for example, for an app called my-thyme-app). If you run this command from the project directory, it will add the remote `heroku` for you. Which is handy.
```
heroku apps:create my-thyme-app
```

Add a mongodb add-on and set the config variable `THYME_DB_URL` to its database url.
```
heroku addons:add mongolab
heroku config:set THYME_DB_URL=`heroku config:get MONGOLAB_URI`
```

Push to heroku.
```
git push heroku master
```
