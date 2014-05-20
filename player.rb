#
# List of players, names, keyed by player_id
#
require_relative 'record'

class Player < Record
  @records = {}
  @keys = [:player_id]

  def full_name
    "#{first_name} #{last_name}"
  end

end

