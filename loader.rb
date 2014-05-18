#
# Loads data into the three classes
#   * Stat (slugging calculation) - From a file
#   * StatPlayerYear (Most Improved Batting Average) - From Stat data
#   * StatPlayerYearLeague (Triple Crown) - From Stat data
#

require_relative 'my_string'
require_relative 'stat'
require_relative 'stat_player_year'
require_relative 'stat_player_year_league'

module Loader
  # ::load_stat(file) - load the contents of <file> into Stat
  # ::load_stat_player_year - populate StatPlayerYear from the contents of Stat.records
  # ::load_stat_player_year_league - populate StatPlayerYearLeague from the contents on Stat.records

  class << self
    def load_stat(file)
      # not going to begin/rescue exception here.  I want processing to stop if can't open <file>
      File.open(file, 'r') do |f|
        f.each_with_index("\r")  do |line, i|
          next if i == 0
          h = {}
          #playerID	yearID	league	teamID	G	AB	R	H	2B	3B	HR	RBI	SB	CS
          h[:player_id], h[:year], h[:league], h[:team], h[:games],
              h[:at_bats], h[:runs], h[:hits], h[:doubles], h[:triples],
              h[:home_runs], h[:rbis], h[:stolen_bases] = line.chomp.split(/,/).map { |e| e.is_i? ? e.to_i : (e.is_f? ? e.to_f : e) }
          Stat.load(h)
        end
      end
    end

    def load_stat_player_year
      Stat.records.each do |r|
        StatPlayerYear.load(r)
      end
    end

    def load_stat_player_year_league
      Stat.records.each do |r|
        StatPlayerYearLeague.load(r)
      end
    end
  end
end

