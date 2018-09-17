# Welcome to Dante Stories - a Self hosted Medium like solution

[![Build Status](https://travis-ci.org/michelson/dante-stories.svg?branch=master)](https://travis-ci.org/michelson/dante-stories)

[![Maintainability](https://api.codeclimate.com/v1/badges/c73c3860d7ccb4c8ada1/maintainability)](https://codeclimate.com/github/michelson/dante-stories/maintainability)

This project is a fork of a Medium clone which began as [Ken Hibino](https://github.com/hibiken/stories)'s personal side project to learn **Ruby on Rails** and **ReactJS**. I've upgraded and refactored some part of the rails app and I've integrated Dante2 wysiwyg editor.

## The specific improvements from the original repository:

### Platform 

+ Rails 5.2.1 update!
+ Removed elastisearch-rails , replaced by searchkick
+ Removed carrierwave, replaced by activestorge
+ Webpacker added
+ Updated dependencies
+ Replaced phantomJs by chrome-webdriver
+ Ruby version 2.4.0
+ Works with Elasticsearch 6.3.X

### Application Model

+ multiple image support
+ Oembed support
+ A better wysiwyg With Dante2 Draftjs
  + Code blocks with language formatting via Prism-js
  + A video record component to build posts with recorded video
  + Database saves a serialized representation of text
  + And much much more
+ Automatic title detection
+ Lead Text is automatic too. more performant approach , I think
+ Responses are unified as a Post model, so Response model is removed


## Installation

### Heroku

Just push your application. You must add Redis and elasticsearch.

### Config ENV vars

```
AWS_BUCKET:  
AWS_KEY:    
AWS_SECRET:   
BONSAI_URL: provided by bonsai heroku
DATABASE_URL: provided by postgres default database
ELASTICSEARCH_URL: should be the same as bonsai
MAILER_ADDRESS:  
MAILER_DOMAIN:   
MAILER_PASS:     
MAILER_SENDER:   
MAILER_USER:
REDISTOGO_URL:
REDIS_URL:  REDISTOGO_URL or any other provider
```   


## License
Stories is released under the [MIT License](https://opensource.org/licenses/MIT)
