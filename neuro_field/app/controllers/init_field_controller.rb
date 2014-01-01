require 'player'
require 'field'
class InitFieldController < ApplicationController
  def init 
    $neuro_nets = nil
    $x, $y = params[:x].to_i, params[:y].to_i
    $field = Field.new $x, $y, nil
    $initialized = true
    $lock_field = Mutex.new
    $lock_nets = Mutex.new 
    render json: [$field, $neuro_nets]
  end
  def register 
    id = params[:id].to_i
    $lock_nets.synchronize do
      $neuro_nets = Hash.new unless $neuro_nets
    end
    begin
      x, y = Random.rand($x), Random.rand($y)
    end while ($field[y][x] != 0 )
    $lock_nets.synchronize do
      $neuro_nets[id] = Player.new(x, y) 
    end
    render json: [$field, $neuro_nets]
    
  end
end
