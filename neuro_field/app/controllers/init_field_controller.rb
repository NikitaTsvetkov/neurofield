class InitFieldController < ApplicationController
  def init x, y
    $x, $y = x, y
    $field = Array.new(x) do |i|
      Array.new(y); 
    end
    $initialized? = true
  end
  def register id
    $neuro_nets = Hash.new unless $neuro_net
    begin
      x, y = Random.rand($x), Random.rand($y)
    end while ($field[x][y] != 0 )
    
    $neuro_nets[id] = Player.new(x, y) 
    
  end
end
