class SendActionController < ApplicationController
  def initialize *args
    super(*args)
  end
  def turn 
    id, action = params[:id].to_i, params[:player_action]
    
    unless $neuro_nets[id].performed_turn
      $lock_nets.synchronize do
        $lock_field.synchronize do 
          if action == 'eat'
            $field[$neuro_nets[id].coor_y][ $neuro_nets[id].coor_x] = $neuro_nets[id].eat($field[$neuro_nets[id].coor_y][ $neuro_nets[id].coor_x])
          end
          if action == 'left'
            $neuro_nets[id].coor_x = $neuro_nets[id].coor_x - 1 unless ($neuro_nets[id].coor_x - 1 < 0)   
          end
          if action == 'right'
            $neuro_nets[id].coor_x = $neuro_nets[id].coor_x + 1 unless ($neuro_nets[id].coor_x + 1 > $field.length)
          end
          if action == 'up'
            $neuro_nets[id].coor_y = $neuro_nets[id].coor_y + 1 unless ($neuro_nets[id].coor_y + 1 > $field[0].length)
          end
          if action == 'down'
            $neuro_nets[id].coor_y = $neuro_nets[id].coor_y - 1 unless ($neuro_nets[id].coor_y - 1 < 0)
          end
          if action == 'sleep'
            $neuro_nets[id].sleep
          end
          $neuro_nets[id].turn
          $neuro_nets[id].performed_turn = true
          reset_turn = $neuro_nets.inject(true){|accum, (key, value)| value.performed_turn && accum }
          if reset_turn
            $field.place_food_additional
            $neuro_nets.each{ |key, item| item.performed_turn = false }
          end
        end
      end
      render json: $neuro_nets[id]
    else
      render json: "please wait"
    end
  end
  
end
