require_relative '../loader'

describe Loader do

  let(:batting_file) { "./data/batting_small.csv" }
  let(:player_file) { "./data/player_small.csv" }

  describe Loader do
    it "should respond to class methods" do
      expect{ Loader.respond_to?(:load_stat_player_year_league_team)}.to be_true
      expect{ Loader.respond_to?(:load_stat_player_year)}.to be_true
      expect{ Loader.respond_to?(:load_stat_player_year_league)}.to be_true
      expect{ Loader.respond_to?(:load_player)}.to be_true
    end

    describe "::load_stat_player_year_league_team" do
      it "should load the batting file into the StatPlayerYearLeagueTeam class" do
        StatPlayerYearLeagueTeam.records.size.should eq 0
        Loader.load_stat_player_year_league_team(batting_file)
        StatPlayerYearLeagueTeam.records.size.should eq 35
      end
    end

    describe "::load_stat_player_year" do
      # abreubo01,2012,AL,LAA,8,24,1,5,3,0,0,5,0,0
      # abreubo01,2012,NL,LAN,92,195,28,48,8,1,3,19,6
      it "should load player year data from Stat" do
        StatPlayerYear.records.size.should eq 0
        Loader.load_stat_player_year
        StatPlayerYear.find(player_id: 'abreubo01', year: 2012)[0].games.should eq 100
      end
    end

    describe "::load_stat_player_year_league" do
      it "should load player year league data from Stat" do
        StatPlayerYearLeague.records.size.should eq 0
        Loader.load_stat_player_year_league
        StatPlayerYearLeague.find(player_id: 'abreubo01', year: 2012, league: 'AL')[0].games.should eq 8
        StatPlayerYearLeague.find(player_id: 'abreubo01', year: 2012, league: 'NL')[0].games.should eq 92
      end
    end

    describe "::load_player" do
      it "should load the player file into the Player class" do
        Player.records.size.should eq 0
        Loader.load_player(player_file)
        Player.records.size.should eq 307
      end
    end
  end
end

