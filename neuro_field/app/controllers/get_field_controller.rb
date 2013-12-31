class Array
  def get_element coor_1, coor_2
    if self[coor_1] != nil and self[coor_1][coor_2] != nil and coor_1 >= 0 and coor_2 >= 0
      self[coor_1][coor_2]
    else
      nil 
    end 
  end
end

class GetFieldController < ApplicationController
  def get_field_state  
    render :json => field_state 
  end
  
  def player_state 
    id = params[:id].to_i
    #raise $neuro_nets.to_s
    x , y = $neuro_nets[id].coor_x , $neuro_nets[id].coor_y 
    fs = field_state
    matrix = [[fs.get_element(y + 1, x - 1),fs.get_element(y + 1,x),fs.get_element(y + 1 , x + 1)],
              [fs.get_element(y, x - 1),fs.get_element(y,x),fs.get_element(y , x + 1)],
              [fs.get_element(y - 1, x - 1),fs.get_element(y - 1,x),fs.get_element(y - 1 , x + 1)]];
    matrix.each_with_index{|item|}
    state = [$neuro_nets[id], matrix]
    render :json => state
  end
  
  private
  def copy_field
    new_field = $field.inject([]) do |accum, item|
      new_element = item.map{ |x| x }
      accum << new_element
    end
  end
  
  def field_state
    if $neuro_nets and $field
      field_to_show = copy_field
      $neuro_nets.each  do |key, value|
	      field_to_show[value.coor_y][value.coor_x] = key
      end
      field_to_show 
    end
  end
end
