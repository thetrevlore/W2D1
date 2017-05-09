require_relative "piece.rb"


class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    self.make_starting_grid
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a? NullPiece
      raise NoPieceAtPos
    elsif self[start_pos].moves(start_pos).include? end_pos
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.new
    else
      raise InvalidEndPos
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def in_bounds?(pos)
    return true if pos[0].between?(0, 7) && pos[1].between?(0, 7)
    false
  end

  protected
  def make_starting_grid
    self.grid[1].map! { |space| space = Pawn.new("P", self, :black)}
    self.grid[6].map! { |space| space = Pawn.new("P", self, :white)}

    self[[0, 0]] = Rook.new("R", self, :black)
    self[[0, 7]] = Rook.new("R", self, :black)
    self[[7, 0]] = Rook.new("R", self, :white)
    self[[7, 7]] = Rook.new("R", self, :white)

    self[[0, 1]] = Knight.new("H", self, :black)
    self[[0, 6]] = Knight.new("H", self, :black)
    self[[7, 1]] = Knight.new("H", self, :white)
    self[[7, 6]] = Knight.new("H", self, :white)

    self[[0, 2]] = Bishop.new("B", self, :black)
    self[[0, 5]] = Bishop.new("B", self, :black)
    self[[7, 2]] = Bishop.new("B", self, :white)
    self[[7, 5]] = Bishop.new("B", self, :white)

    self[[0, 3]] = Queen.new("Q", self, :black)
    self[[7, 3]] = Queen.new("Q", self, :white)

    self[[0, 4]] = King.new("K", self, :black)
    self[[7, 4]] = King.new("K", self, :white)

    (2..5).each do |i|
      self.grid[i].map! do |space|
        space = NullPiece.new
      end
    end
  end
end

class NoPieceAtPos < StandardError
  def message
    puts "There isn't a piece at that position."
  end
end

class InvalidEndPos < StandardError
  def message
    puts "Invalid move."
  end
end
