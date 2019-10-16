class Game
  
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = [
    [0, 1, 2], 
    [3, 4, 5], 
    [6, 7, 8], 
    [0, 3, 6], 
    [1, 4, 7], 
    [2, 5, 8], 
    [0, 4, 8], 
    [2, 4, 6]
    ]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  
  def current_player
    self.board.turn_count.even? ? self.player_1 : self.player_2
  end
  
  def won?
    WIN_COMBINATIONS.detect do |com|
      self.board.taken?(com[0]+1) && self.board.cells[com[0]] == self.board.cells[com[1]] &&
      self.board.cells[com[1]] == self.board.cells[com[2]]
    end
  end
  
  def full?
    self.board.cells.all? {|place| place != " "}
  end
  
  def draw?
    full? && !won?
  end
  
  def over?
    won? || draw?
  end
  
  def winner
    !!won? ? self.board.cells[won?[0]] : nil
  end
  
  def turn
    current_move = current_player.move(self.board)
    if self.board.valid_move?(current_move)
      self.board.update(current_move, current_player)
    else
      turn
    end
  end
  
  def play
    turn until over? || draw?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
    
end