class InitFieldController < ApplicationController
  def init x, y
    
    $field = Array.new(x) do |i|
      Array.new(y); 
    end
    $initialized? = true
  end
  def register id
    $neuro_nets = Hash.new unless $neuro_net
    $neuro_nets[id] = Player.new 
  end
end
