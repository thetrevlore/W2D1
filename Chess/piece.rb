class Piece
  attr_accessor :name

  def initialize(name = " p ")
    @name = name
  end
end

class NullPiece < Piece
  def initialize
  end

  def name
    "   "
  end
end
