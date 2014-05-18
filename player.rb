#
#
#

require_relative 'my_hash'

class Player
  attr_accessor :player_id, :birth_year, :first_name, :last_name

  def initialize(*args)
    raise( ArgumentError, 'Creating a Player expects key value pairs' ) if args.empty?
    args.each do |arg|
      raise( ArgumentError, 'Creating a Player expects a hash as an argument' ) unless arg.is_a? Hash
      raise( ArgumentError, 'Need a :player_id to create a Player' ) unless arg.has_key?(:player_id)
      arg.each do |k, v|
        self.send("#{k.to_s}=".to_sym, v)
      end
    end
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end
end

