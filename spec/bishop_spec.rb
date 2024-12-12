require_relative "../piece"
require_relative "../bishop"
require_relative "../queen"
require_relative "../king"

describe Bishop do
  subject(:black_bishop) { Bishop.new(0, 2, "black") }
  subject(:white_queen) { Queen.new(4, 6, "white") }
  subject(:black_king) { King.new(5, 7, "black") }

  describe "#possible_moves" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    context "when no other pieces on the board" do
      before do
        test_board[0][2] = black_bishop
      end

      it "includes all spaces in the left-right diagonal" do
        (1..7).each do |i|
          break if black_bishop.row + i > 7 || black_bishop.col + i > 7
          expect(black_bishop.possible_moves(test_board)).to include([black_bishop.row + i, black_bishop.col + i])
        end
      end

      it "includes all spaces in the right-left diagonal" do
        (1..7).each do |i|
          break if black_bishop.row + i > 7 || black_bishop.col - i < 0
          expect(black_bishop.possible_moves(test_board)).to include([black_bishop.row + i, black_bishop.col - i])
        end
      end

      it "does not include space that piece currently occupies" do
        expect(black_bishop.possible_moves(test_board)).not_to include([0, 2])
      end

      it "does not include spaces outside of diagonals the piece is on" do
        expect(black_bishop.possible_moves(test_board)).not_to include([0, 3], [1, 4])
      end
    end

    context "when opponent's piece is on same diagonal as bishop and squares in between are empty" do
      before do
        test_board[0][2] = black_bishop
        test_board[4][6] = white_queen
      end

      it "includes space where the opponent's piece is located" do
        expect(black_bishop.possible_moves(test_board)).to include([4, 6])
      end

      it "does not include spaces beyond where the opponent's piece is located" do
        expect(black_bishop.possible_moves(test_board)).not_to include([5, 7])
      end
    end

    context "when squares between queen and opponent's piece not empty" do
      before do
        test_board[0][2] = black_bishop
        test_board[4][6] = black_king
        test_board[5][7] = white_queen
      end

      it "does not include space where opponent's piece is located" do
        expect(black_bishop.possible_moves(test_board)).not_to include([4, 6])
      end

      it "does not include space where own piece is located" do
        expect(black_bishop.possible_moves(test_board)).not_to include([5, 7])
      end
    end
  end
end
