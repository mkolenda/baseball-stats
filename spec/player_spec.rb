require_relative '../player'

describe Player do

  let(:player) { Player.new(player_id: 'player_1', first_name: 'Pete', last_name: 'Rose', birth_year: 1941) }

  subject { player }

  describe "a player" do
    it { should respond_to(:player_id) }
    it { should respond_to(:full_name) }
    it { should respond_to(:birth_year) }
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
  end

  it "should reply with the correct full name" do
    player.full_name.should eq 'Pete Rose'
  end

  it "should not allow a player to be created without a player_id" do
    expect( lambda { Player.new(first_name: 'Pete') }).to raise_error
  end

  it "should not allow a player to be created without any arguments" do
    expect( lambda { Player.new }).to raise_error
  end

end
