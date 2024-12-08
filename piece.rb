class Piece
  attr_accessor :color, :row, :col

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
  end
end