class Array
  
  def strike
    self[0] == 10
  end

  def spare
    self[0] != 10 && self[...2].sum == 10
  end

end

class ScoreCalculator

  def calculate(scorecard)
    error_message = check_validity(scorecard)
    return error_message if error_message
    score = scorecard[...-1].each.with_index.inject(0) do |sum, (round, index)|
      sum + nonfinal_round_score(scorecard, index)
    end
    score + scorecard[-1].sum
  end

  private

  def valid_nonfinal_round(round)
    round.length == 2 \
    && round.all? { |entry| valid_entry(entry) } \
    && round.sum <= 10 
  end

  def valid_final_round(round)
    round.all? { |entry| valid_entry(entry) } \
    && (
      (round[...2].sum >= 10 && round.length == 3) \
    ||(round[...2].sum < 10 && round.length == 2)
    )

  end

  def valid_entry(entry)
    (0..10).include?(entry)
  end

  def check_validity(scorecard)
    unless scorecard.length == 10
      return "Sorry, your input has an invalid number of rounds"
    end
    unless scorecard[...-1].all? { |round| valid_nonfinal_round(round) }
      return "Sorry, one of your non-final round entries is invalid"
    end
    unless valid_final_round(scorecard[-1])
      return "Sorry, your final round entry is invalid"
    end
  end

  def nonfinal_round_score(scorecard, round_index)
    current_round, next_round = scorecard[round_index..(round_index + 1)]
    score = current_round.sum
    return score unless current_round.strike || current_round.spare
    score += next_round[0]
    return score unless current_round.strike
    score += next_round.strike && round_index + 1 != 9 ? \
      scorecard[round_index + 2][0] : next_round[1]
    score
  end
end