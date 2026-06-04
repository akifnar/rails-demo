source "https://rubygems.org"

# Rails ve Core Bileşenler
gem "rails", "~> 7.2.3", ">= 7.2.3.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "jbuilder"
gem "ostruct"

# Ön Yüz (Frontend) ve JavaScript
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 4.4"

# Veritabanları ve Depolama
gem "sqlite3", ">= 1.4"
gem "image_processing", "~> 2.0"
gem "activemodel-serializers-xml"

# WebSocket (Action Cable) için Redis bağımlılığı
gem "redis", ">= 4.0.1"

# Güvenlik ve Şifreleme (Kullanıcı girişleri için)
gem "bcrypt", "~> 3.1.7"

# Windows Uyumluluğu
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Boot Hızlandırıcı
gem "bootsnap", require: false

# GELİŞTİRME VE TEST ORTAMI (Local Mac ortamın için)
group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false

  # RuboCop burada kalmalı (Localde kod analizi için)
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# CANLI ORTAM (Docker / Production için PostgreSQL)
group :production do
  gem "pg", "~> 1.6"
end