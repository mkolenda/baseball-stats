require_relative '../loader'

describe Loader do

  let(:file) { "./data/batting.csv" }

  describe Loader do
    it "should respond to class methods" do
      expect{ Loader.respond_to?(:load_stat)}.to be_true
      expect{ Loader.respond_to?(:load_stat_player_year)}.to be_true
      expect{ Loader.respond_to?(:load_stat_player_year_league)}.to be_true
    end

    describe "::load_stat" do
      it "should load the batting file into the Stat class" do
        Stat.all_players_stats.size.should eq 0
        Loader.load_stat(file)
        Stat.all_players_stats.size.should eq 24
      end
    end

    describe "::load_stat_player_year" do
      # abreubo01,2012,AL,LAA,8,24,1,5,3,0,0,5,0,0
      # abreubo01,2012,NL,LAN,92,195,28,48,8,1,3,19,6
      it "should load player year data from Stat" do
        StatPlayerYear.all_players_stats.size.should eq 0
        Loader.load_stat_player_year
        StatPlayerYear.find(player_id: 'abreubo01', year: 2012)[0].games.should eq 100
      end
    end

    describe "::load_stat_player_year_league" do
      it "should load player year league data from Stat" do
        StatPlayerYearLeague.all_players_stats.size.should eq 0
        Loader.load_stat_player_year_league
        StatPlayerYearLeague.find(player_id: 'abreubo01', year: 2012, league: 'AL')[0].games.should eq 8
        StatPlayerYearLeague.find(player_id: 'abreubo01', year: 2012, league: 'NL')[0].games.should eq 92
      end
    end

  end
end

