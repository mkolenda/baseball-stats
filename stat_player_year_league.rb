#
# Stores data summarized by player, year and league
#

require_relative 'record'
require_relative 'baseball_stats'

class StatPlayerYearLeague < Record
  include BaseballStats
  @records = {}
  @keys = [:player_id, :year, :league]

  ##
  # Triple crown winner – The player that had the highest batting average
  # AND the most home runs AND the most RBI in their league.
  # It's unusual for someone to win this, but there was a winner in 2012.
  # “Officially” the batting title (highest league batting average) is based
  # on a minimum of 502 plate appearances. The provided dataset does not include plate appearances.
  # It also does not include walks so plate appearances cannot be calculated.
  # Instead, use a constraint of a minimum of 400 at-bats to determine those eligible for the league batting title.
  ##
  def self.batting_triple_crown(year, league)
    ba = find_max(:batting_average_for_triple_crown, year: year, league: league)
    hr = find_max(:home_runs_for_triple_crown, year: year, league: league)
    rbi = find_max(:rbis_for_triple_crown, year: year, league: league)
    ba.delete_if { |bae| hr.include?(bae) == false }.delete_if { |bae| rbi.include?(bae) == false }
  end
end
