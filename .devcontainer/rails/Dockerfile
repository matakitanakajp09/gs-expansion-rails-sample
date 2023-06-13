FROM ruby:3.1.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# for nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# for yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn vim zlib1g-dev liblzma-dev patch

RUN node -v
RUN yarn -v

RUN gem install bundler \
  rubocop \
  rubocop-rails \
  rubocop-performance \
  rubocop-rspec
