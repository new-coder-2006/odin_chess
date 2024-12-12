require_relative "piece"

class Bishop < Piece
  def initialize(row, col, color)
    super(row, col, color)
  end

  def possible_moves(board)
    possible = []

    (1..7).each do |i|
      break if (@row + i) > 7 || (@col + i) > 7
      break if board[@row + i][@col + i].is_a?(Piece) &&
               board[@row + i][@col + i].color == @color
      possible << [@row + i, @col + i]
      break unless board[@row + i][@col + i].nil?
    end

    (1..7).each do |i|
      break if (@row - i) < 0 || (@col - i) < 0
      break if board[@row - i][@col - i].is_a?(Piece) &&
               board[@row - i][@col - i].color == @color
      possible << [@row - i, @col - i]
      break unless board[@row - i][@col - i].nil?
    end

    (1..7).each do |i|
      break if (@row + i) > 7 || (@col - i) < 0
      break if board[@row + i][@col - i].is_a?(Piece) &&
               board[@row + i][@col - i].color == @color
      possible << [@row + i, @col - i]
      break unless board[@row + i][@col - i].nil?
    end

    (1..7).each do |i|
      break if (@row - i) < 0 || (@col + i) > 7
      break if board[@row - i][@col + i].is_a?(Piece) &&
               board[@row - i][@col + i].color == @color
      possible << [@row - i, @col + i]
      break unless board[@row - i][@col + i].nil?
    end

    possible
  end

  def move(new_row, new_col, board)
    return false unless self.possible_moves(board).include?([new_row, new_col])
    
    @row = new_row
    @col = new_col

    true
  end
end