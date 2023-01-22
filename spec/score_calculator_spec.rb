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

  def expect_final_round_invalid
    expect(score_calculator.calculate(@scorecard)).to eq "Sorry, your final round entry is invalid"
  end

  def expect_nonfinal_round_invalid
    expect(score_calculator.calculate(@scorecard)).to eq "Sorry, one of your non-final round entries is invalid"
  end

  it "returns an integer for valid scorecard" do
    expect(score_calculator.calculate(@scorecard)).to be_a Integer
  end

  it "returns string unless input has 10 rounds" do
    @scorecard << [1, 7]
    expect(score_calculator.calculate(@scorecard)).to eq "Sorry, your input has an invalid number of rounds"
    expect(score_calculator.calculate(@scorecard[...-2])).to eq "Sorry, your input has an invalid number of rounds"
  end

  context "When checking non-final rounds" do

    it "returns string unless each round has two entries" do
      @scorecard[4].pop
      expect_nonfinal_round_invalid
      @scorecard[4] << 0 << 0
      expect_nonfinal_round_invalid
    end

    it "returns string unless sum of round entries is <= 10" do
      @scorecard[0][0] = 7
      expect_nonfinal_round_invalid
    end

    it "returns string unless all round entries are non-negative integers" do
      @scorecard[6][1] = -1
      expect_nonfinal_round_invalid
      @scorecard[6][1] = "hello"
      expect_nonfinal_round_invalid

    end
  end

  context "When checking final round" do

    it "returns string unless final round has two or three entries" do
      @scorecard[-1] << 5
      expect_final_round_invalid
      @scorecard[-1].pop(3)
      expect_final_round_invalid
    end

    it "returns string unless all final round entries are integers between 0 and 10" do
      @scorecard[-1][2] = -5
      expect_final_round_invalid
      @scorecard[-1][2] = "hello"
      expect_final_round_invalid
      @scorecard[-1][2] = 11
      expect_final_round_invalid
    end

    it "returns string unless final round has three entries in the case of a strike or spare" do
      @scorecard[-1].pop
      expect_final_round_invalid
      @scorecard[-1] = [10, 0]
      expect_final_round_invalid
    end

    it "returns string unless final round has two entries in the case of neither strike nor spare" do
      @scorecard[-1] = [5, 4, 5]
      expect_final_round_invalid
    end
      
  end

  it "returns the correct score" do
    expect(score_calculator.calculate(@scorecard)).to eq 133
    @scorecard = Array.new(9) { [10, 0] } << [10, 10, 10]
    expect(score_calculator.calculate(@scorecard)).to eq 300
    @scorecard = Array.new(10) { [2, 7] }
    expect(score_calculator.calculate(@scorecard)).to eq 90
  end
end