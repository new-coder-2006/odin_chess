require_relative "../piece"
require_relative "../knight"
require_relative "../queen"
require_relative "../king"
require_relative "../bishop"


describe Knight do
  subject(:black_knight) { Knight.new(4, 4, "black") }
  subject(:white_queen) { Queen.new(6, 5, "white") }
  subject(:black_bishop) { Bishop.new(6, 3, "black") }
  subject(:white_king) { King.new(3, 4, "white") }
  subject(:black_king) { King.new(2, 4, "black")}
  subject(:black_knight2) { Knight.new(7, 1, "black") }
  subject(:black_knight3) { Knight.new(7, 6, "black") }

  describe "#possible_moves" do
    let(:test_board) { Array.new(8) { Array.new(8, nil) } }

    context "when no other pieces on the board" do
      before do
        test_board[4][4] = black_knight
        test_board[7][1] = black_knight2
        test_board[7][6] = black_knight3
      end

      it "includes all spaces in the surrounding L-shapes" do
        expect(black_knight.possible_moves(test_board)).to include(
          [6, 5], [6, 3], [2, 5], [2, 3], [5, 6], [5, 2], [3, 6], [3, 2]
        )
      end

      it "does not include space that the piece currently occupies" do
        expect(black_knight.possible_moves(test_board)).not_to include([4, 4])
      end

      it "does not include spaces outside of the surrounding L-shapes" do
        expect(black_knight.possible_moves(test_board)).not_to include([4, 5], [0, 0], [3, 3])
        expect(black_knight2.possible_moves(test_board)).not_to include([1, 4])
        expect(black_knight3.possible_moves(test_board)).not_to include([1, 4])
      end
    end

    context "when other pieces are on the board" do
      before do
        test_board[4][4] = black_knight
        test_board[6][5] = white_queen
        test_board[6][3] = black_bishop
        test_board[3][4] = white_king
        test_board[2][4] = black_king
      end

      it "includes otherwise valid spaces that contain opponent's pieces" do
        expect(black_knight.possible_moves(test_board)).to include([6, 5])
      end

      it "does not include otherwise valid spaces that contain player's pieces" do
        expect(black_knight.possible_moves(test_board)).not_to include([6, 3])
      end

      it "is able to jump pieces" do
        expect(black_knight.possible_moves(test_board)).to include([2, 3])
      end
    end
  end
end
