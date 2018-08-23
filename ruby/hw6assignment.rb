# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
 All_My_Pieces =All_Pieces +
               [rotations( [[0,0],[-1,0],[-2,0],[0,1],[-1,1]]), #not full square figure
               [[[0,0], [-1,0], [-2,0], [1,0], [2,0]], #ultra long (only two)
               [[0,0], [0,1], [0,2], [0,-1], [0,-2]]],
               rotations([[0,0],[1,0],[0,1]])]

def self.next_piece (board)
  Piece.new(All_My_Pieces.sample, board)
end
def self.cheat_piece (board)
  Piece.new([[[0,0]]], board)
end

  # your enhancements here

end

class MyBoard < Board
  def initialize(game)
    super
    @current_block = MyPiece.next_piece(self)
  end
  def rotate_u
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end
  def next_piece
    if @cheat
      @current_block=MyPiece.cheat_piece(self)
      @current_pos = nil
      @cheat= false
    else
      @current_block = MyPiece.next_piece(self)
      @current_pos = nil
    end
  end
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(@current_block.current_rotation.size-1)).each{|index|
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end


  def cheat
    if @score >= 100 and (not @cheat)
      @cheat = true
      @score = @score - 100
    end
  end
end

class MyTetris < Tetris
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_u})
    @root.bind('c', proc {@board.cheat})
  end

end
