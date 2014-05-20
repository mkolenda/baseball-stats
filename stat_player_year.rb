#
# Stores data summarized by player and year
# Will be used to compute most improved batting average 

require_relative 'record'
require_relative 'baseball_stats'

class StatPlayerYear < Record
  include BaseballStats
  @records = {}
  @keys = [:player_id, :year]
end
