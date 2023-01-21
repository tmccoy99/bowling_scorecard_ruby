require_relative "../score_calculator"

describe ScoreCalculator do

  let(:score_calculator) { ScoreCalculator.new }

  before(:each) do
    @scorecard = [
      [1, 4],
      [4, 5],
      [6, 4],
      [5, 5],
      [10, 0],
      [0, 1],
      [7, 3],
      [6, 4],
      [10, 0],
      [2, 8, 6], 
    ]
  end


  it "returns an integer for valid scorecard" do
    expect(score_calculator.calculate(@scorecard)).to be_a Integer
  end

  it "returns string unless input has 10 rounds" do
    @scorecard << [1, 7]
    expect(score_calculator.calculate(@scorecard)).to eq "Sorry, your input has an invalid number of rounds"
    expect(score_calculator.calculate(@scorecard[0...9])).to eq "Sorry, your input has an invalid number of rounds"
  end

  context "When checking non-final rounds" do

    it "returns string unless each round has two entries" do
      @scorecard[4].pop
      expect(score_calculator.calculate(@scorecard)).to eq "Sorry, one of your non-final round scores is invalid"
      @scorecard[4] << 0 << 0
      expect(score_calculator.calculate(@scorecard)).to eq "Sorry, one of your non-final round scores is invalid"
    end

    it "returns string unless sum of round entries is <= 10" do
      @scorecard[0][0] = 7
      expect(score_calculator.calculate(@scorecard)).to eq "Sorry, one of your non-final round scores is invalid"
    end

    it "returns string unless all entries are non-negative integers" do
      @scorecard[6][1] = -1
      expect(score_calculator.calculate(@scorecard)).to eq "Sorry, one of your non-final round scores is invalid"
    end
  end
end