#
# List of players, names, keyed by player_id
#
require_relative 'record'

class Player < Record
  @records = Set.new
  @keys = [:player_id]

  def initialize(*args)
    raise ArgumentError, 'Need a :player_id' unless args[0].has_keys?(self.class.keys)
    super
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end

