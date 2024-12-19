require_relative "piece"

class Rook < Piece
  attr_accessor :times_moved
  
  def initialize(row, col, color)
    super(row, col, color)
    @times_moved = 0
  end

  def possible_moves(board)
    possible = []

    ((@row + 1)...8).each do |i|
      break if board[i][@col].is_a?(Piece) && 
               board[i][@col].color == @color
      possible << [i, @col]
      break unless board[i][@col].nil?
    end

    (1..(@row)).each do |i|
      break if board[@row - i][@col].is_a?(Piece) && 
               board[@row - i][@col].color == @color
      possible << [@row - i, @col]
      break unless board[@row - i][@col].nil?
    end

    ((@col + 1)...8).each do |i|
      break if board[@row][i].is_a?(Piece) && 
               board[@row][i].color == @color
      possible << [@row, i]
      break unless board[@row][i].nil?
    end

    (1..(@col)).each do |i|
      break if board[@row][@col - i].is_a?(Piece) && 
               board[@row][@col - i].color == @color
      possible << [@row, @col - i]
      break unless board[@row][@col - i].nil?
    end

    possible
  end

  def can_castle?(rook, board)
    if rook == "left"
      return false unless board[0][3].nil?
    else
      return false unless board[0][5].nil?
    end

    @times_moved == 0
  end

  def move(new_row, new_col, board)
    return false unless self.possible_moves(board).include?([new_row, new_col])
    
    @row = new_row
    @col = new_col
    @times_moved += 1

    true
  end
end
