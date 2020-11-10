class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]
  def self.greeting
    puts "Welcome to virtual Tic-Tac-Toe!"
    puts "Please choose game mode:"
    puts "Enter 1 for Single Player vs Computer Player"
    puts "Enter 2 for Single Player vs Single Player"
    puts "Enter 3 for Computer Player vs Computer Player"
  end
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end
  def current_player
    self.board.turn_count.even? ? self.player_1 : self.player_2
  end
  def won?
    #check to see if any of Win comb are all X or O
    winning_array = []
    WIN_COMBINATIONS.each do |w_c|
      w_c_array = []
      w_c.each{|c| w_c_array << self.board.cells[c]}
      if !w_c_array.include?(" ")
        if w_c_array[0] == w_c_array[1] && w_c_array[0] == w_c_array[2]
          winning_array = w_c
        end
      end
    end
    if winning_array != []
      winning_array
    else
      false
    end
  end
  def draw?
    if self.won? == false && self.board.full? == true
      true
    end
  end
  def over?
    if self.draw?
      true
    elsif self.won?
      true
    end
  end
  def winner
    if self.won?
      self.board.cells[self.won?[0]]
    else
      nil
    end
  end
  def turn
    self.board.display
    move = self.current_player.move(self.board)
    if self.board.valid_move?(move)
      self.board.update(move, self.current_player)
    else
      puts "invalid"
      self.turn
    end
  end
  def play
    while !self.over?
      self.turn
    end
    if self.won?
      self.board.display
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      self.board.display
      puts "Cat's Game!"
    end
  end
end
