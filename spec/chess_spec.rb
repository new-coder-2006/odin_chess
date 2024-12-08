require_relative "../chess"
require_relative "../piece"
require_relative "../king"

describe Chess do
  subject(:test_game) { described_class.new }

  describe "#print_board" do
    it "prints initial setup" do
      expect { test_game.print_board }.to output(
        "|_|_|_|_|" + "K".colorize(:black) + "|_|_|_|\n" +
        "|_|_|_|_|_|_|_|_|\n" +
        "|_|_|_|_|_|_|_|_|\n" +
        "|_|_|_|_|_|_|_|_|\n" +
        "|_|_|_|_|_|_|_|_|\n" +
        "|_|_|_|_|_|_|_|_|\n" +
        "|_|_|_|_|_|_|_|_|\n" +
        "|_|_|_|_|" + "K".colorize(:white) + "|_|_|_|\n"
      ).to_stdout
    end

    it "correctly colorizes pieces" do
      expect { test_game.print_board }.to output(
        a_string_including(
          "K".colorize(:white),
          "K".colorize(:black)
        )
      ).to_stdout
    end
  end

  describe "#get_row" do
    before do
      allow(test_game).to receive(:gets).and_return("9\n", "4\n")
    end

    it "returns an error message when row is out of bounds" do
      expect(test_game).to receive(:puts).with("Please enter a valid row number.").once
      test_game.get_row
    end

    it "returns the correct row when a valid value is entered" do
      expect(test_game.get_row).to eq(3)
    end
  end

  describe "#get_col" do
    before do
      allow(test_game).to receive(:gets).and_return("9\n", "q\n", "a\n")
    end

    it "returns an error message when column is out of bounds" do
      expect(test_game).to receive(:puts).with("Please enter a valid column letter.").twice
      test_game.get_col
    end

    it "returns the correct column when a valid value is entered" do
      expect(test_game.get_col).to eq(0)
    end
  end

  describe "#get_piece_to_move" do
    context "when user first tries to move piece that is not their color then tries to move piece that is their color" do
      before do
        allow(test_game).to receive(:get_from_row).and_return(0, 7)
        allow(test_game).to receive(:get_from_col).and_return(3, 4)
        allow(test_game).to receive(:print_board).twice
      end

      it "prints one error message" do
        expect(test_game).to receive(:puts).with("This space does not contain one of your pieces. Please enter the " +
           "coordinates for a space containing one of your pieces.").once
        test_game.get_piece_to_move("white")
      end

      it "returns an array containing the piece to move along with its row and column numbers" do
        expect(test_game.get_piece_to_move("white")).to include(test_game.board[7][4], 7, 4)
      end
    end

    context "when user specifies an empty space" do
      before do
        allow(test_game).to receive(:get_from_row).and_return(0, 7)
        allow(test_game).to receive(:get_from_col).and_return(0, 4)
        allow(test_game).to receive(:print_board).twice
      end

      it "prints an error message" do
        expect(test_game).to receive(:puts).with("This space does not contain one of your pieces. Please enter the " +
           "coordinates for a space containing one of your pieces.").once
        test_game.get_piece_to_move("white")
      end
    end
  end

  describe "#move_piece" do
    context "when user tries to move to an invalid space" do
      before do
        allow(test_game).to receive(:get_to_row).and_return(6, 1)
        allow(test_game).to receive(:get_to_col).and_return(3, 3)
      end

      it "prints an error message" do
        expect(test_game).to receive(:puts).with("You can't move to that space. Please enter a valid space to move " +
           "this piece to.").once
        test_game.move_piece(test_game.board[0][4])
      end
    end
  end

  describe "#update_board" do
    it "correctly moves the specified piece to the specified space" do
      piece = test_game.board[0][3]
      test_game.update_board(0, 3, 1, 3)
      expect(test_game.board[1][3]).to eq(piece)
    end

    it "space where the moved piece was previously located reverts to nil" do
      piece = test_game.board[0][3]
      test_game.update_board(0, 3, 1, 3)
      expect(test_game.board[0][3].nil?).to be(true)
    end
  end
end