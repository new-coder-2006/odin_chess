require_relative "piece"

class Queen < Piece
  def initialize(row, col, color)
    super(row, col, color)
  end

  def possible_moves(board)
    possible = []

    ((@row + 1)...8).each do |i|
      break if @board[@row + i][@col].is_a?(Piece) && 
               @board[@row + i][@col].color == @color
      possible << [@row + i][@col]
      break unless @board[@row + i][@col].nil?
    end

    (1..(@row)).each do |i|
      break if @board[@row - i][@col].is_a?(Piece) && 
               @board[@row - i][@col].color == @color
      possible << [@row - i][@col]
      break unless @board[@row - i][@col].nil?
    end

    ((@col + 1)...8).each do |i|
      break if @board[@row][@col + i].is_a?(Piece) && 
               @board[@row][@col + i].color == @color
      possible << [@row][@col + i]
      break unless @board[@row][@col + i].nil?
    end

    (1..(@col)).each do |i|
      break if @board[@row][@col - i].is_a?(Piece) && 
               @board[@row][@col - i].color == @color
      possible << [@row][@col - i]
      break unless @board[@row][@col - i].nil?
    end

    ((@row + 1)...8).each do |i|
      ((@col + 1)...8).each do |j|
        break if @board[row + i][@col + j].is_a?(Piece) && 
                 @board[row + i][@col + j].color == @color
        possible << [@row + i][@col + j]
        break unless @board[@row + i][@col + j].nil?
      end
    end

    ((@row + 1)...8).each do |i|
      (1..(@col)).each do |j|
        break if @board[row + i][@col - j].is_a?(Piece) && 
                 @board[row + i][@col - j].color == @color
        possible << [@row + i][@col - j]
        break unless @board[@row + i][@col - j].nil?
      end
    end

    (1..(@row)).each do |i|
      (1..(@col)).each do |j|
        break if @board[row - i][@col - j].is_a?(Piece) && 
                 @board[row - i][@col - j].color == @color
        possible << [@row - i][@col - j]
        break unless @board[@row - i][@col - j].nil?
      end
    end

    (1..(@row)).each do |i|
      ((@col + 1)...8).each do |j|
        break if @board[row - i][@col + j].is_a?(Piece) && 
                 @board[row - i][@col + j].color == @color
        possible << [@row - i][@col + j]
        break unless @board[@row - i][@col + j].nil?
      end
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