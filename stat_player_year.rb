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
    find(year: year).each do |player|
      p = find(player_id: player.player_id, year: year - 1)
      if p
        cur_val = player.send(attribute)
        prev_val = p[0].send(attribute)

        next if prev_val == 0
        # calculate the percentage change from the previous year
        d = (cur_val - prev_val) / prev_val

        if d > diff
          mi = [player]
          diff = d
        elsif d == diff
          mi << player
        end
      end
    end
    [mi, diff]
  end
end


# a = StatPlayerYear.new(player_id: 'chip', year: 2009,
#                                  games: 100, at_bats: 200, runs: 150, hits: 75, doubles: 10,
#                                  triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30)
#
# h = {player_id: 'chip', year: 2009, games: 100, at_bats: '200' }
#
# StatPlayerYear.load(h)
#
# puts a
# a

#
# puts a.slugging
# b = StatPlayerYear.new(player_id: 'player_1', year: 2009,
#                    games: 100, at_bats: 200, runs: 150, hits: 175, doubles: 10,
#                    triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30)

# what = StatPlayerYear.most_improved(2009, :batting_average_for_most_improved)
# what
# #

#
# nh = { player_id: 'chip', year: 2011, kwijibo: 'a string' }
# StatPlayerYear.load(nh)
# StatPlayerYear.load(nh)
# StatPlayerYear.load(nh)
# puts StatPlayerYear.find(player_id: 'chip', year: 2011)[0]
