class ScoreCalculator

  def calculate(scorecard)
    error_message = check_validity(scorecard)
    return error_message if error_message
    0
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
      (round[...2].sum == 10 && round.length == 3) \
    ||(round[...2].sum != 10 && round.length == 2)
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

end
