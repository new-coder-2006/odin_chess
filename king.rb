require_relative "piece"

class King < Piece
  attr_accessor :times_moved

  def initialize(row, col, color)
    super(row, col, color)
    @times_moved = 0
  end

  def possible_moves(board)
    possible = []

    possible << [@row + 1, @col] if @row + 1 < 8
    possible << [@row - 1, @col] if @row - 1 >= 0
    possible << [@row, @col + 1] if @col + 1 < 8
    possible << [@row, @col - 1] if @col - 1 >= 0
    possible << [@row + 1, @col + 1] if @row + 1 < 8 && @col + 1 < 8
    possible << [@row - 1, @col - 1] if @row - 1 >= 0 && @row - 1 >= 0
    possible << [@row + 1, @col - 1] if @row + 1 < 8 && @col - 1 >= 0
    possible << [@row - 1, @col + 1] if @row - 1 >= 0 && @col + 1 < 8

    possible
  end

  def check?(row, col, board)
    board.each do |board_row|
      board_row.each do |space|
        unless space.nil?
          if space.color != @color
            return space.possible_moves(board).include?([row, col])
          end
        end
      end
    end

    false
  end

  def checkmate?(board)
    self.possible_moves(board).all? { |row, col| check?(row, col, board) } || 
    (self.possible_moves(board).empty? && self.check?(@row, @col, board))
  end

  def can_castle?(rook, board)
    return false if @times_moved > 0
    return false if check?(@row, @col, board)

    if rook == "left" 
      (1..3).each do |i|
        return false unless board[@row][i].nil?
        return false if check?(@row, i, board)
      end
    elsif rook == "right" 
      (5..6).each do |i|
        return false unless board[@row][i].nil?
        return false if check?(@row, i, board)
      end
    end

    true
  end

  def move(new_row, new_col, board)
    return false unless self.possible_moves(board).include?([new_row, new_col])
    return false if check?(new_row, new_col, board)
    
    @row = new_row
    @col = new_col
    @times_moved += 1

    true
  end
end

