desc "Extracts attributes for a given table from schema.rb"
task :show_columns, [:table_name] => :environment do |t, args|
  table_name = args[:table_name]

  if table_name.nil?
    puts "Usage: rake show_columns[table_name]"
    next
  end

  schema_path = Rails.root.join('db', 'schema.rb')

  if !File.exist?(schema_path)
    puts "Error: schema.rb file not found!"
    next
  end

  schema_content = File.read(schema_path)

  if schema_content =~ /create_table "#{table_name}"(.*?)end/m
    table_block = $1
    columns = table_block.scan(/t\.(\w+)\s+"(\w+)"/)

    # İsmi büyük harfe çevirip ANSI kodu ile bold yapıyoruz
    formatted_name = "\e[1m#{table_name.upcase}\e[0m"

    puts "--- ATTRIBUTES FOR TABLE: #{formatted_name} ---"
    columns.each do |type, name|
      puts "#{name.ljust(20)} : #{type}"
    end
  else
    formatted_name = "\e[1m#{table_name.upcase}\e[0m"
    puts "Error: Table '#{formatted_name}' not found in schema.rb!"
  end
end