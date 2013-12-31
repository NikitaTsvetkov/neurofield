class Player
  attr_reader :hunger, :fatigue, :dead
  attr_accessor :performed_turn, :coor_x, :coor_y
  def fatigue= (x)
    @dead = (x > 100)
    @fatigue = x if (x >= 0) and ( x <= 100)
  end
  def hunger= (x)
    @dead = (x > 100)
    @hunger = x if (x >= 0) and ( x <= 100)
  end
  def initialize coor_x, coor_y
    self.coor_x , self.coor_y = coor_x, coor_y
    @hunger = 50
    @fatigue = 50
    @dead = false
  end
  def eat (cell_content)
    if cell_content == -1
      self.hunger -= 2
    end
    0
  end
  def sleep 
    self.fatigue -= 2 
  end
  def turn
    self.hunger += 1
    self.fatigue += 1
  end
end