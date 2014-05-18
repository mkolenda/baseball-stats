#
# A generic way of storing data, retrieving, normalizing and summarizing data
# Subclass this class when the data needs to be keyed appropriately for a given
# purpose.  See Stat, StatPlayerYearLeague and StatPlayerYear for examples and uses
#

require 'set'
require_relative 'my_hash'

class Record < Hash
  @records = Set.new
  @keys = []

  def initialize(*args)
    raise ArgumentError if args.empty?
    args.each do |arg|
      raise ArgumentError, 'Creating a StatHash expects a hash as an argument' unless arg.is_a? Hash
      arg.each do |k, v|
        self.send("#{k.to_s}=".to_sym, v)
      end
    end
    self.class.records << self
  end

  def method_missing(m, *args)
    if m =~ /^\w+=$/
      self.store(m.to_s.chop.to_sym, args[0])
    elsif self[m]
      self[m]
    else
      nil
    end
  end

  def respond_to?(m, include_private = false)
    if m.to_s =~ /^\w+=$/
      true
    elsif m.to_s =~ /^\w+[^=]$/
      if self.has_key?(m)
        true
      else
        false
      end
    else
      super
    end
  end

  class << self
    attr_reader :records, :keys

    # find will find records using ==
    # pass whatever key/values you want to search by
    # find(player_id: 'matt', year: 2000) => return records with player_id = matt AND year = 2000
    # find(player_id: 'matt', year: 2000, "at_bats>" => 400) =>
    #     return records with player_id = matt AND year = 2000 AND at_bats > 400
    def find(*args)
      r = []
      records.each do |record|
        match = true
        args[0].each do |k, v|
          if k.is_a?(Symbol)
            match = false unless record.send(k) && record.send(k) == v
          elsif k.is_a?(String)
            # parse out the operator from the string and compare appropriately
            # accepts < and >.  Throws an error if a bad operator is passed
            case k[-1..-1]
              when "<"
                match = false unless record.send(k.chop.to_sym) && record.send(k.chop.to_sym) < v
              when ">"
                match = false unless record.send(k.chop.to_sym) && record.send(k.chop.to_sym) > v
              else
                raise RuntimeError, "Bad argument passed to find: #{k}"
            end
          else
            # bad key passed to me, don't add the record to the match list
            match = false
          end

          break unless match
        end
        r << record if match
      end
      return r unless r.empty?
      nil
    end

    def find_max(attribute, *filters)
      winner = []
      max = 0
      found = find(filters[0])
      if found
        found.each do |r|
          if r.send(attribute) > max
            winner = [r]
            max = r.send(attribute)
          elsif r.send(attribute) == max
            winner << r
          end
        end
      end
      winner
    end

    def load(record)
      # Load a Hash into me
      return unless record.is_a?(Hash) && record.has_keys?(keys)
      # Do I already have a record with these keys?
      s = {}
      keys.each { |k| s[k] = record[k] }
      r = find(s)
      if r
        # Update the existing record with new data
        # making an assumption that there is one record found.
        # probably should be an error if more than one is returned.  Another day.
        r = r[0]

        # Remove the k/v pairs that are keys so they aren't changed
        cr = record.reject {|k,v| keys.include?(k) }

        # I already have a record with these keys
        # add the stats in record to the one I already have
        cr.each_pair do |k, v|
          v = 0 if v.nil?
          if r[k]
            # this key already exists in my record so add the new value to me
            if r[k].is_a?(Numeric) && v.is_a?(Numeric)
              r.send("#{k.to_s}=".to_sym, r[k] + v)
            else
              # force both to strings and append - good for tracking player team/league movement
              r.send("#{k.to_s}=".to_sym, "#{r[k].to_s} - #{v.to_s}")
            end
          else
            # Insert, this is a new key so create it
            r.send("#{k.to_s}=".to_sym, v)
          end
        end
      else
        # this is a new record so create it
        new(record)
      end
    end
  end
end

#  Record.new(player_id: 'fp', year: 2008,
#                         games: 100, at_bats: 100, runs: 150, hits: 75, doubles: 10,
#                         triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30)
#
# r = Record.find("stolen_bases>" => 29)
#
# puts r[0]

#

# fpy = StatHash.new(player_id: 'fpy', year: 2009,
#                          games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
#                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30)
#
# fp2 = StatHash.new(player_id: 'fp2', year: 2009,
#                          games: 100, at_bats: 0, runs: 150, hits: 75, doubles: 10,
#                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30)
#
# fp3= StatHash.new(player_id: 'fp3', year: 2008,
#                          games: 101, at_bats: 1, runs: 151, hits: 76, doubles: 10,
#                          triples: 5, home_runs: 5, rbis: 40, stolen_bases: 30)
#
# r = StatHash.find_max(:games, year: 2008)
#
# r
