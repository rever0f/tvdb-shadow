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

requires ruby, gem, and bundle
clone git repo

   cd /path/to/tvdb-shadow/
   bundle install --without production
   
todo: test
   

### run

   rails server
   
todo: test


### todo

- search page
  - test 200 response?
  - current search past dates
  - previous searches
    - test firefly search
    - order by
      - count
  - style
- results
  - current key
    - is stored?
    - get new
    - test
  - test firefly search success(200?)
  - test create firefly search
  - test search num incremented
  - result count
  - series on-click link
    - thumbnail
    - title 
    - rating
  - advanced
    - previous advanced dropdowns
- readme
  - install
  - run


### done
- search page
  - previous searches
    - add on link
    - number of times searched
    - order by
      - created
      - query


[deployed to heroku]:#deployed-to-heroku
[install]:#install
[run]:#run

[todo]:#todo
[done]:#done
