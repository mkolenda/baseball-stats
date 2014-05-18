require_relative '../performances'

describe Performances do

  let(:performances) { Performances.new }

  subject { performances }

  before do
    # performances <<
  end

  describe "all performances" do
    it { should be_a Set }
    it { should respond_to(:stats_for_player_year).with(2).arguments }
  end

  describe "stats_for_player_year" do
    it "should return a hash" do
      # expect(performances.stats_for_player_year('player_1', 2008, :rbis)).to be_a Hash
    end
  end

end
