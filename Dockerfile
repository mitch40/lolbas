FROM alpine

RUN apk update && apk add \
        alpine-sdk \
        gcc \
        git \
        libressl-dev \
        make \
        ruby \
        ruby-bigdecimal \
        ruby-dev \
        ruby-etc \
        ruby-json \
        ruby-webrick

RUN gem install \
        bundler \
        kramdown \
        kramdown-parser-gfm

RUN git clone https://github.com/LOLBAS-Project/LOLBAS-Project.github.io /opt/LOLBAS

WORKDIR /opt/LOLBAS

RUN bundle update --bundler || echo "continue"

RUN printf "\ngem 'kramdown-parser-gfm'"
RUN cat Gemfile

RUN bundle update
RUN make bundle

EXPOSE 4000
CMD ["make", "serve-public"]
