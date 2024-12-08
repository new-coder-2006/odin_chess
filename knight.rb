require_relative "piece"

class Knight < Piece
  def initialize(row, col)
    super(row, col)
  end

  def possible_next_spaces
    possible = []
    possible << [row + 2, col + 1] if (row + 2) < 8 && (col + 1) < 8
    possible << [row - 2, col - 1] if (row - 2) >= 0 && (col - 1) >= 0
    possible << [row + 2, col - 1] if (row + 2) < 8 && (col - 1) >= 0
    possible << [row - 2, col + 1] if (row - 2) >= 0 && (col + 1) < 8
    possible << [row + 1, col + 2] if (row + 1) < 8 && (col + 2) < 8
    possible << [row - 1, col - 2] if (row - 1) >= 0 && (col - 2) >= 0
    possible << [row + 1, col - 2] if (row + 1) < 8 && (col - 2) >= 0
    possible << [row - 1, col + 2] if (row - 1) >= 0 && (col + 2) < 8

    possible
  end