namespace :ufp do
  desc "import data from files to database"
  task :import_tags, [:file] => :environment do |t, args|
    file = File.open(args[:file])
    file.each do |line|
      tag_name = line.chomp
      puts "#{tag_name}..."
      t = Tag.find_or_initialize_by_tag( tag_name )
      t.save!
      puts "DONE\n"
    end
  end
  
  task :import_caches, [:file] => :environment do |t, args|
    require 'csv'
    
    csv_text = File.read(args[:file])
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      t = Tag.find_or_create_by_tag( row[:primary_tag] )
      row[:primary_tag_id] = t.id
      row.delete :primary_tag 
      fc = FruitCache.find_or_create(row.to_hash.symbolize_keys)
      if fc.new_record?
        print "."
      else
        print "*"
      end
    end
  end
end