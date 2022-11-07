web: bundle exec puma -p $PORT -C ./config/puma.rb
worker: bundle exec sidekiq -q default -q mailers
js: yarn build --watch
css: yarn build:css --watch
