require_relative "piece"

class Knight < Piece
  def initialize(row, col, color)
    super(row, col, color)
  end

  def possible_moves(board)
    possible = []

    possible << [row + 2, col + 1] unless 
      (
        board[row + 2][col + 1].is_a?(Piece) && 
        board[row + 2][col + 1].color == @ color) if (row + 2
      ) || 
      (row + 2) > 8 || 
      (col + 1) > 8
    possible << [row - 2, col - 1] if (row - 2) >= 0 && (col - 1) >= 0
    possible << [row + 2, col - 1] if (row + 2) < 8 && (col - 1) >= 0
    possible << [row - 2, col + 1] if (row - 2) >= 0 && (col + 1) < 8
    possible << [row + 1, col + 2] if (row + 1) < 8 && (col + 2) < 8
    possible << [row - 1, col - 2] if (row - 1) >= 0 && (col - 2) >= 0
    possible << [row + 1, col - 2] if (row + 1) < 8 && (col - 2) >= 0
    possible << [row - 1, col + 2] if (row - 1) >= 0 && (col + 2) < 8

    possible
  end
end