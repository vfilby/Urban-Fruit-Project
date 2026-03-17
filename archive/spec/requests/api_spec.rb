require 'spec_helper'

describe UrbanFruitProject::API do
  context "api/" do
    context "cache/" do
        context "POST save" do
        let(:url) {'/api/cache/save'}
        let(:cache) { {
          "cache_owner" =>1,
          "name" => "asdlfkjasdf",
          "description" => "Pear Tree",
          "latitude" => 43.3649522937441,
          "longitude" => -79.7653398037541,
        } }
    
    
        it "given no primary_tag" do
          post url, :json => cache.to_json
          response.status.should eql(500)
        end
    
        it "given a new primary_tag" do
          cache["primary_tag"] = 'Buttercup'
          post url, :json => cache.to_json
          response.status.should eql(201)
          saved_cache = FruitCache.find_by_name "asdlfkjasdf"
          saved_cache.should_not be_nil
        end
      
        it "give an existing primary_tag_id" do
          tag = FactoryGirl.create( :tag )
          cache["primary_tag"] = tag.id
          post url, :json => cache.to_json
          response.status.should eql(201)
          saved_cache = FruitCache.find_by_name "asdlfkjasdf"
          saved_cache.should_not be_nil
        end
      end
    end
  end

  describe "GET /api/test/echo" do
    it "repeats inputs" do
      get "/api/test/echo?key=superspecialvalue"
      response.status.should == 200
      h = JSON.parse( response.body )
      h["key"].should == "superspecialvalue"
    end
  end
end