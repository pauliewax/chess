require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def show
    loop do
      render
      cursor.get_input
    end
  end

  def render
    selectedX, selectedY = cursor.cursor_pos
    divider = "\n-------------------------------"
    rendered_rows = board.grid.map.with_index do |row, row_num|
      if row_num == selectedX
        render_row(row, selectedY) + divider
      else
        render_row(row) + divider
      end
    end.join("\n")

    top_row = "-------------------------------\n"
    puts [top_row, rendered_rows].join
  end

  def render_row(row, selectedY = nil)
    row_chars = row.map.with_index do |square, col_num|
      if col_num == selectedY && cursor.selected == true
        square.nil? ? " O ".green : " X ".green
      elsif col_num == selectedY
        square.nil? ? " O ".red : " X ".red
      else
        square.nil? ? " O " : " X "
      end
    end

    row_chars.join("|")
  end

end

b = Board.new
disp = Display.new(b)

disp.show
