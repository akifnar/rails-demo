# Mevcut tüm ürünleri temizle (Çakışma olmaması için)
Product.delete_all

# Senin fotoğraflarına özel ürün listesi
Product.create!(
  title: "Brainless Rock",
  description: %(<p>Zihnini boşaltmak ve sadece anın tadını çıkarmak isteyenler için doğanın en sakin parçası. Hiçbir bakım gerektirmez, sadece orada durur.</p>),
  image_url: "Brainless rock.jpg",
  price: 15.00
)

Product.create!(
  title: "Lucky Dice",
  description: %(<p>Hayatın bir kumar olduğunu düşünenler veya kutu oyunlarını sevenler için ideal bir çift şanslı zar. Her atış yeni bir başlangıç!</p>),
  image_url: "Dice.jpg",
  price: 5.50
)

Product.create!(
  title: "Classic Fork",
  description: %(<p>Mutfak koleksiyonunuzun en keskin üyesi olmaya aday. Ergonomik tasarımı ve gümüş parıltısıyla her öğüne şıklık katar.</p>),
  image_url: "Fork.jpg",
  price: 8.95
)

Product.create!(
  title: "Random Stuff Box",
  description: %(<p>Etrafa saçılmış küçük ama anlamlı nesnelerin gizemli birleşimi. Dağınıklığın içindeki düzeni sevenler için.</p>),
  image_url: "Random stuff.png",
  price: 12.00
)

Product.create!(
  title: "Random Things Set",
  description: %(<p>Birbirinden bağımsız ama bir araya geldiğinde hikaye anlatan objeler bütünü. Her parça farklı bir anıyı temsil eder.</p>),
  image_url: "Random Things.png",
  price: 22.40
)

Product.create!(
  title: "Aged Skull",
  description: %(<p>Gotik dekorasyonun vazgeçilmezi. Detaylı işçiliğiyle dikkat çeken, kütüphanenize veya masanıza farklı bir hava katacak kafatası modeli.</p>),
  image_url: "Skull.webp",
  price: 45.00
)
