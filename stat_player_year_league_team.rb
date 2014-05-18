#
# Stores the raw data from the provided text files
# Keyed by player, year, team and league
#

require_relative 'record'
require_relative 'baseball_stats'

class StatPlayerYearLeagueTeam < Record
  include BaseballStats
  @records = Set.new
  @keys = [:player_id, :year, :team, :league]

  def initialize(*args)
    raise ArgumentError, 'Need a :player_id, :year, :team, :league to create a StatPlayerYearLeague object' unless args[0].has_keys?(self.class.keys)
    super
  end

end
