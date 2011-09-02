class FruitCache < ActiveRecord::Base
  include Tanker
    
  tankit 'cache_index' do
    indexes :name
    indexes :description
    variables do 
      {
          0 => latitude,
          1 => longitude
      }
    end
      
    functions do
      {
        # This function is good for sorting your results. It will
        # rank relevant, close results higher and irrelevant, distant results lower
        1 => "relevance / miles(d[0], d[1], q[0], q[1])",

        # This function is useful for limiting the results that your query returns.
        # It just calculates the distance of each document in miles, which you can use
        # in your query. Notice that we're using 0 and 1 consistently as 'lat' and 'lng'
        2 => "miles(d[0], d[1], q[0], q[1])"
      }
    end
  end
  
  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes
end
