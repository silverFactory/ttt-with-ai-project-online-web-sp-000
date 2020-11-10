require 'pry'
module Players
  class Human < Player
    def move(board)
      puts "Please make a move. (1-9)"
      move = gets.chomp
    end
  end

  class Computer < Player
    CORNER_SPOTS = [0, 2, 6, 8]
    SIDE_SPOTS = [1, 3, 5, 7]
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

    def move(board)
      my_move = nil
      sleep(1)
      if board.turn_count <= 2
        #take empty center spot
        if board.cells[4] == " "
          my_move = 4
        else
          #take random empty corner spot
          potential_pick = 100
          until board.cells[potential_pick] == " " do
            potential_pick = CORNER_SPOTS.sample
          end
          my_move = potential_pick
        end #turn 1 & 2 end
      end #first turns
      if board.turn_count >= 3
        #if you have two out of three win_comb, then take it!
        WIN_COMBINATIONS.each do |w_c|
          if w_c.select{|e| board.cells[e] == self.token}.length == 2
            my_move = w_c.detect{|e| board.cells[e] == " "}
          end
        end #move-to-win end
        if my_move == nil
          #figure out oppenent token to search for
            opponent_token = nil
            self.token == "X" ? opponent_token = "O" : opponent_token = "X"
            #opponent has two out of three win_comb slots, move to block
            WIN_COMBINATIONS.each do |w_c|
             token_array = w_c.select{|e| board.cells[e] == opponent_token}
             if token_array.length == 2
               counter = 0
               while counter < 3 do
                 if board.cells[w_c[counter]] == " "
                   my_move = w_c[counter]
                 end
                 counter += 1
               end
             end
           end
        end
        if my_move == nil
            #detect first open slot
            my_move = board.cells.index(" ")
            #binding.pry
        end
       end
      # binding.pry
      my_move += 1
      my_move.to_s
    end #move end
  end #class end
end #module end
