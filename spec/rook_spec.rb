require_relative "../piece"
require_relative "../rook"
require_relative "../king"

describe Rook do
  subject(:black_rook) { Rook.new(0, 0, "black") }
  subject(:white_king) { King.new(6, 0, "white") }
  subject(:black_king) { King.new(5, 0, "black") }

  describe "#possible_moves" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    context "when no other pieces on board" do
      before do
        test_board[0][0] = black_rook
      end

      it "includes all spaces in same row as piece except current space" do
        (1..7).each do |col|
          expect(black_rook.possible_moves(test_board)).to include([0, col])
        end
      end

      it "includes all spaces in same column as piece except current space" do
        (1..7).each do |row|
          if row != 0
            expect(black_rook.possible_moves(test_board)).to include([row, 0])
          end
        end
      end

      it "does not include space that piece currently occupies" do
        expect(black_rook.possible_moves(test_board)).not_to include([0, 0])
      end
    end

    context "when squares between rook and opponent's piece are empty" do
      before do
        test_board[0][0] = black_rook
        test_board[6][0] = white_king
      end

      it "includes space where the opponent's piece is located" do
        expect(black_rook.possible_moves(test_board)).to include([6, 0])
      end

      it "does not include spaces beyond where the opponent's piece is located" do
        expect(black_rook.possible_moves(test_board)).not_to include([7, 0])
      end
    end

    context "when squares between rook and opponent's piece not empty" do
      before do
        test_board[0][0] = black_rook
        test_board[5][0] = black_king
        test_board[6][0] = white_king
      end

      it "does not include space where opponent's piece is located" do
        expect(black_rook.possible_moves(test_board)).not_to include([6, 0])
      end

      it "does not include space where own piece is located" do
        expect(black_rook.possible_moves(test_board)).not_to include([5, 0])
      end
    end
  end
end
      