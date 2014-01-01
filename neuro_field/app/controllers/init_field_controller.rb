require 'player'
require 'field'
class InitFieldController < ApplicationController
  def init 
    $neuro_nets = nil
    $x, $y = params[:x].to_i, params[:y].to_i
    $field = Field.new $x, $y, nil
    $initialized = true
    render json: [$field, $neuro_nets]
  end
  def register 
    id = params[:id].to_i
    $neuro_nets = Hash.new unless $neuro_nets
    begin
      x, y = Random.rand($x), Random.rand($y)
    end while ($field[y][x] != 0 )
    
    $neuro_nets[id] = Player.new(x, y) 
    render json: [$field, $neuro_nets]
    
  end
end
