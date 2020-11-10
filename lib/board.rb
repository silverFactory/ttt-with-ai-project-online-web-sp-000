class Board
  attr_accessor :cells
  def initialize
    self.reset!
  end
  def reset!
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end
  def position(pos)
    self.cells[pos.to_i-1]
  end
  def full?
    self.cells.detect{|c| c == " "} == nil ? true : false
  end
  def turn_count
    self.cells.length - self.cells.select{|c| c == " "}.length
  end
  def taken?(pos)
    self.cells[pos.to_i-1] == " " ? false : true
  end
  def valid_move?(pos)
    pos.to_i.between?(1, 9) && !self.taken?(pos)
  end
  def update(pos, player)
    self.cells[pos.to_i-1] = "#{player.token}"
  end
end
