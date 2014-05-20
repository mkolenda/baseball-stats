#
# Stores the raw data from the provided text files
# Keyed by player, year, team and league
#

require_relative 'record'
require_relative 'baseball_stats'

class StatPlayerYearLeagueTeam < Record
  include BaseballStats
  @records = {}
  @keys = [:player_id, :year, :team, :league]
end
