#
# Stores data summarized by player and year
#

require_relative 'record'
require_relative 'baseball_stats'

class StatPlayerYear < Record
  include BaseballStats
  @records = Set.new
  @keys = [:player_id, :year]

  def initialize(*args)
    raise ArgumentError, 'Need a :player_id and :year to create a StatPlayerYear object' unless args[0].has_keys?(self.class.keys)
    super
  end

  def self.most_improved(year, attribute)
    diff = prev_val = cur_val = 0
    mi = []
    found = find(year: year)
    if found
      found.each do |record|
        p = find(player_id: record.player_id, year: year - 1)
        if p
          cur_val = record.send(attribute)
          prev_val = p[0].send(attribute)

          next if prev_val == 0
          # calculate the percentage change from the previous year
          d = (cur_val - prev_val) / prev_val

          if d > diff
            mi = [record]
            diff = d
          elsif d == diff
            mi << record
          end
        end
      end
    end
    [mi, diff]
  end
end
