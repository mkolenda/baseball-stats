require_relative 'record'
require_relative 'baseball_stats'

class StatPlayerYearLeague < Record
  include BaseballStats
  @records = Set.new
  @keys = [:player_id, :year, :league]

  def initialize(*args)
    raise ArgumentError, 'Need a :player_id, :year and :league to create a StatPlayerTeamLeague object' unless args[0].has_keys?(self.class.keys)
    super
  end

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
    ba = find_max(:batting_average, year: year, league: league, "at_bats>" => 400)
    hr = find_max(:home_runs, year: year, league: league, "at_bats>" => 400)
    rbi = find_max(:rbis, year: year, league: league, "at_bats>" => 400)
    ba.delete_if { |bae| hr.include?(bae) == false }.delete_if { |bae| rbi.include?(bae) == false }
  end
end
