# syntax=docker/dockerfile:1
FROM ruby:2.7.1
WORKDIR /api_service
# Preapare gems
COPY Gemfile /api_service
COPY Gemfile.lock /api_service
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /api_service
ENTRYPOINT ["/api_service/entrypoint.sh"]

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
