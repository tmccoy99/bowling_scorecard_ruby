describe ScoreCalculator do

  let(:score_calculator) { ScoreCalculator.new }

  before(:each) do
    @test_scores = [
      [1, 4],
      [4, 5],
      [8, 1]
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

  context "#calculate accepts only valid bowling inputs" do
    it "returns string unless input has 10 rounds" do
      @test_scores << [1, 7]
      expect(score_calculator.calculate(@test_scores)).to eq "Sorry, your input has an invalid number of rounds"
      expect(score_calculator.calculate(@test_scores[0...9])).to eq "Sorry, your input has an invalid number of rounds"
    end
  end
end