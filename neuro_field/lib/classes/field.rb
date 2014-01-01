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
  
  def field_state
    if $field
      field_to_show = copy_field
      if $neuro_nets   
        $neuro_nets.each  do |key, value|
          field_to_show[value.coor_y][value.coor_x] = key
        end
      end
      field_to_show 
    end
  end
  
  def copy_field
    new_field = $field.inject([]) do |accum, item|
      new_element = item.map{ |x| x }
      accum << new_element
    end
  end
end