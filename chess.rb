require "colorize"
require_relative "king"
require_relative "queen"

class Chess
  attr_accessor :board
  # Black is at top of board (array rows 0 and 1), White at bottom (rows 6 and 7)
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    @black_king = King.new(0, 4, "black")
    @black_queen = Queen.new(0, 3, "black")
    @white_king = King.new(7, 4, "white")
    @white_queen = Queen.new(7, 3, "white")
    @board[0][4] = @black_king
    @board[0][3] = @black_queen
    @board[7][4] = @white_king
    @board[7][3] = @white_queen
  end

  def render_cell(row, col)
    space_contents = @board[row][col]
    print "_" if space_contents.nil?
    print "K".colorize(:white) if 
      space_contents.is_a?(King) && 
      space_contents.color == "white"
    print "Q".colorize(:white) if 
      space_contents.is_a?(Queen) && 
      space_contents.color == "white"
    print "K".colorize(:black) if 
      space_contents.is_a?(King) && 
      space_contents.color == "black"
    print "Q".colorize(:black) if 
      space_contents.is_a?(Queen) && 
      space_contents.color == "black"
  end

  def print_board
    (0...8).each do |row|
      (0...8).each do |col|
        print "|"
        render_cell(row, col)
        print "|" if col == 7
      end
      puts
    end
  end

  def winner?
    return "black" if @black_king.checkmate?(@board)

    return "white" if @white_king.checkmate?(@board)

    false
  end

  def get_row
    row = gets.chomp.to_i
    unless row.between?(1, 8)
      puts "Please enter a valid row number."
      return get_row
    end
    # Subtract 1 to support zero-indexing
    row - 1
  end
  
  def get_col
    cols = ["a", "b", "c", "d", "e", "f", "g", "h"]
    col = gets.chomp
    unless cols.include?(col)
      puts "Please enter a valid column letter."
      return get_col
    end
    # Convert to an int by returning the index of the applicable column letter
    cols.find_index(col)
  end

  def get_from_row
    puts "Please enter a number between 1 and 8 for the row of the piece you " +
         "would like to move."
    
    get_row
  end

  def get_to_row
    puts "Please enter a number between 1 and 8 for the row you would like to " +
         "move the piece to."
    
    get_row
  end

  def get_from_col
    puts "Please enter a letter between a and h for the column of the piece you " +
         "would like to move."
    
    get_col
  end

  def get_to_col
    puts "Please enter a letter between a and h for the column you would like to " +
         "move the piece to."
    
    get_col
  end

  def get_piece_to_move(turn)
    from_row, from_col = [get_from_row, get_from_col]
    piece_to_move = @board[from_row][from_col]

    if piece_to_move.nil? || piece_to_move.color != turn
      puts "This space does not contain one of your pieces. Please enter the " +
           "coordinates for a space containing one of your pieces."
      print_board
      return get_piece_to_move(turn)
    else
      [piece_to_move, from_row, from_col]
    end
  end

  def move_piece(piece)
    dest_row, dest_col = [get_to_row, get_to_col]

    unless piece.move(dest_row, dest_col, @board)
      puts "You can't move to that space. Please enter a valid space to move " +
           "this piece to."
      return move_piece(piece)
    end

    nil
  end

  def update_board(from_row, from_col, to_row, to_col)
    temp = @board[from_row][from_col]
    @board[from_row][from_col] = nil
    @board[to_row][to_col] = temp 
  end

  def game
    turn = "white"
    puts "It's #{turn}'s turn!"

    until winner?
      print_board
      move_entered = false

      until move_entered
        piece_to_move, from_row, from_col = get_piece_to_move(turn)
        dest_row, dest_col = [get_to_row, get_to_col]

        if piece_to_move.move(dest_row, dest_col, @board)
          move_entered = true
          update_board(from_row, from_col, dest_row, dest_col)
        else
          puts "The coordinates you entered are invalid. Please enter a valid " + 
               "space to move this piece to."
        end
      end

      turn = turn == "white" ? "black" : "white"
    end

    print_board
    puts "#{winner?} is the winner!" 
  end
end

#test_game = Chess.new
#test_game.game