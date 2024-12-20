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
    @black_king = King.new(0, 4, "black")
    @black_queen = Queen.new(0, 3, "black")
    @black_bishop_left = Bishop.new(0, 2, "black")
    @black_bishop_right = Bishop.new(0, 5, "black")
    @black_knight_left = Knight.new(0, 1, "black")
    @black_knight_right = Knight.new(0, 6, "black")
    @black_rook_left = Rook.new(0, 0, "black")
    @black_rook_right = Rook.new(0, 7, "black")
    @black_pawn1 = Pawn.new(1, 0, "black")
    @black_pawn2 = Pawn.new(1, 1, "black")
    @black_pawn3 = Pawn.new(1, 2, "black")
    @black_pawn4 = Pawn.new(1, 3, "black")
    @black_pawn5 = Pawn.new(1, 4, "black")
    @black_pawn6 = Pawn.new(1, 5, "black")
    @black_pawn7 = Pawn.new(1, 6, "black")
    @black_pawn8 = Pawn.new(1, 7, "black")
    @black_pawns = [
      @black_pawn1, @black_pawn2, @black_pawn3, @black_pawn4,
      @black_pawn5, @black_pawn6, @black_pawn7, @black_pawn8
    ]
    @white_king = King.new(7, 4, "white")
    @white_queen = Queen.new(7, 3, "white")
    @white_bishop_left = Bishop.new(7, 2, "white")
    @white_bishop_right = Bishop.new(7, 5, "white")
    @white_knight_left = Knight.new(7, 1, "white")
    @white_knight_right = Knight.new(7, 6, "white")
    @white_rook_left = Rook.new(7, 0, "white")
    @white_rook_right = Rook.new(7, 7, "white")
    @white_pawn1 = Pawn.new(6, 0, "white")
    @white_pawn2 = Pawn.new(6, 1, "white")
    @white_pawn3 = Pawn.new(6, 2, "white")
    @white_pawn4 = Pawn.new(6, 3, "white")
    @white_pawn5 = Pawn.new(6, 4, "white")
    @white_pawn6 = Pawn.new(6, 5, "white")
    @white_pawn7 = Pawn.new(6, 6, "white")
    @white_pawn8 = Pawn.new(6, 7, "white")
    @white_pawns = [
      @white_pawn1, @white_pawn2, @white_pawn3, @white_pawn4,
      @white_pawn5, @white_pawn6, @white_pawn7, @white_pawn8
    ]
    @board[0][4] = @black_king
    @board[0][3] = @black_queen
    @board[0][2] = @black_bishop_left
    @board[0][5] = @black_bishop_right
    @board[0][1] = @black_knight_left
    @board[0][6] = @black_knight_right
    @board[0][0] = @black_rook_left
    @board[0][7] = @black_rook_right
    @board[1][0] = @black_pawn1
    @board[1][1] = @black_pawn2
    @board[1][2] = @black_pawn3
    @board[1][3] = @black_pawn4
    @board[1][4] = @black_pawn5
    @board[1][5] = @black_pawn6
    @board[1][6] = @black_pawn7
    @board[1][7] = @black_pawn8
    @board[7][4] = @white_king
    @board[7][3] = @white_queen
    @board[7][2] = @white_bishop_left
    @board[7][5] = @white_bishop_right
    @board[7][1] = @white_knight_left
    @board[7][6] = @white_knight_right
    @board[7][0] = @white_rook_left
    @board[7][7] = @white_rook_right
    @board[6][0] = @white_pawn1
    @board[6][1] = @white_pawn2
    @board[6][2] = @white_pawn3
    @board[6][3] = @white_pawn4
    @board[6][4] = @white_pawn5
    @board[6][5] = @white_pawn6
    @board[6][6] = @white_pawn7
    @board[6][7] = @white_pawn8
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
    print "B".colorize(:white) if 
      space_contents.is_a?(Bishop) && 
      space_contents.color == "white"
    print "N".colorize(:white) if 
      space_contents.is_a?(Knight) && 
      space_contents.color == "white"
    print "R".colorize(:white) if 
      space_contents.is_a?(Rook) && 
      space_contents.color == "white"
    print "P".colorize(:white) if 
      space_contents.is_a?(Pawn) && 
      space_contents.color == "white"
    print "K".colorize(:black) if 
      space_contents.is_a?(King) && 
      space_contents.color == "black"
    print "Q".colorize(:black) if 
      space_contents.is_a?(Queen) && 
      space_contents.color == "black"
    print "B".colorize(:black) if 
      space_contents.is_a?(Bishop) && 
      space_contents.color == "black"
    print "N".colorize(:black) if 
      space_contents.is_a?(Knight) && 
      space_contents.color == "black"
    print "R".colorize(:black) if 
      space_contents.is_a?(Rook) && 
      space_contents.color == "black"
    print "P".colorize(:black) if 
      space_contents.is_a?(Pawn) && 
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

    return false unless king.can_castle?(side.downcase, @board) && rook.can_castle?(side.downcase, @board)

    if side.downcase == "left"
      king.move(row, 2, @board)
      update_board(row, 4, row, 2)
      rook.move(row, 3, @board)
      update_board(row, 0, row, 3)
    else
      king.move(row, 6, @board)
      update_board(row, 4, row, 6)
      rook.move(row, 5, @board)
      update_board(row, 7, row, 5)
    end

    true
  end

  def get_row
    row = gets.chomp.downcase
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
         "would like to move, type 'castle' if you would like to castle, or " +
         "type 'en passant' if you would like to capture en passant."
    
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

      return [nil, "castled", nil]
    end

    from_col = get_from_col
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

  def update_board(from_row, from_col, to_row, to_col, piece)
    temp = @board[from_row][from_col]
    @board[from_row][from_col] = nil
    @board[to_row][to_col] = temp
    
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
      move_entered = false
      reset_en_passant(turn)

      until move_entered
        piece_to_move, from_row, from_col = get_piece_to_move(turn)
        
        unless from_row == "castled" || from_row == "en passant"
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

        move_entered = true if from_row == "castled" || from_row == "en passant"
      end

      turn = turn == "white" ? "black" : "white"
    end

    print_board
    puts "#{winner?} is the winner!" 
  end
end

test_game = Chess.new
test_game.game