#
# To be useful include this module in a descendant of Record and load it with
# Baseball related k/v pairs with keys like hits, doubles, triples, home_runs, at_bats
#
module BaseballStats
  def slugging
    return 0 if at_bats == 0
    ((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f
  end

  def batting_average
    return 0 if at_bats == 0
    hits / at_bats.to_f
  end

  def batting_average_for_most_improved
    return 0 if at_bats < 200
    batting_average
  end

  def batting_average_for_triple_crown
    return 0 if at_bats < 400
    batting_average
  end

  def home_runs_for_triple_crown
    return 0 if at_bats < 400
    home_runs
  end

  def rbis_for_triple_crown
    return 0 if at_bats < 400
    rbis
  end
end
