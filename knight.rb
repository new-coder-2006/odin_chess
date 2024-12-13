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
        board[row + 2][col + 1].color == @color
      ) || 
      (row + 2) > 8 || 
      (col + 1) > 8
    possible << [row - 2, col - 1] unless 
      (
        board[row - 2][col - 1].is_a?(Piece) && 
        board[row - 2][col - 1].color == @color
      ) || 
      (row - 2) < 0 || 
      (col - 1) < 0
    possible << [row + 2, col - 1] unless 
      (
        board[row + 2][col - 1].is_a?(Piece) && 
        board[row + 2][col - 1].color == @color
      ) || 
      (row + 2) > 8 || 
      (col - 1) < 0
    possible << [row - 2, col + 1] unless 
      (
        board[row - 2][col + 1].is_a?(Piece) && 
        board[row - 2][col + 1].color == @color
      ) || 
      (row - 2) < 0 || 
      (col + 1) > 8
    possible << [row + 1, col + 2] unless 
      (
        board[row + 1][col + 2].is_a?(Piece) && 
        board[row + 1][col + 2].color == @color
      ) || 
      (row + 1) > 8 || 
      (col + 2) > 8
    possible << [row - 1, col - 2] unless 
      (
        board[row - 1][col - 2].is_a?(Piece) && 
        board[row - 1][col - 2].color == @color
      ) || 
      (row - 1) < 0 || 
      (col - 2) < 0
    possible << [row + 1, col - 2] unless 
      (
        board[row + 1][col - 2].is_a?(Piece) && 
        board[row + 1][col - 2].color == @color
      ) || 
      (row + 1) > 8 || 
      (col - 2) < 0
    possible << [row - 1, col + 2] unless 
      (
        board[row - 1][col + 2].is_a?(Piece) && 
        board[row - 1][col + 2].color == @color
      ) || 
      (row - 1) < 0 || 
      (col + 2) > 8

    possible
  end

  def move(new_row, new_col, board)
    return false unless self.possible_moves(board).include?([new_row, new_col])
    return false if check?(new_row, new_col, board)
    
    @row = new_row
    @col = new_col

    true
  end
end