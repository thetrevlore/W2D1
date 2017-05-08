class Piece
  def initialize(name = "p")
    @name = name

  end
end

class NullPiece < Piece

  def initialize(name = "n")
    @name = name
  end
end
