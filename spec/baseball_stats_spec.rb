require_relative '../baseball_stats'
require_relative '../record'

describe BaseballStats do
  class BS < Record
    @records = {}
    @keys = [:player_id]
    include BaseballStats
  end

  let(:r) { BS.new( player_id: 'player', at_bats: 100, runs: 10, hits: 50, doubles: 10,
      triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  it "should calculate batting average correctly" do
    r.batting_average.should eq 0.5
  end

  it "should say batting average is 0 when there are 0 at bats" do
    r.at_bats = 0
    r.batting_average.should eq 0
  end

  it "should calculate slugging percentage correctly" do
    r.slugging.should eq 0.85
  end

  it "should say slugging percentage is 0 when there are 0 at bats" do
    r.at_bats = 0
    r.slugging.should eq 0
  end

  it "should calculate batting average for most improved correctly" do
    r.at_bats = 200
    r.batting_average_for_most_improved.should eq 0.25
  end

  it "should say batting average for most improved is 0 when there are fewer than 200 at bats" do
    r.at_bats = 199
    r.batting_average_for_most_improved.should eq 0
  end


  it "should calculate batting average for triple crown when there are more than 400 at bats" do
    r.at_bats = 400
    r.batting_average_for_triple_crown.should eq 0.125
  end

  it "should say batting average for triple crown is 0 when there are fewer than 400 at bats" do
    r.at_bats = 399
    r.batting_average_for_triple_crown.should eq 0
  end


  it "should calculate home runs for triple crown when there are more than 400 at bats" do
    r.at_bats = 400
    r.home_runs_for_triple_crown.should eq 5
  end

  it "should say batting average for triple crown is 0 when there are fewer than 400 at bats" do
    r.at_bats = 399
    r.home_runs_for_triple_crown.should eq 0
  end


  it "should calculate rbis for triple crown when there are more than 400 at bats" do
    r.at_bats = 400
    r.rbis_for_triple_crown.should eq 40
  end

  it "should say batting average for triple crown is 0 when there are fewer than 400 at bats" do
    r.at_bats = 399
    r.rbis_for_triple_crown.should eq 0
  end
end
