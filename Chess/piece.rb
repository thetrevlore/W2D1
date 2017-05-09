require_relative 'board'
require 'byebug'

module SteppingPiece
  def moves(start_pos)
    poss_moves = []

    self.move_diffs.each do |diff|
      row = start_pos[0] + diff[0]
      col = start_pos[1] + diff[1]
      new_pos = [row, col]

      if @board.in_bounds?(new_pos) && @board[new_pos].color != self.color # it's not occupied by my own piece
        poss_moves << new_pos
      end
    end

    poss_moves
  end
end

module SlidingPiece
  def moves(start_pos)
    poss_moves = []

    self.move_dirs.each do |dir|
      new_pos = start_pos
      while @board.in_bounds?(new_pos)
        if @board[new_pos].is_a?(NullPiece)
          poss_moves << new_pos
        elsif @board[new_pos].color != self.color
          poss_moves << new_pos
          break
        end
        row = new_pos[0] + dir[0]
        col = new_pos[1] + dir[1]
        new_pos = [row, col]
      end
    end

    poss_moves
  end
end

class Piece
  attr_reader :name, :color

  def initialize(name, board, color)
    @name = name
    @board = board
    @color = color
  end

  def moves
    raise NotImplementedError
  end
end



class Knight < Piece
  include SteppingPiece

  def move_diffs
    diffs = [
      [1, 2],
      [-1, 2],
      [1, -2],
      [-1, -2],
      [-2, -1],
      [2, -1],
      [2, 1],
      [-2, 1]
    ]
  end
end

class King < Piece
  include SteppingPiece

  def move_diffs
    diffs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [1, -1],
      [1, 1],
      [-1, -1],
      [-1, 0],
      [-1, 1]
    ]
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [1, -1],
      [1, 1],
      [-1, -1],
      [-1, 0],
      [-1, 1]
    ]
  end
end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
  end
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    dirs = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end
end

class NullPiece < Piece
  def initialize
  end

  def name
    " "
  end
end
