require 'byebug'

class Piece
  def initialize(board, pos)
    @board = board
    @pos = pos
  end
end

module SlidingPiece
  def moves(pos)
  end

  # private
  def move_dirs(pos)
  end

  def horizontal_dirs
    deltas = [[1,0],[0,1],[-1,0],[0,-1]]
    horizontal_moves = []
    deltas.each do |delta|
      horizontal_moves.concat(grow_unblocked_moves_in_dir(delta))
    end
    horizontal_moves
  end

  def diagonal_dirs(pos)
  end

  def grow_unblocked_moves_in_dir(delta)
    dx, dy = delta
    x, y = @pos
    next_move = [x + dx, y + dy]
    unblocked_moves  = []

    while @board.in_bounds?(next_move)
      break if @board[next_move] == nil
      unblocked_moves << next_move
      x2, y2 = next_move
      next_move = [x2 + dx, y2 + dy]
    end

    unblocked_moves
  end
end

module SteppingPiece

end

class Rook < Piece
  include SlidingPiece
end
