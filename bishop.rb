require_relative "piece"

class Bishop < Piece
  def initialize(row, col, color)
    super(row, col, color)
  end

  def possible_next_spaces(board)
    possible = []
    (1..7).each do |i|
      if i == 1
        possible << [@row + i, @col + i] if 
          (@row + i) < 8 && 
          (@col + i) < 8 && 
          board[@row + i][@col + i].nil? 
        possible << [@row - i, @col - i] if 
          (@row - i) >= 0 && 
          (@col - i) >= 0 &&
          board[@row - i][@col - i].nil?
        possible << [@row + i, @col - i] if 
          (@row + i) < 8 && 
          (@col - i) >= 0 &&
          board[@row + i][@col - i].nil?
        possible << [@row - i, @col + i] if 
          (@row - i) >= 0 && 
          (@col + i) < 8 &&
          board[@row - i][@col + i].nil?
      else
        possible << [@row + i, @col + i] if 
          (@row + i) < 8 && 
          (@col + i) < 8 && 
          board[@row + i - 1][@col + i - 1].nil?
        possible << [@row - i, @col - i] if 
          (@row - i) >= 0 && 
          (@col - i) >= 0 &&
          board[@row - i][@col - i].nil?
        possible << [@row + i, @col - i] if 
          (@row + i) < 8 && 
          (@col - i) >= 0 &&
          board[@row + i][@col - i].nil?
        possible << [@row - i, @col + i] if 
          (@row - i) >= 0 && 
          (@col + i) < 8 &&
          board[@row - i][@col + i].nil?
    end

    possible
  end