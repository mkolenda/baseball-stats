require_relative '../record'

describe Record do

  let(:stat) { Record.new(john: 'oldest', paul: 'lefty', george: 'weeps', ringo: 'wilbury') }
  let(:fp) { Record.new(player_id: 'fp', year: 2008, league: 'AL',
                          games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fpy) { Record.new(player_id: 'fpy', year: 2009, league: 'AL',
                           games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fp2) { Record.new(player_id: 'fp', year: 2009, league: 'AL',
                           games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fp3) { Record.new(player_id: 'fp3', year: 2008, league: 'NL',
                          games: 102, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fp4) { Record.new(player_id: 'fp4', year: 2008, league: 'AL',
                           games: 101, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fp5) { Record.new(player_id: 'fp5', year: 2008, league: 'XL',
                           games: 100, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fp6) { Record.new(player_id: 'fp6', year: 2008, league: 'XL',
                           games: 100, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  subject { stat }

  describe Record do
    it { should respond_to(:john=) }
    it { should respond_to(:paul=) }
    it { should respond_to(:george=) }
    it { should respond_to(:ringo=) }

    it { should respond_to(:john) }
    it { should respond_to(:paul) }
    it { should respond_to(:george) }
    it { should respond_to(:ringo) }

    it "should set the appropriate values on initialize" do
      expect(stat.john).to eq 'oldest'
      expect(stat.paul).to eq 'lefty'
      expect(stat.george).to eq 'weeps'
      expect(stat.ringo).to eq 'wilbury'
    end

    it "should tell if an attribute has not been set" do
      expect( stat.respond_to?(:kwijibo) ).to be_false
    end

    it "should respond to an unknown attribute with nil" do
      expect( stat.kwijibo ).to be_nil
    end

    specify "on initialize it should only accept a hash" do
      expect( lambda { Record.new('oops') } ).to raise_error
    end

    describe "class methods" do
      describe "::find" do
        it "should find a player by player_id" do
          fp
          Record.find(player_id: 'fp').should eq [fp]
        end

        it "should find a player by player_id and year" do
          fpy
          Record.find(player_id: 'fpy', year: 2009).should eq [fpy]
        end

        it "should find all player records when several exist for a player" do
          fp
          fp2
          f = Record.find(player_id: 'fp')
          f.include?(fp).should be_true
          f.include?(fp2).should be_true
        end
      end

      describe "::find_max" do
        it "should find the max when one filter criteria is set" do
          fp
          fp2
          fp3
          r = Record.find_max(:games, year: 2008)
          r.size.should eq 1
          r[0].should eq fp3
        end

        it "should find the max when more than one criteria is set" do
          fp3
          fp4
          r = Record.find_max(:games, year: 2008, league: 'AL')
          r.size.should eq 1
          r[0].should eq fp4
        end

        it "should find the max when there is a tie" do
          fp5
          fp6
          r = Record.find_max(:games, year: 2008, league: 'XL')
          r.size.should eq 2
          r.include?(fp5).should be_true
          r.include?(fp6).should be_true
        end
      end
    end
  end
end
