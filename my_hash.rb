#
# The three classes Stat, StatPlayerYear and StatPlayerYearLeague
# have keys defined in them, which can be throught of as primary keys
# When a record is added to these classes the Hash#has_keys? method
# determines if the record is valid prior to loading
#

class Hash
  def has_keys?(*args)
    args.flatten! if args.is_a?(Array)
    args.each do |a|
      return false unless self.has_key?(a)
    end
    true
  end
end
