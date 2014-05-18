require_relative '../baseball_stats'
require_relative '../stat_hash'

describe BaseballStats do
  class BS < StatHash
    @all_players_stats = Set.new
    include BaseballStats
  end

  let(:ba) { BS.new( at_bats: 100, runs: 10, hits: 50, doubles: 10,
      triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }


  let(:sp) { BS.new( at_bats: 200, runs: 10, hits: 75, doubles: 10,
                    triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:bamp) { BS.new( at_bats: 200, runs: 10, hits: 50, doubles: 10,
           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }


  it "should calculate batting average correctly" do
    ba.batting_average.should eq 0.5
  end

  it "should say batting average is 0 when there are 0 at bats" do
    ba.at_bats = 0
    ba.batting_average.should eq 0
  end

  it "should calculate slugging percentage correctly" do
    sp.slugging.should eq 0.55
  end

  it "should say slugging percentage is 0 when there are 0 at bats" do
    sp.at_bats = 0
    sp.slugging.should eq 0
  end

  it "should calculate batting average for most improved correctly" do
    bamp.batting_average_for_most_improved.should eq 0.25
  end

  it "should say batting average for most improved is 0 when there are fewer than 200 at bats" do
    bamp.at_bats = 199
    bamp.batting_average_for_most_improved.should eq 0
  end
end
