class Field < Array
  def initialize x, y, extra
    super(y) do |num| 
      ( Array.new(x) {|num_x| 0 } )
    end
    place_food_initial
    
  end
  
  def place_food_initial # M = 0.3
    self.each do |line|
      line.map!{|value| (Random.rand(8) <= 2)? -1 : value }  
    end
  end
  
  def place_food_additional
    self.each do |line|
      line.map!{|value| (Random.rand(16) <= 2)? -1 : value }  
    end
  end
end