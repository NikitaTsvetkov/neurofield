class GetFieldController < ApplicationController
  def field_state
    if $neuro_nets and $field
      field_to_show = self.copy_field
      $neuro_nets.each |key, value| do
	field_to_show[value.x][value.y] = key
      end
      render :json => field_to_show 
    end
  end
  
  def player_state id
    render :json => $neuro_nets[id]
  end
  private
  def copy_field
    new_field = $field.inject([]) do |accum, item|
      new_element = item.map{ |x| x }
      accum << new_element
    end
  end
end
