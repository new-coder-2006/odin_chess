require_relative "../piece"
require_relative "../king"
require_relative "../rook"
require_relative "../queen"
require_relative "../pawn"

describe Pawn do
  subject(:white_pawn) { Pawn.new(6, 3, "white") }
  subject(:black_pawn) { Pawn.new(5, 3, "black") }
  subject(:black_pawn2) { Pawn.new(6, 4, "black") }
  subject(:black_queen) { Pawn.new(5, 2, "black") }

  describe "#possible_moves" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    context "when the other spaces are empty" do
      before do
        test_board[6][3] = white_pawn
      end

      it "includes space that is two rows forward if pawn hasn't moved" do
        expect(white_pawn.possible_moves(test_board)).to include([4, 3])
      end

      before do
        white_pawn.move(5, 3, test_board)
      end

      it "does not include space that is two rows forward if pawn has moved" do
        expect(white_pawn.possible_moves(test_board)).not_to include([3, 3])
      end

      it "includes space that is one row forward regardless of whether pawn has moved" do
        expect(white_pawn.possible_moves(test_board)).to include([4, 3])
      end

      it "does not include any other adjacent spaces" do
        expect(white_pawn.possible_moves(test_board)).not_to include([3, 3], [3, 2], [3, 4], [4, 2], [4, 4], [5, 2], [5, 4])
      end

      it "does not include space where the pawn is currently located" do
        expect(white_pawn.possible_moves(test_board)).not_to include([5, 3])
      end
    end 

    context "when opponent piece is on board" do
      before do
        test_board[6][3] = white_pawn
        test_board[5][3] = black_pawn
        test_board[5][2] = black_queen
        test_board[6][4] = black_pawn2
        black_pawn2.en_passant_eligible = true
      end

      it "does not include space one row forward if opponent's piece is on it" do
        expect(white_pawn.possible_moves(test_board)).not_to include([5, 3])
      end

      it "does not include space two rows forward if opponent's piece is on it" do
        expect(white_pawn.possible_moves(test_board)).not_to include([4, 3])
      end

      it "includes diagonal space if opponent's piece is on it" do
        expect(white_pawn.possible_moves(test_board)).to include([5, 2])
      end

      it "includes diagonal space if opponent's pawn is en passant eligible" do
        expect(white_pawn.possible_moves(test_board)).to include([5, 4])
      end
    end
  end

  describe "#move" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    it "becomes en passant eligible when moving two spaces forward on initial turn" do
      white_pawn.move(4, 3, test_board)
      expect(white_pawn.en_passant_eligible).to be(true)
    end
  end
end