#!/usr/bin/env ruby

require 'getoptlong'
require_relative 'loader'

opts = GetoptLong.new(
    [ '--help', '-h',     GetoptLong::NO_ARGUMENT ],
    [ '--player', '-p',   GetoptLong::REQUIRED_ARGUMENT ],
    [ '--stats', '-s',    GetoptLong::REQUIRED_ARGUMENT ],
    [ '--improved', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--slugging', '-l', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--triplecrown', '-t', GetoptLong::OPTIONAL_ARGUMENT ]
)

opts.each do |opt, arg|
  case opt
    when '--help'
      puts <<-EOF
ruby performance.rb [OPTIONS]

-h, --help:
   show help

--player <file>, -p <file>:
   specify the relative or absolute path to the player file

--stats <file>, -s <file>:
   specify the relative or absolute path to the baseball statistics file

--improved <year>, -i <year>:
   specify which year to find the hitter with the most improved batting average

--slugging <team>, -l <team-year>:
   specify which team and year to calculate slugging percentage
   For example:

    -l OAK-2008

--triplecrown <year-league:year-league>, -t <year-league:year-league>
   specify which year and league to determine the league triple crown winner
   separate combinations of years/leagues with a : (colon)
    For example:

   -t 2008-AL:2009-NL:2010-AL:2011-NL

   Would find the triple crown winner for the american league in 2008 and 2010 and the National League in 2009 and 2011

---

To answer the questions, run this:
     performance.rb -p <path to player file>
                    -s <path to statistics file>
                    -i 2010
                    -l 2007-OAK
                    -t 2011-AL:2011-NL:2012-AL:2012-NL


      EOF
    when '--player'
      Loader.load_player(arg)

    when '--stats'
      Loader.load_stat_player_year_league_team(arg)

    when '--improved'
      Loader.load_stat_player_year unless StatPlayerYear.records.size > 0
      a = StatPlayerYear.most_improved(arg.to_i, :batting_average_for_most_improved)
      if a[0][0]
        puts
        a[0].each do |p|
          puts "The player with the most improved batting average for year #{arg} is #{Player.find(player_id: p.player_id)[0].full_name} on team #{p.team} with an improvement of #{(a[1] * 100).round(2)}%"
        end
      else
        # no winner
        puts "No winner for most improved batting average for year #{arg}"
      end

    when '--slugging'
      a = arg.split(/-/)
      res = StatPlayerYearLeagueTeam.find(year: a[0].to_i, team: a[1])
      if res
        puts
        res.each do |r|
          puts "Player #{Player.find(player_id: r.player_id)[0].full_name} for team #{r.team} and year #{r.year} has slugging percent #{(r.slugging).round(3)}"
        end
      end

    when '--triplecrown'
      Loader.load_stat_player_year_league unless StatPlayerYearLeague.records.size > 0
      arg.split(/:/).each do |pair|
        a = pair.split(/-/)
        r = StatPlayerYearLeague.batting_triple_crown(a[0].to_i, a[1])
        puts
        unless r.empty?
          r.each do |e|
            puts "Triple crown winner for year #{a[0]} and league #{a[1]} is #{Player.find(player_id: e.player_id)[0].full_name} with #{e.home_runs} home runs, #{e.rbis} RBI's and #{e.batting_average.round(3)} batting average"
          end
        else
          puts "No triple crown winner for year #{a[0]} and league #{a[1]}"
        end
      end
  end
end
