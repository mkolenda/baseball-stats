require_relative '../record'

describe Record do

  let(:fp) { Record.new(player_id: 'fp', year: 2008, league: 'AL',
                          games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 10) }

  let(:fpy) { Record.new(player_id: 'fpy', year: 2009, league: 'AL',
                           games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 15) }

  let(:fp_again) { Record.new(player_id: 'fp', year: 2009, league: 'AL',
                           games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 20) }

  let(:fp3) { Record.new(player_id: 'fp3', year: 2008, league: 'NL',
                          games: 102, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 25) }

  let(:fp4) { Record.new(player_id: 'fp4', year: 2008, league: 'AL',
                           games: 101, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:fp5) { Record.new(player_id: 'fp5', year: 2008, league: 'XL',
                           games: 100, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 35) }

  let(:fp6) { Record.new(player_id: 'fp6', year: 2008, league: 'XL',
                           games: 100, at_bats: 1, runs: 151, hits: 76, doubles: 10,
                           triples: 5, home_runs: 5, rbis: 40, stolen_bases: 40) }

  let(:im_nil) {Record.new(player_id: 'im_nil', year: 2008, league: 'XL',
                           games: nil, at_bats: nil, runs: nil, hits: nil, doubles: nil,
                           triples: nil, home_runs: nil, rbis: nil, stolen_bases: nil)}

  subject { fp }

  describe Record do
    it { should respond_to(:player_id=) }
    it { should respond_to(:year=) }
    it { should respond_to(:league=) }
    it { should respond_to(:games=) }

    it { should respond_to(:player_id) }
    it { should respond_to(:year) }
    it { should respond_to(:league) }
    it { should respond_to(:games) }

    it "should treat nil values as 0" do
      im_nil
      expect(im_nil.games).to eq 0
      expect(im_nil.at_bats).to eq 0
      expect(im_nil.hits).to eq 0
      expect(im_nil.doubles).to eq 0
    end

    it "should set the appropriate values on initialize" do
      expect(fp.player_id).to eq 'fp'
      expect(fp.year).to eq 2008
      expect(fp.league).to eq 'AL'
      expect(fp.games).to eq 100
    end

    it "should tell if an attribute has not been set" do
      expect( fp.respond_to?(:kwijibo) ).to be_false
    end

    it "should respond to an unknown attribute with 0" do
      expect( fp.kwijibo ).to eq 0
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
          fp_again
          f = Record.find(player_id: 'fp')
          f.include?(fp).should be_true
          f.include?(fp_again).should be_true
          f.size.should eq 2
        end

        it "should find all player records when a boolean > is provided" do
          fp
          fp_again
          fp3
          fp4
          fp5
          fp6
          f = Record.find("stolen_bases>" => 27)
          f.include?(fp5).should be_true
          f.include?(fp6).should be_true
          f.size.should eq 3
        end

        it "should behave well when passing an invalid argument to find" do
          lambda {  Record.find("stolen_bases<=" => 27)}.should raise_error
        end

        it "should not find a record when looking for an unknown key" do
          f = Record.find(notavalidkey: 100)
          f.should be_nil
        end

      end

      describe "::find_max" do
        it "should find the max when one filter criteria is set" do
          fp
          fp_again
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
