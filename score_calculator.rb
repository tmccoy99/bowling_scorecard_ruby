class ScoreCalculator

  def calculate(scores)
    unless scores.length == 10
      return "Sorry, your input has an invalid number of rounds"
    end
    unless scores[0...9].all? { |round| valid_nonfinal_round(round) }
      return "Sorry, one of your non-final round scores is invalid"
    end
    0
  end

  private

  def valid_nonfinal_round(round)
    round.length == 2 \
    && round.sum <= 10 \
    && round.all? do |entry|
      entry.is_a?(Integer) && entry >= 0
    end
  end
end
