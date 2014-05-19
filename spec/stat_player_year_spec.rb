require_relative '../stat_player_year'

describe StatPlayerYear do

  # 199 at bats
  let(:spoiler1) { StatPlayerYear.new(player_id: 'spoiler', year: 2008,
                                      games: 100, at_bats: 199, runs: 150, hits: 75, doubles: 10,
                                      triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }
  # lots of hits
  let(:spoiler2) { StatPlayerYear.new(player_id: 'spoiler', year: 2009,
                                      games: 100, at_bats: 200, runs: 150, hits: 199, doubles: 10,
                                      triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:p1) { StatPlayerYear.new(player_id: 'hank', year: 2008,
                                games: 100, at_bats: 200, runs: 150, hits: 75, doubles: 10,
                                triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:p2) { StatPlayerYear.new(player_id: 'hank', year: 2009,
                                games: 100, at_bats: 200, runs: 150, hits: 176, doubles: 10,
                                triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:p3) { StatPlayerYear.new(player_id: 'joe', year: 2008,
                                games: 100, at_bats: 200, runs: 150, hits: 100, doubles: 10,
                                triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:p4) { StatPlayerYear.new(player_id: 'joe', year: 2009,
                                games: 100, at_bats: 200, runs: 150, hits: 75, doubles: 10,
                                triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:p5) { StatPlayerYear.new(player_id: 'chip', year: 2008,
                                games: 100, at_bats: 200, runs: 150, hits: 75, doubles: 10,
                                triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }

  let(:p6) { StatPlayerYear.new(player_id: 'chip', year: 2009,
                                games: 100, at_bats: 200, runs: 150, hits: 176, doubles: 10,
                                triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }


  describe "new objects must have a player_id and a year" do
    it "raises an error" do
      expect { StatPlayerYear.new(player_id: 'hank',
                         games: 100, at_bats: 200, runs: 150, hits: 75, doubles: 10,
                         triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30) }.to raise_error
    end
  end

  describe "class methods" do
    describe "::most_improved (batting average)" do
      it "should identify the player with the most improved batting average for a given year" do
        spoiler1
        spoiler2
        p1
        p2
        p3
        p4
        r = StatPlayerYear.most_improved(2009, :batting_average_for_most_improved)
        r[0].size.should eq 1
        r[0][0].should eq p2
        r[1].round(3).should eq 1.347
      end

      it "should report a tie" do
        p5
        p6
        r = StatPlayerYear.most_improved(2009, :batting_average_for_most_improved)
        r[0].size.should eq 2
        r[0].include?(p2).should be_true
        r[0].include?(p6).should be_true
        r[1].round(3).should eq 1.347
      end
    end

    describe "::load" do
      # Testing load in StatPlayerYear because it has keys and Record does not
      it "appends the data in a new record if it's keys are present" do
        nh = { player_id: 'chip', year: 2009, games: 100, at_bats: 200 }
        StatPlayerYear.load(nh)
        p6 = StatPlayerYear.find(player_id: 'chip', year: 2009)
        p6[0].games.should eq 200
        p6[0].at_bats.should eq 400
      end

      it "adds a new record when keys are not present" do
        nh = { player_id: 'chip', year: 2010, kwijibo: 200 }
        StatPlayerYear.load(nh)
        kw = StatPlayerYear.find(player_id: 'chip', year: 2010)
        kw[0].kwijibo.should eq 200
      end

      it "ignores records that do not have the proper keys present" do
        nh = { player_id: 'chip', kwijibo: 200 }
        before = StatPlayerYear.records.size
        StatPlayerYear.load(nh)
        after = StatPlayerYear.records.size
        before.should eq after
      end

      it "should not add keys to each other" do
        nh = { player_id: 'chip', year: 2010, kwijibo: 200 }
        StatPlayerYear.load(nh)
        StatPlayerYear.load(nh)
        StatPlayerYear.find(player_id: 'chip', year: 4020).should be_nil
      end

      it "should append string values separated by -" do
        nh = { player_id: 'chip', year: 2011, urakwijibo: 'a string' }
        StatPlayerYear.load(nh)
        StatPlayerYear.load(nh)
        StatPlayerYear.find(player_id: 'chip', year: 2011)[0].urakwijibo.should eq 'a string - a string'
      end

      it "should treat a nil value as 0" do
        nh = { player_id: 'chip', year: 2010, kwijibo: nil }
        StatPlayerYear.load(nh)
        StatPlayerYear.find(player_id: 'chip', year: 2010)[0].kwijibo.should eq 600
      end
    end
  end
end
