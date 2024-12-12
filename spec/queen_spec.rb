require_relative "../piece"
require_relative "../king"
require_relative "../queen"

describe Queen do
  subject(:white_king) { King.new(0, 4, "white") }
  subject(:black_king) { King.new(7, 4, "black") }
  subject(:white_queen) { Queen.new(0, 3, "white") }
  subject(:black_queen) { Queen.new(7, 4, "black") }

  describe "#possible_moves" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    context "when no other pieces on the board" do
      before do
        test_board[0][3] = white_queen
      end

      it "includes all spaces in same row as piece except current space" do
        (0..7).each do |col|
          if col != 3
            expect(white_queen.possible_moves(test_board)).to include([0, col])
          end
        end
      end

      it "includes all spaces in same column as piece except current space" do
        (0..7).each do |row|
          if row != 0
            expect(white_queen.possible_moves(test_board)).to include([row, 3])
          end
        end
      end

      it "includes all spaces in the left-right diagonal" do
        (1..7).each do |i|
          break if white_queen.row - i < 0 || white_queen.col - i < 0
          expect(white_queen.possible_moves(test_board)).to include([white_queen.row - i, white_queen.col - i])
        end

        (1..7).each do |i|
          break if white_queen.row + i > 7 || white_queen.col + i > 7
          expect(white_queen.possible_moves(test_board)).to include([white_queen.row + i, white_queen.col + i])
        end
      end

      it "includes all spaces in the right-left diagonal" do
        (1..7).each do |i|
          break if white_queen.row - i < 0 || white_queen.col + i > 7
          expect(white_queen.possible_moves(test_board)).to include([white_queen.row - i, white_queen.col + i])
        end

        (1..7).each do |i|
          break if white_queen.row + i > 7 || white_queen.col - i < 0
          expect(white_queen.possible_moves(test_board)).to include([white_queen.row + i, white_queen.col - i])
        end
      end

      it "does not include space that piece currently occupies" do
        expect(white_queen.possible_moves(test_board)).not_to include([0, 3])
      end
    end

    context "when squares between queen and opponent's piece are empty" do
      before do
        test_board[0][3] = white_queen
        test_board[6][3] = black_king
      end

      it "includes space where the opponent's piece is located" do
        expect(white_queen.possible_moves(test_board)).to include([6, 3])
      end

      it "does not include spaces beyond where the opponent's piece is located" do
        expect(white_queen.possible_moves(test_board)).not_to include([7, 3])
      end
    end

    context "when squares between queen and opponent's piece not empty" do
      before do
        test_board[0][3] = white_queen
        test_board[5][3] = white_king
        test_board[6][3] = black_king
      end

      it "does not include space where opponent's piece is located" do
        expect(white_queen.possible_moves(test_board)).not_to include([6, 3])
      end

      it "does not include space where own piece is located" do
        expect(white_queen.possible_moves(test_board)).not_to include([5, 3])
      end
    end
  end
end
