require 'byebug'
require 'singleton'

class Piece
  attr_reader :board, :color
  attr_accessor :current_pos
  def initialize(board, color, current_pos)
    @board = board
    @color = color
    @current_pos = current_pos
  end
end

class NullPiece < Piece
  include Singleton

  attr_reader :color, :symbol
  def initialize
    @color = :none
    @symbol = " "
  end
end

module SlidingPiece
  def moves
    move_dirs(self.class.to_s)
  end

  def move_dirs(piece_type)
    case piece_type
    when "Queen" then horizontal_dirs + diagonal_dirs
    when "Bishop" then diagonal_dirs
    when "Rook" then horizontal_dirs
    end
  end

  def horizontal_dirs
    deltas = [[1,0],[0,1],[-1,0],[0,-1]]
    collect_moves(deltas)
  end

  def diagonal_dirs
    deltas = [[1,1],[1,-1],[-1,1],[-1,-1]]
    collect_moves(deltas)
  end

  def collect_moves(deltas)
    deltas.map { |delta| grow_moves_in_dir(*delta) }.flatten(1)
  end

  def grow_moves_in_dir(dx, dy)
    x, y = current_pos
    next_move = [x + dx, y + dy]
    unblocked_moves = []

    loop do
      debugger
      break if board[next_move] == nil
      if board[next_move].class.to_s == "NullPiece"
        unblocked_moves << next_move
      elsif board[next_move].color != self.color
        unblocked_moves << next_move
        break
      else
        break
      end
      x2, y2 = next_move
      next_move = [x2 + dx, y2 + dy]
    end

    unblocked_moves
  end
end

module SteppingPiece
  def moves
    move_diffs(self.class.to_s).map do |dx, dy|
      x, y = current_pos
      next_move = [x + dx, y + dy]
      next_move if (board[next_move].class.to_s == "NullPiece") || (board[next_move].color != self.color)
    end.compact
  end

  def move_diffs(piece_type)
    case piece_type
    when "King" then [[1, 0],[0, 1],[-1, 0],[0, -1],[1, 1],[-1, -1],[-1, 1],[1, -1]]
    when "Knight" then [[2, 1],[2, -1],[-2, 1],[-2, -1],[1, 2],[-1, 2],[1, -2],[-1, -2]]
    end
  end

end

class Rook < Piece
  include SlidingPiece
end

class Queen < Piece
  include SlidingPiece
end

class Bishop < Piece
  include SlidingPiece
end

class Knight < Piece
  include SteppingPiece
end

class King < Piece
  include SteppingPiece
end
