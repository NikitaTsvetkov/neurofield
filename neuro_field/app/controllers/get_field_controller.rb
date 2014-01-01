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
    $lock_nets.synchronize do
        $lock_field.synchronize do
          render :json => $field.field_state
      end
    end 
  end
  
  def player_state 
    $lock_nets.synchronize do
      $lock_field.synchronize do
        id = params[:id].to_i
        #raise $neuro_nets.to_s
        x , y = $neuro_nets[id].coor_x , $neuro_nets[id].coor_y 
        fs = $field.field_state
        matrix = [[fs.get_element(y + 1, x - 1),fs.get_element(y + 1,x),fs.get_element(y + 1 , x + 1)],
                  [fs.get_element(y, x - 1),$field[y][x],fs.get_element(y , x + 1)],
                  [fs.get_element(y - 1, x - 1),fs.get_element(y - 1,x),fs.get_element(y - 1 , x + 1)]];
        matrix.each_with_index{|item|}
        state = [$neuro_nets[id], matrix]
        render :json => state
      end
    end
  end  
end
