namespace :cached_locations do
  desc "Update cached locations"
  task :update => :environment do
    print "Emptying cached_browse_locations table\n"
    CachedBrowseLocation.delete_all
    
    FruitCache.all.each do |cache|
      print "Adding #{cache.primary_tag.tag} to the job queue...\n"
      BrowseCacheManager.add_location cache.latitude, cache.longitude
    end
  end
end