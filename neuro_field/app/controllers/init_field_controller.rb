class InitFieldController < ApplicationController
  def init x, y
    $field = Array.new(x) do |i|
      Array.new(y); 
    end
  end
  def register id
    $neuro_nets = Array.new unless $neuro_net
    $neuro_nets << id 
  end
end
