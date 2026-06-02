# db/seeds.rb

puts "=== Ürünler Kontrol Ediliyor ve Güncelleniyor ==="

products_data = [
  {
    title: "Brainless Rockaaa",
    rich_description: "<p>Zihnini boşaltmak ve sadece anın tadını çıkarmak isteyenler için doğanın en sakin parçası. Hiçbir bakım gerektirmez, sadece orada durur.</p>",
    image_url: "Brainless rock.jpg",
    price: 15.00
  },
  {
    title: "Lucky Dice",
    rich_description: "<p>Hayatın bir kumar olduğunu düşünenler veya kutu oyunlarını sevenler için ideal bir çift şanslı zar. Her atış yeni bir başlangıç!</p>",
    image_url: "Dice.jpg",
    price: 5.50
  },
  {
    title: "Classic Fork",
    rich_description: "<p>Mutfak koleksiyonunuzun en keskin üyesi olmaya aday. Ergonomik tasarımı ve gümüş parıltısıyla her öğüne şıklık katar.</p>",
    image_url: "Fork.jpg",
    price: 8.95
  },
  {
    title: "Random Stuff Box",
    rich_description: "<p>Etrafa saçılmış küçük ama anlamlı nesnelerin gizemli birleşimi. Dağınıklığın içindeki düzeni sevenler için.</p>",
    image_url: "Random stuff.png",
    price: 12.00
  },
  {
    title: "Random Things Set",
    rich_description: "<p>Birbirinden bağımsız ama bir araya geldiğinde hikaye anlatan objeler bütünü. Her parça farklı bir anıyı temsil eder.</p>",
    image_url: "Random Things.png",
    price: 22.40
  },
  {
    title: "Aged Skull",
    rich_description: "<p>Gotik dekorasyonun vazgeçilmezi. Detaylı işçiliğiyle dikkat çeken, kütüphanenize veya masanıza farklı bir hava katacak kafatası modeli.</p>",
    image_url: "Skull.webp",
    price: 45.00
  }
]

products_data.each do |data|
  # Ürün başlığına göre bulur, yoksa yaratır, varsa fiyatı ve açıklamayı günceller
  product = Product.find_or_initialize_by(title: data[:title])
  product.image_url = data[:image_url]
  product.price = data[:price]
  product.locale = "en" if product.respond_to?(:locale)
  product.save!

  # Action Text (rich_description) alanını zorla güncelliyoruz
  product.update!(rich_description: data[:rich_description])
  puts "-> #{product.title} güncellendi/yüklendi."
end

puts "=== Ödeme Tipleri Güncelleniyor ==="
PayType.delete_all # Güvenli bir şekilde sıfırlayıp baştan ekliyoruz
PayType.create!(id: 1, name: "Check")
PayType.create!(id: 2, name: "Credit card")
PayType.create!(id: 3, name: "Purchase order")

puts "=== Kullanıcı Kontrol Ediliyor ==="
# Kullanıcı zaten varsa hata vermez, es geçer
password = Rails.application.credentials.akif_password || "password123"
User.find_or_create_by!(name: 'akif') do |user|
  user.password = password
end

puts "=== SEED BİTTİ: HER ŞEY HAZIR! ==="