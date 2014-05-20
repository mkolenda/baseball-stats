#
# Loads data into the three classes
#   * StatPlayerYearLeagueTeam (slugging calculation) - From a file
#   * StatPlayerYear (Most Improved Batting Average) - Summarized from Stat data
#   * StatPlayerYearLeague (Triple Crown) - Summarized from Stat data
#   * Player - Player data - From a file
#

require_relative 'player'
require_relative 'my_string'
require_relative 'stat_player_year'
require_relative 'stat_player_year_league'
require_relative 'stat_player_year_league_team'

module Loader
  # ::load_stat(file) - load the contents of <file> into Stat
  # ::load_stat_player_year - populate StatPlayerYear from the contents of Stat.records
  # ::load_stat_player_year_league - populate StatPlayerYearLeague from the contents on Stat.records
  # ::load_player - populate Player from <file> to Player

  class << self
    def load_stat_player_year_league_team(file)
      File.open(file, 'r') do |f|
        f.each_with_index("\r")  do |line, i|
          next if i == 0
          h = {}
          #playerID	yearID	league	teamID	G	AB	R	H	2B	3B	HR	RBI	SB	CS
          h[:player_id], h[:year], h[:league], h[:team], h[:games],
              h[:at_bats], h[:runs], h[:hits], h[:doubles], h[:triples],
              h[:home_runs], h[:rbis], h[:stolen_bases] = line.chomp.split(/,/).map { |e| e.is_i? ? e.to_i : (e.is_f? ? e.to_f : e) }
          StatPlayerYearLeagueTeam.load(h, true)
        end
      end
    end

    def load_stat_player_year
      StatPlayerYearLeagueTeam.records.each_value do |r|
        StatPlayerYear.load(r)
      end
    end

    def load_stat_player_year_league
      StatPlayerYearLeagueTeam.records.each_value do |r|
        StatPlayerYearLeague.load(r)
      end
    end

    def load_player(file)
      File.open(file, 'r') do |f|
        f.each_with_index("\r")  do |line, i|
          next if i == 0
          h = {}
          #playerID,birthYear,nameFirst,nameLast
          h[:player_id], h[:birth_year], h[:first_name], h[:last_name] =
              line.chomp.split(/,/).map { |e| e.is_i? ? e.to_i : (e.is_f? ? e.to_f : e) }
          Player.load(h, true)
        end
      end
    end
  end
end

