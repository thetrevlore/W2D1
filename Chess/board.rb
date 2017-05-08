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
    elsif !self[end_pos].is_a? NullPiece
      raise InvalidEndPos
    else
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.new
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
    (0..1).each do |i|
      self.grid[i].map! { |space| space = Piece.new }
    end

    (6..7).each do |i|
      self.grid[i].map! { |space| space = Piece.new }
    end

    (2..5).each do |i|
      self.grid[i].map! { |space| space = NullPiece.new }
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
