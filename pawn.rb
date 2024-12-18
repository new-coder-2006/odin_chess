require_relative "piece"

class Pawn < Piece
  attr_accessor :en_passant_eligible

  def initialize(row, col, color, times_moved = 0)
    super(row, col, color)
    @times_moved = times_moved
    @en_passant_eligible = false
  end

  def possible_moves(board)
    possible = []

    if @color == "white"
      possible << [@row - 1, @col] if board[@row - 1][@col].nil?
      possible << [@row - 2, @col] if 
        @times_moved == 0 && 
        board[@row - 2][@col].nil? && 
        board[@row - 1][@col].nil?
      possible << [@row - 1, @col - 1] if 
        (
          board[@row - 1][@col - 1].is_a?(Piece) && 
          board[@row - 1][@col - 1].color != @color
        ) || 
        (
          board[@row][@col - 1].is_a?(Pawn) && 
          board[@row - 1][@col - 1].nil? && 
          board[@row][@col - 1].en_passant_eligible
        )
      possible << [@row - 1, @col + 1] if 
        (
          board[@row - 1][@col + 1].is_a?(Piece) && 
          board[@row - 1][@col + 1].color != @color
        ) || 
        (
          board[@row][@col + 1].is_a?(Pawn) && 
          board[@row - 1][@col + 1].nil? && 
          board[@row][@col + 1].en_passant_eligible
        ) 
    end

    if @color == "black"
      possible << [@row + 1, @col] if board[@row + 1][@col].nil?
      possible << [@row + 2, @col] if 
        @times_moved == 0 && 
        board[@row + 2][@col].nil? && 
        board[@row + 1][@col].nil?
      possible << [@row + 1, @col - 1] if 
        (
          board[@row + 1][@col - 1].is_a?(Piece) && 
          board[@row + 1][@col - 1].color != @color
        ) || 
        (
          board[@row][@col - 1].is_a?(Pawn) && 
          board[@row + 1][@col - 1].nil? && 
          board[@row][@col - 1].en_passant_eligible
        )
      possible << [@row + 1, @col + 1] if 
        (
          board[@row + 1][@col + 1].is_a?(Piece) && 
          board[@row + 1][@col + 1].color != @color
        ) || 
        (
          board[@row][@col + 1].is_a?(Pawn) && 
          board[@row + 1][@col + 1].nil? && 
          board[@row][@col + 1].en_passant_eligible
        ) 
    end
    
    possible
  end

  def move(new_row, new_col, board)
    return false unless self.possible_moves(board).include?([new_row, new_col])

    if @color == "white" && @times_moved == 0 && new_row - @row == -2 ||
       @color == "black" && @times_moved == 0 && new_row - @row == 2
      @en_passant_eligible = true
    end

    @row = new_row
    @col = new_col
    @times_moved += 1

    true
  end
end
     
