# Ruby 3.4 sürümünü kullanıyoruz
FROM ruby:3.4.1-slim

# İşletim sistemi bağımlılıkları
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libsqlite3-dev \
    pkg-config \
    curl \
    node-gyp \
    python-is-python3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Çalışma dizini /rails olarak sabitlenir
WORKDIR /rails

# Ortam değişkenleri
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Gem yükleme işlemi
COPY Gemfile Gemfile.lock ./
RUN bundle install

# TÜM dosyaları içeri aktar (Burada eksik dosya kalmadığından emin olur)
COPY . .

# bin klasöründeki dosyalara çalıştırma yetkisi ver
RUN chmod +x bin/*

# Dış dünyaya açılan port
EXPOSE 3000

# Ana çalıştırma komutu
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]