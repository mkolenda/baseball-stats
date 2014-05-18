require_relative '../stat_player_year_league'

describe StatPlayerYearLeague do

  let(:tcw) { StatPlayerYearLeague.new(player_id: 'tcw', year: 2008, league: 'AL',
                                       games: 100, at_bats: 400, runs: 150, hits: 200, doubles: 10,
                                       triples: 5, home_runs: 100, rbis: 200, stolen_bases: 30) }


  let(:spoiler) { StatPlayerYearLeague.new(player_id: 't', year: 2008, league: 'AL',
                               games: 100, at_bats: 400, runs: 150, hits: 100, doubles: 10,
                               triples: 5, home_runs: 200, rbis: 200, stolen_bases: 30) }


  before do
    20.times do |i|
      StatPlayerYearLeague.new(player_id: "player#{i}", year: 2008, league: 'AL', team: 'NYY',
                               games: 100, at_bats: 400, runs: 150, hits: 100, doubles: 10,
                               triples: 5, home_runs: 20, rbis: 200, stolen_bases: 30)
    end

  end
  subject { stat }

  describe "class methods" do
    describe "::batting_triple_crown" do
      # more hits, home runs and higher BA than any previous record

      it "should identify a triple crown winner when there is one" do
        tcw
        winner = StatPlayerYearLeague.batting_triple_crown(2008, 'AL')
        winner[0].should eq tcw

      end

      it "should return an empty array when there is no triple crown winner" do
        spoiler
        winner = StatPlayerYearLeague.batting_triple_crown(2008, 'AL')
        winner.should be_empty
      end
    end
  end
end
