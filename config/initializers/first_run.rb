# config/initializers/first_run.rb

# Rails ayağa kalkarken veritabanı tablolarının hazır olduğundan emin oluyoruz
Rails.application.config.after_initialize do

  if ActiveRecord::Base.connected? && ActiveRecord::Base.connection.table_exists?(:users)

    if User.count == 0
      puts "=== The app is running for the first time: Default users are being created ==="
      User.create!(name: "admin", password: "admin_password", password_confirmation: "admin_password")
      puts "=== Installation complete ==="
    else
      puts "=== Installation failed ==="
    end
  end
end
