require "colorize"
require_relative "king"
require_relative "queen"
require_relative "bishop"
require_relative "knight"
require_relative "rook"
require_relative "pawn"

class Chess
  attr_accessor :board
  # Black is at top of board (array rows 0 and 1), White at bottom (rows 6 and 7)
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    @first_row_pieces = [
      "rook", 
      "knight", 
      "bishop", 
      "queen", 
      "king", 
      "bishop", 
      "knight", 
      "rook"
    ]
    # Store pawns separately so en passant status can be cleared after each turn
    @black_pawns = []
    @white_pawns = []
    # For each space in the first two rows
    (0..7).each do |i|
      # Create the first row piece, then create the pawn on the second row
      @board[0][i] = create_piece(@first_row_pieces[i], 0, i, "black")
      @board[1][i] = create_piece("pawn", 1, i, "black")
      @black_pawns << @board[1][i]
      @board[7][i] = create_piece(@first_row_pieces[i], 7, i, "white")
      @board[6][i] = create_piece("pawn", 6, i, "white")
      @white_pawns << @board[6][i]
    end
    # Store kings seperately to facilitate checking for checkmate
    @black_king = @board[0][4]
    @white_king = @board[7][4]
  end

  def create_piece(type, row, col, color)
    piece_hash = {
      "king" => King, 
      "queen" => Queen, 
      "bishop" => Bishop,
      "knight" => Knight,
      "rook" => Rook,
      "pawn" => Pawn
    }

    piece_hash[type].new(row, col, color)
  end

  # Helper function for printing the appropriate symbol for each space
  def render_cell(row, col)
    space_contents = @board[row][col]
    if space_contents.nil?
      print "_" 
    else
      print space_contents.symbol.colorize(:white) if 
        space_contents.color == "white"
      print space_contents.symbol.colorize(:black) if 
        space_contents.color == "black"
    end
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
    return "white" if @black_king.checkmate?(@board)

    return "black" if @white_king.checkmate?(@board)

    false
  end

  # Function to handle castling between a king and a rook
  def handle_castle(turn)
    puts "Please enter either left or right to identify the Rook you want to castle."
    side = gets.chomp
    return handle_castle(turn) unless side.downcase == "left" || side.downcase == "right"

    rook = nil
    king = nil
    row = nil

    if turn == "black"
      king = @black_king
      row = 0
      if side.downcase == "left"
        rook = @black_rook_left
      else
        rook = @black_rook_right
      end
    else
      king = @white_king
      row = 7
      if side.downcase == "left"
        rook = @white_rook_left
      else
        rook = @white_rook_right
      end
    end
    # Check whether the specified pieces are actually eligible to castle
    return false unless king.can_castle?(side.downcase, @board) && rook.can_castle?(side.downcase, @board)

    if side.downcase == "left"
      king.move(row, 2, @board)
      update_board(row, 4, row, 2, king)
      rook.move(row, 3, @board)
      update_board(row, 0, row, 3, rook)
    else
      king.move(row, 6, @board)
      update_board(row, 4, row, 6, king)
      rook.move(row, 5, @board)
      update_board(row, 7, row, 5, rook)
    end

    true
  end

  def get_row
    row = gets.chomp.downcase
    # Return without doing anything else if the player specified they want to 
    # castle
    return row if row == "castle"

    row_as_int = row.to_i
    unless row_as_int.between?(1, 8)
      puts "Please enter a valid row number."
      return get_row
    end
    # Subtract 1 to support zero-indexing
    row_as_int - 1
  end
  
  def get_col
    cols = ["a", "b", "c", "d", "e", "f", "g", "h"]
    col = gets.chomp.downcase
    unless cols.include?(col)
      puts "Please enter a valid column letter."
      return get_col
    end
    # Convert to an int by returning the index of the applicable column letter
    cols.find_index(col)
  end

  def get_from_row
    puts "Please enter a number between 1 and 8 for the row of the piece you " +
         "would like to move, type 'castle' if you would like to castle."
    
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
    from_row = get_from_row

    if from_row == "castle"
      unless handle_castle(turn)
        puts "Cannot castle on that side."
        return get_piece_to_move(turn)
      end
      # If player chooses to castle and can legally castle, don't need to do
      # anything else so just return "castled" as the from_row and nil for
      # the piece to move and the from_col
      return [nil, "castled", nil]
    end

    from_col = get_from_col
    piece_to_move = @board[from_row][from_col]
   
    if piece_to_move.nil? || piece_to_move.color != turn
      # Handle case where player tries to select a space to move from and that 
      # space doesn't include one of the  player's pieces
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
    # If the player can legally make this move, piece.move moves the piece as 
    # specified. Otherwise, print an error message and prompt the player for 
    # another space to move to
    unless piece.move(dest_row, dest_col, @board)
      puts "You can't move to that space. Please enter a valid space to move " +
           "this piece to."
      return move_piece(piece)
    end

    nil
  end

  def update_board(from_row, from_col, to_row, to_col, piece)
    temp = @board[from_row][from_col]
    @board[from_row][from_col] = nil
    @board[to_row][to_col] = temp
    # Handle en passant
    if piece.is_a?(Pawn) && from_col != to_col
      if @board[from_row][to_col].is_a?(Pawn) && 
         @board[from_row][to_col].en_passant_eligible && 
         @board[from_row][to_col].color != piece.color
         @board[from_row][to_col] = nil 
      end
    end
  end

  def handle_promotion(dest_row, dest_col, color)
    promotion_choices = ["rook", "bishop", "queen", "knight"]

    puts "Please specify what rank you want to promote the pawn to: rook, " + 
         "bishop, queen, or knight."

    promotion_rank = gets.chomp.downcase

    unless promotion_choices.include?(promotion_rank)
      return handle_promotion(dest_row, dest_col)
    end

    if promotion_rank == "rook"
      times_moved_temp = @board[dest_row][dest_col].times_moved
      @board[dest_row][dest_col] = Rook.new(dest_row, dest_col, color)
      @board[dest_row][dest_col].times_moved = times_moved_temp
    elsif promotion_rank == "queen"
      @board[dest_row][dest_col] = Queen.new(dest_row, dest_col, color)
    elsif promotion_rank == "bishop"
      @board[dest_row][dest_col] = Bishop.new(dest_row, dest_col, color)
    elsif promotion_rank == "knight"
      @board[dest_row][dest_col] = Knight.new(dest_row, dest_col, color)
    end

    nil
  end

  def reset_en_passant(turn)
    pawns = turn == "white" ? @white_pawns : @black_pawns

    pawns.each do |pawn|
      pawn.en_passant_eligible = false
    end

    nil
  end

  def game
    turn = "white"

    until winner?
      puts "It's #{turn}'s turn!"
      print_board
      # Track whether or not the player has entered a valid move
      move_entered = false
      # Set en passant to false for all the pieces of the player whose turn it is
      reset_en_passant(turn)

      until move_entered
        piece_to_move, from_row, from_col = get_piece_to_move(turn)
        # Move is handled via handle_castle if player is castling
        unless from_row == "castled"
          dest_row, dest_col = [get_to_row, get_to_col]
          turn_king = turn == "white" ? @white_king : @black_king

          if !piece_to_move.is_a?(King) && turn_king.check?(turn_king.row, turn_king.col, @board)
            puts "Your king is in check. You must move your king on this turn."
          elsif piece_to_move.move(dest_row, dest_col, @board)
            move_entered = true
            update_board(from_row, from_col, dest_row, dest_col, piece_to_move)
            handle_promotion(dest_row, dest_col, turn) if piece_to_move.is_a?(Pawn) && 
              ((turn == "white" && dest_row == 0) || (turn == "black" && dest_row == 7))
          else
            puts "The coordinates you entered are invalid. Please enter a valid " + 
                  "space to move this piece to."
          end
        end

        move_entered = true if from_row == "castled"
      end

      turn = turn == "white" ? "black" : "white"
    end

    print_board
    puts "#{winner?} is the winner!" 
  end
end

#test_game = Chess.new
#test_game.game