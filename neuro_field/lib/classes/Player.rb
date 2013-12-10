Class Player
  attr_reader :hunger, :fatigue, :'dead?'
  attr_accessor :'performed_turn?', :coor_x, :coor_y
  def fatigue= (x)
    @dead? = (x > 100)
    @fatigue = x if (x >= 0) and ( x <= 100)
  end
  def hunger= (x)
    @dead? = (x > 100)
    @hunger = x if (x >= 0) and ( x <= 100)
  end
  def initialize
    @hunger = 50
    @fatigue = 50
    @dead? = false
  end
  def eat (cell_content)
    if cell_content == -1
      self.hunger -= 1
    end
    0
  end
  def turn
    self.hunger += 1
    self.fatigue += 1
  end
end