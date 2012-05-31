require 'test_helper'

class BrowseCacheManagerTest < ActionController::TestCase

  test "remove location checks for nearby caches before deleteing" do
    guelph_cache = fruit_caches( :guelph_cache )
    cache = FruitCache.find_by_id( guelph_cache.id )
    assert_not_nil( cache, "guelph_cache must be present for this test" )
    
    BrowseCacheManager.add_location 43.48772,  -80.258507
    assert CachedBrowseLocation.count == 8, "There should be 8 cached locations"
    %w(Cambridge Guelph Kitchener Waterloo Ontario North\ America Canada Earth).each do |city|
      location = CachedBrowseLocation.find_by_name city
      assert_not_nil location, "#{city} should be included in the cached locations"
    end
    
    # Even through we are removing the location from the cache
    # an existing cache in the db will prevent the locations from being
    # removed
    BrowseCacheManager.remove_location 43.48772,  -80.258507
    assert CachedBrowseLocation.count == 8, "There should be 8 cached locations"
    %w(Cambridge Guelph Kitchener Waterloo Ontario North\ America Canada Earth).each do |city|
      location = CachedBrowseLocation.find_by_name city
      assert_not_nil location, 
      "#{city} should be included in the cached locations"
    end
  end

  test "generate browse location cache" do
    
    # For this test delete all caches, as their presence
    # can affect which cached locations are removed
    FruitCache.all.each { |cache| cache.destroy }
    
    BrowseCacheManager.add_location 43.48772,  -80.258507
    assert CachedBrowseLocation.count == 8, "There should be 8 cached locations"
    %w(Cambridge Guelph Kitchener Waterloo Ontario North\ America Canada Earth).each do |city|
      location = CachedBrowseLocation.find_by_name city
      assert_not_nil location, "#{city} should be included in the cached locations"
    end
    
    BrowseCacheManager.add_location 43.8508553, -79.0203732
    assert CachedBrowseLocation.count == 12, "There should be 12 cached locations"
    %w(Ajax Cambridge Guelph Kitchener Markham Ontario Oshawa Pickering Waterloo Canada North\ America Earth).each do |city|
      location = CachedBrowseLocation.find_by_name city
      assert_not_nil location, "#{city} should be included in the cached locations"
    end
    
    BrowseCacheManager.remove_location 43.48772,  -80.258507
    assert CachedBrowseLocation.count == 8, "There should be 8 cached locations"
    %w(Ajax Markham Ontario Oshawa Pickering Canada North\ America Earth).each do |city|
      location = CachedBrowseLocation.find_by_name city
      assert_not_nil location, 
      "#{city} should be included in the cached locations"
    end 
    
    %w(Cambridge Guelph Kitchener Waterloo).each do |city|
      location = CachedBrowseLocation.find_by_name city
      assert_nil location, "#{city} should have been removed from cached locations"
    end
    
    BrowseCacheManager.remove_location 43.8508553, -79.0203732
    assert CachedBrowseLocation.count == 0, "All cached browse locations should be deleted"
  end

end