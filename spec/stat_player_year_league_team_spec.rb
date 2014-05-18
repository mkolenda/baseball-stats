require_relative '../stat_player_year_league_team'

describe StatPlayerYearLeagueTeam do



  describe "new me" do
    it "should create a new object when the proper keys are provided" do
      expect( StatPlayerYearLeagueTeam.new(player_id: 'tcw', year: 2008, league: 'AL', team: 'NYY',
                                 games: 100, at_bats: 400, runs: 150, hits: 200, doubles: 10,
                                 triples: 5, home_runs: 100, rbis: 200, stolen_bases: 30)).to_not raise_error
    end

    it "should raise an error when the proper keys are not provided" do
      expect( lambda { StatPlayerYearLeagueTeam.new(player_id: 'tcw', year: 2008, league: 'AL',
                                           games: 100, at_bats: 400, runs: 150, hits: 200, doubles: 10,
                                           triples: 5, home_runs: 100, rbis: 200, stolen_bases: 30)}).to raise_error
    end
  end
end
