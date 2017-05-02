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
    selected_row, selected_col = cursor.cursor_pos
    divider = "\n-----------------------------------"
    rendered_rows = board.grid.map.with_index do |row, row_num|
      to_render = (row_num == selected_row ? [row, selected_col] : [row, nil])
      "#{row_num} |" + render_row(*to_render) + "|" + divider
    end.join("\n")
    num_row = "    0   1   2   3   4   5   6   7\n"
    top_row = "-----------------------------------\n"
    puts [num_row, top_row, rendered_rows].join
  end

  def render_row(row, selected_col)
    row_chars = row.map.with_index do |square, col_num|
      if col_num == selected_col && cursor.selected == true
        square.nil? ? " O ".green : " X ".green
      elsif col_num == selected_col
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
