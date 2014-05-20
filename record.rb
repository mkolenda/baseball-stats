#
# A generic way of storing, retrieving, normalizing and summarizing data
# Subclass this class when the data needs to be keyed appropriately for a given
# purpose.  See StatPlayerYearLeagueTeam, StatPlayerYearLeague and StatPlayerYear
# for examples and uses
#

require 'set'
require_relative 'my_hash'

class Record < Hash
  @records = {} # Add this (an empty hash) to each subclass
  @keys = []    # Add a list of keys (Symbols) to each subclass

  # Accepts a hash of initial values, adds them to itself and keeps track of them in the "records" class instance variable
  def initialize(*args)
    # Don't allow an object to be created unless key values are provided and a list of keys has been defined at the class level
    raise ArgumentError unless args[0].has_keys?(self.class.keys) and !(self.class.keys.empty?)
    args.each do |arg|
      raise ArgumentError, 'Creating a Record expects a hash as an argument' unless arg.is_a?(Hash)
      arg.each do |k, v|
        self.send("#{k.to_s}=".to_sym, v)
      end
    end
    # create the primary key for this record then
    # store the pk and the record in the records class instance variable
    # Use a non-printable character as the delimiter \x01 to avoid code/data conflicts
    self.class.records[self.class.build_key(self)] = self
  end

  # Adds ActiveRecord like behavior... obj.attribute and obj.attribute=
  def method_missing(m, *args)
    if m =~ /^\w+=$/
      self.store(m.to_s.chop.to_sym, args[0])
    elsif self[m]
      self[m]
    else
      0
    end
  end

  def respond_to?(m, include_private = false)
    if m.to_s =~ /^\w+=$/
      # always responds to a setter (attribute=) method
      true
    elsif m.to_s =~ /^\w+[^=]$/
      if self.has_key?(m)
        # I respond to m because I have a key of m
        true
      else
        # I don't have a key for m so ask the universe if I respond to m
        super
      end
    else
      super
    end
  end

  class << self
    attr_reader :records

    def keys
      # Always return the keys in the same order
      @keys.sort
    end

    # ::build_key(Hash)
    # builds the key to be used in the records hash
    def build_key(h)
      keys.inject('') {|acc, key| acc = "#{acc}\x01#{h[key]}"}[1..-1]
    end

    #
    # ::find(Hash)
    # find will find records using ==
    # pass whatever key/values you want to search by
    # find(player_id: 'matt', year: 2000) => return records with player_id = matt AND year = 2000
    #
    # Will first look for a record with matching keys (fast).  If args do not contain all key columns
    # ::find will resort to what is basically a table scan
    #
    # find(player_id: 'matt', year: 2000) =>
    #     return records with player_id = matt AND year = 2000 AND at_bats > 400
    def find(*args)
      raise ArgumentError unless args[0].is_a?(Hash)
      r = []
      # If args[0] has ALL of the class keys then look based on the key values
      # If args[0] does not have ALL of the class keys then drop to the table scan approach
      if args[0].has_keys?(keys)
      # If the keys of args are a subset of keys then look up by the key values
        key_record = records[build_key(args[0])]
        if key_record
          # Make sure the other elements of args[0] match the corresponding k/v pairs in key_record
          match = true
          args[0].each_pair do |k, v|
           match = false unless key_record[k] == v
           break unless match
          end
          r << key_record if match
        else
          # the record you are looking for isn't here, stop searching
        end
      else
      # look at each record in records individually - basically a table scan
        records.each_value do |record|
          match = true
          args[0].each do |k, v|
            match = false unless record.send(k) && record.send(k) == v
            break unless match
          end
          r << record if match
        end
        return r unless r.empty?
        nil
      end
    end


    # Does what is says on the tin, finds the max attribute for a list of filters
    # The filters are of the same format as those used in find
    # attribute should be a Symbol representing the attribute that is used in the comparison
    #
    #   find_max(:home_runs, year: year, league: league, "at_bats>" => 400)
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

    # Loads records into itself.  Does this by either creating a new descendant of Record and
    # adding it to itself OR updating the existing Record object, typically adding the new values
    # to the existing values
    # Accepts a Hash, does not to be a descendant of Record.  Remember the Hash must have the required
    # keys to be accepted by the class.
    #   load(myHash)
    def load(record, bulk = false)
      return unless record.is_a?(Hash) && record.has_keys?(keys)
      if bulk
        # just insert the record, this is a bulk load of data
        new(record)
      else

        # Do I already have a record with these key values?
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
end
