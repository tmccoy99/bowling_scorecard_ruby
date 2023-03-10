class Array
  
  def strike
    self[0] == 10
  end

  def spare
    !self.strike && self[...2].sum == 10
  end

end

class ScoreCalculator

  def calculate(scorecard)
    error_message = check_validity(scorecard)
    return error_message if error_message
    score = 0.upto(8).inject(0) { |sum, idx| sum + nonfinal_round_score(scorecard, idx) }
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
    current_round = scorecard[round_index]
    score = current_round.sum
    score += spare_bonus(scorecard, round_index) if current_round.spare
    score += strike_bonus(scorecard, round_index) if current_round.strike
    score
  end

  def spare_bonus(scorecard, round_index)
    next_round = scorecard[round_index + 1]
    next_round[0]
  end

  def strike_bonus(scorecard, round_index)
    next_round = scorecard[round_index + 1]
    second_ball_bonus = next_round.strike && round_index != 8 ? \
      scorecard[round_index + 2][0] : next_round[1]
    spare_bonus(scorecard, round_index) + second_ball_bonus
  end

end