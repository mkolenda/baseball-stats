#
# Data loaded into Stat is from a text file.  These methods
# are used by the Loader module to determine if the data
# can be converted from a string to an integer or a float (for future pitching data)
#

class String

  # Is this string Integery
  def is_i?
    !!(self =~ /^[-+]?\d+$/)
  end

  # Does this string Float?
  def is_f?
    !!(self =~ /^[-+]?\d+.\d+$/)
  end

end

