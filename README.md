# Rails Demo

Ürünlerin listelendiği, sepete eklenip sipariş verilebildiği, yönetici paneliyle ürün, kullanıcı ve destek taleplerinin yönetildiği bir mağaza uygulaması.

## Teknolojiler

- **Uygulama:** Ruby 3.4, Rails 7.2, Hotwire (Turbo + Stimulus), Importmap, Sprockets
- **Arayüz:** Tailwind CSS (`tailwindcss-rails`)
- **Veri:** SQLite (development ve test), PostgreSQL (production), Active Storage, Action Text
- **Arka plan işleri ve gerçek zamanlı güncelleme:** Active Job, Action Cable (Redis)
- **E-posta:** Action Mailer, Action Mailbox
- **Kimlik doğrulama:** `has_secure_password` (bcrypt), session tabanlı oturum
- **Test ve kalite:** Minitest, Capybara + Selenium (system testleri), RuboCop (rails-omakase), Brakeman
- **CI:** GitHub Actions (`.github/workflows/ci.yml`)

## Özellikler

- **Mağaza:** Ürün kataloğu, oturum açmadan sepete ürün ekleme, sepet ve sipariş formu
- **Ödeme:** Çek, kredi kartı ve satın alma siparişi (PO) seçenekleri; ödeme `ChargeOrderJob` ile arka planda `lib/pago.rb` içindeki sahte ödeme servisine gönderilir (gerçek ödeme alınmaz)
- **Ürün yönetimi:** Ürün ekleme, düzenleme, silme; Action Text ile zengin metin açıklamalar; ürün güncellemeleri Turbo Stream ile açık sayfalara anlık yansır
- **Satın alanlar:** `/products/:id/who_bought` ürünü kimlerin aldığını HTML, JSON ve XML olarak gösterir
- **Çoklu dil:** İngilizce ve İspanyolca (`/en`, `/es` önekli adresler)
- **Kullanıcılar:** Yönetici girişi, kullanıcı ekleme/düzenleme; parola değiştirmeden önce mevcut parola tekrar sorulur
- **Destek talepleri:** Gelen e-postalar Action Mailbox ile destek talebine dönüşür; talepler zengin metinle yanıtlanır, müşterinin son siparişleri talebin yanında görüntülenir
- **Hata bildirimi:** Yakalanmayan hatalar `ErrorMailer` ile e-postayla bildirilir, kullanıcıya genel bir hata mesajı gösterilir

## Başlangıç

Gerekli araçlar: Ruby 3.4 ve SQLite.

```sh
bin/setup   # bundle install, db:prepare, ardından bin/dev
```

`bin/dev`, Rails sunucusunu ve Tailwind watcher'ı (`Procfile.dev`) birlikte başlatır. Uygulama <http://localhost:3000> adresinde açılır.

Örnek ürünleri yüklemek için:

```sh
bin/rails db:seed
```

### Docker ile

```sh
docker compose up --build
```

Compose `web`, `postgres-db` ve `redis-db` servislerini başlatır. PostgreSQL bağlantısı `DATABASE_HOST`, `DATABASE_USER` ve `DATABASE_PASSWORD` değişkenlerinden okunur; production ortamında `RAILS_MASTER_KEY` gerekir.

## İlk hesap

Uygulama ilk kez açıldığında `users` tablosu boşsa `config/initializers/first_run.rb` bir yönetici hesabı oluşturur:

| Kullanıcı adı | Parola |
| --- | --- |
| `admin` | `admin_password` |

> Bu hesap yalnızca geliştirme içindir; gerçek bir ortamda parolayı hemen değiştirin.

## Testler

```sh
bin/rails test           # model, controller, mailer, mailbox, job ve channel testleri
bin/rails test:system    # Capybara + Selenium ile tarayıcı testleri (Chrome gerekir)
```

Stil ve güvenlik kontrolleri:

```sh
bin/rubocop
bin/brakeman --no-pager
```

## Proje yapısı

```text
app/
├── controllers/   Mağaza, sepet, sipariş, ürün, kullanıcı, oturum, destek talepleri
├── channels/      ProductsChannel (ürün güncellemeleri)
├── jobs/          ChargeOrderJob
├── mailboxes/     SupportMailbox
├── mailers/       Sipariş, destek talebi ve hata e-postaları
└── views/
config/locales/    en.yml, es.yml
lib/pago.rb        Sahte ödeme servisi
test/              Minitest ve system testleri
```
