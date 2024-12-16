require_relative "../piece"
require_relative "../king"
require_relative "../rook"
require_relative "../queen"



describe King do
  subject(:white_king) { King.new(0, 3, "white") }
  subject(:black_king) { King.new(7, 3, "black") }
  subject(:white_rook_left) { Rook.new(0, 0, "white") }
  subject(:black_queen) { Queen.new(1, 4, "black") }
  subject(:white_queen) { Queen.new(0, 2, "white") }
  subject(:white_rook_right) { Rook.new(0, 7, "white") }
  subject(:black_rook) { Rook.new(7, 2, "black") }
  subject(:black_rook2) { Rook.new(7, 6, "black") }

  describe "#possible_moves" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    before do
      test_board[0][3] = white_king
      test_board[7][3] = black_king
    end

    it "includes all surrounding squares" do
      expect(white_king.possible_moves(test_board)).to include([0, 2], [0, 4], [1, 2], [1, 3], [1, 4])
    end

    it "does not include out of bounds squares when in first row" do 
      expect(white_king.possible_moves(test_board)).not_to include([-1, 3])
    end

    it "does not include out of bounds squares when in last row" do 
      expect(black_king.possible_moves(test_board)).not_to include([8, 3])
    end

    it "includes the correct moves when piece is in corner" do
      second_white_king = King.new(0, 0, "white")
      test_board[0][0] = second_white_king
      expect(second_white_king.possible_moves(test_board)).to include([0, 1], [1, 0], [1, 1])
    end

    it "excludes the correct moves when piece is in corner" do
      second_white_king = King.new(0, 0, "white")
      test_board[0][0] = second_white_king
      expect(second_white_king.possible_moves(test_board)).not_to include([0, 2], [1, 2], [1, 3], [1, 4])
    end
  end

  describe "#check?" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    before do
      test_board[0][3] = white_king
      test_board[7][3] = black_king
    end

    it "returns false if opponent's pieces not in range" do
      expect(white_king.check?(0, 5, test_board)).to be(false)
    end

    it "returns true if opponent's piece in range" do
      expect(white_king.check?(7, 4, test_board)).to be(true)
    end
  end

  describe "#move" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    before do
      test_board[0][3] = white_king
    end

    it "returns false if move is not possible" do
      expect(white_king.move(7, 0, test_board)).to be(false)
    end

    it "returns false if move would put player in check" do
      test_board[0][1] = King.new(0, 1, "black")
      expect(white_king.move(0, 2, test_board)).to be(false)
    end

    it "updates row if move is legal" do
      white_king.move(0, 2, test_board)
      expect(white_king.row).to eq(0)
    end

    it "updates col if move is legal" do
      white_king.move(0, 2, test_board)
      expect(white_king.col).to eq(2)
    end

    it "returns true if move is legal" do
      expect(white_king.move(0, 2, test_board)).to be(true)
    end

    it "updates the number of times moved" do
      white_king.move(0, 2, test_board)
      expect(white_king.times_moved).to eq(1)
    end
  end

  describe "#checkmate?" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    it "returns false if checkmate not established" do
      test_board[0][3] = white_king
      test_board[0][4] = King.new(0, 4, "black")
      expect(white_king.checkmate?(test_board)).to be(false)
    end
  end

  describe "#can_castle?" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    before do
      test_board[0][4] = white_king
      test_board[0][0] = white_rook_left
      test_board[0][7] = white_rook_right
    end

    it "returns false if king has moved" do
      white_king.times_moved = 1
      expect(white_king.can_castle?("left", test_board)).to be(false)
    end

    it "returns false if king is in check" do
      test_board[1][4] = black_queen
      expect(white_king.can_castle?("left", test_board)).to be(false)
    end

    it "returns false if castling with left rook would move king through checked space" do
      test_board[7][2] = black_rook
      expect(white_king.can_castle?("left", test_board)).to be(false)
    end

    it "returns false if castling with right rook would move king through checked space" do
      test_board[7][6] = black_rook2
      expect(white_king.can_castle?("right", test_board)).to be(false)
    end

    it "returns false if castling with left rook and spaces in between not empty" do
      test_board[0][2] = white_queen
      expect(white_king.can_castle?("left", test_board)).to be(false)
    end

    it "returns false if castling with left rook and spaces in between not empty" do
      test_board[0][5] = white_queen
      expect(white_king.can_castle?("right", test_board)).to be(false)
    end

    it "returns true if castling with left rook and spaces in bt empty and no issues with check" do
      expect(white_king.can_castle?("left", test_board)).to be(true)
    end
    
    it "returns true if castling with right rook and spaces in bt empty and no issues with check" do
      expect(white_king.can_castle?("right", test_board)).to be(true)
    end
  end
end
