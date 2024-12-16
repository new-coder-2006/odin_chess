require_relative "piece"

class Knight < Piece
  def initialize(row, col, color)
    super(row, col, color)
  end

  def possible_moves(board)
    possible = []

    if (@row + 2).between?(0,7) && (@col + 1).between?(0,7)
      possible << [@row + 2, @col + 1] unless 
        (
          board[@row + 2][@col + 1].is_a?(Piece) && 
          board[@row + 2][@col + 1].color == @color
        )
    end
    if (@row - 2).between?(0,7) && (@col - 1).between?(0,7)
      possible << [@row - 2, @col - 1] unless 
        (
          board[@row - 2][@col - 1].is_a?(Piece) && 
          board[@row - 2][@col - 1].color == @color
        )
    end
    if (@row + 2).between?(0,7) && (@col - 1).between?(0,7)
      possible << [@row + 2, @col - 1] unless 
        (
          board[@row + 2][@col - 1].is_a?(Piece) && 
          board[@row + 2][@col - 1].color == @color
        )
    end
    if (@row - 2).between?(0,7) && (@col + 1).between?(0,7)
      possible << [@row - 2, @col + 1] unless 
        (
          board[@row - 2][@col + 1].is_a?(Piece) && 
          board[@row - 2][@col + 1].color == @color
        )
    end
    if (@row + 1).between?(0,7) && (@col + 2).between?(0,7)
      possible << [@row + 1, @col + 2] unless 
        (
          board[@row + 1][@col + 2].is_a?(Piece) && 
          board[@row + 1][@col + 2].color == @color
        )
    end
    if (@row - 1).between?(0,7) && (@col - 2).between?(0,7)
      possible << [@row - 1, @col - 2] unless 
        (
          board[@row - 1][@col - 2].is_a?(Piece) && 
          board[@row - 1][@col - 2].color == @color
        )
    end
    if (@row + 1).between?(0,7) && (@col - 2).between?(0,7)
      possible << [@row + 1, @col - 2] unless 
        (
          board[@row + 1][@col - 2].is_a?(Piece) && 
          board[@row + 1][@col - 2].color == @color
        )
    end
    if (@row - 1).between?(0,7) && (@col + 2).between?(0,7)
      possible << [@row - 1, @col + 2] unless 
        (
          board[@row - 1][@col + 2].is_a?(Piece) && 
          board[@row - 1][@col + 2].color == @color
        )
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