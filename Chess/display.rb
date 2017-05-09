require 'colorize'
require_relative 'board'
require_relative 'cursor'
require 'byebug'

class Display

  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system("clear")

    (0..7).each do |row|
      (0..7).each do |col|
        if (row.even? && col.even?) || (row.odd? && col.odd?)
          if @cursor.cursor_pos == [row, col]
            print " #{@board[[row,col]].name} ".colorize(background: :yellow)
          else
            print " #{@board[[row,col]].name} ".colorize(color: :light_blue, background: :black)
          end
        else
          if @cursor.cursor_pos == [row, col]
            print " #{@board[[row,col]].name} ".colorize(background: :yellow)
          else
            print " #{@board[[row,col]].name} ".colorize(color: :light_blue, background: :white)
          end
        end
      end
      puts ""
    end

  end

  def move_cursor
    while true
      @cursor.get_input
      self.render
    end
  end

end
