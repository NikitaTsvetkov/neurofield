class SendActionController < ApplicationController
  def initialize *args
    super(&args)
  end
  def turn id, action
    unless $neuro_nets[id].performed_turn
      if action == 'eat'
	$field[$neuro_nets[id].coor_x][ $neuro_nets[id].coor_y] = $neuro_nets[id].eat($field[$neuro_nets[id].coor_x][ $neuro_nets[id].coor_y])
      end
      if action == 'left'
	$neuro_nets[id].coor_x = $neuro_nets[id].coor_x - 1 unless ($neuro_nets[id].coor_x - 1 < 0)   
      end
      if action == 'right'
	$neuro_nets[id].coor_x = $neuro_nets[id].coor_x + 1 unless ($neuro_nets[id].coor_x + 1 > $field[0].length)
      end
      if action == 'up'
	$neuro_nets[id].coor_y = $neuro_nets[id].coor_y + 1 unless ($neuro_nets[id].coor_y + 1 > $field.length)
      end
      if action == 'down'
	$neuro_nets[id].coor_y = $neuro_nets[id].coor_y - 1 unless ($neuro_nets[id].coor_y - 1 < 0)
      end
      $neuro_nets[id].performed_turn = true
      reset_turn = $neuro_nets.inject(true){|accum, (key, value)| value.performed_turn && accum }
      if reset_turn
	$neuro_nets.each{ |item| item.performed_turn = false }
      end
    end
  end
end
