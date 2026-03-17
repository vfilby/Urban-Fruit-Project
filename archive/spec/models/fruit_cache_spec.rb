require 'spec_helper'

describe FruitCache do
  it "can be instantiated" do
    FruitCache.new.should be_an_instance_of( FruitCache )
  end
end