## tvdb-shadow

exercise to search tvdb api in ruby on rails


### toc

- [deployed to heroku]
- [install]
- [run]
- [todo]
- [done]


### deployed to heroku

    Creating app... done, ⬢ guarded-ridge-26178
    https://git.heroku.com/guarded-ridge-26178.git

https://guarded-ridge-26178.herokuapp.com/


### install

todo: test below

requires ruby, gem, and bundle
clone git repo

    cd /path/to/tvdb-shadow/
    bundle install --without production
    cp config/env-template.sh config/env.sh
    vi config/env.sh
    # fill in fields
    chmod +x config/env.sh
    rails db:migrate
    rails db:seed


#### heroku

    heroku create
    git push heroku master
    heroku run rails db:migrate
    heroku run rails db:seed
    heroku config:set SECRET_TVDB_API_KEY=[apikey]
    heroku config:set SECRET_TVDB_USER=[username]
    heroku config:set SECRET_TVDB_USER_KEY=[userkey]
   

### run

todo: test below

#### local

    cd /path/to/tvdb-shadow
    config/env.sh
    rails server


#### heroku

after git commit on master

    heroku create
    git push heroku master


### todo

- search page
  - current search past dates
    - paginate
  - style
  - previous searches
    - paginate
- results
  - current key
    - test
  - advanced
    - filter by endpoints
- heroku
  - procfile
  - ssl-only
- readme
  - toc
    - heroku
    - local
  - install
  - run
- default ruby functions
  - test json returns


### done
- search page
  - previous searches
    - add on link
    - number of times searched
    - order by
      - count
      - created
      - query
- results
  - result count
  - series on-click link
    - title 
    - start date
    - rating
  - current key
    - is stored?
    - get new

[deployed to heroku]:#deployed-to-heroku
[install]:#install
[run]:#run

[todo]:#todo
[done]:#done
