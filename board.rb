require_relative 'piece'
require 'byebug'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_board
  end

  def []=(pos, piece)
    x, y = pos
    grid[x][y] = piece
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def populate_board
    grid.each_with_index do |row, row_num|
      row.each_index do |col_num|
        pos = [row_num, col_num]
        occupied_rows = [0, 1, 6, 7]
        if occupied_rows.include?(row_num)
          self[pos] = Piece.new(nil, pos)
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    move_errors(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def move_errors(start_pos, end_pos)
    if self[start_pos].nil? ||  !(self[end_pos].nil?)
      raise MovementError.new("Not a valid move")
    end
  end

  def in_bounds?(pos)
    pos.all? { |coord| (coord <= 7) && (coord >= 0) }
  end

end

class MovementError < StandardError; end

b = Board.new
rooky = Rook.new(b, [1,0])
p rooky.horizontal_dirs
