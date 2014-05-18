require_relative "stat_hash"

class C
  def im_the_man
    puts 'im the man'
  end

  def call_me(die)
    begin
      raise "I'm dead" if die
      im_the_man
    rescue
      puts "bam - dead"
    ensure
      puts "ensure is always run"
    end

  end
end

c = C.new
c.call_me(false)
puts '---'
c.call_me(true)
puts "--"

# # class ExampleClass
# #   @variable = "foo"
# #   @@variable = "bar"
# #
# #   def initialize
# #     @variable = "baz"
# #   end
# #
# #   def self.test
# #     puts @variable
# #   end
# #
# #   def test
# #     self.class.test
# #     puts @@variable
# #     puts @variable
# #   end
# #
# #   def self.variable(v)
# #     @variable = v
# #   end
# # end
# #
# # class ExampleSubclass < ExampleClass
# #   @variable = "1"
# #   @@variable = "2"
# #
# #   def initialize
# #     @variable = "3"
# #     self.class.variable(1)
# #   end
# # end
# #
# # class ExampleSubclass2 < ExampleClass
# #   #@variable = "1"
# #   @@variable = "2"
# #
# #   def initialize
# #     @variable = "3"
# #     self.class.variable(100)
# #   end
# # end
# #
# #
# # first_example = ExampleClass.new
# # first_example.test
# #
# # puts "---"
# #
# # second_example = ExampleSubclass.new
# # second_example.test
# #
# # puts "---"
# #
# # third_example = ExampleSubclass2.new
# # third_example.test
# #
# # puts "---"
# # second_example.test
# #
# # puts "---"
# # first_example.test
# #
# # puts '---'
# # third_example.test
#
# a = [4,3,2,1,0]
# b = [0,5,6,4]
#
# c = a.delete_if do |e|
#   b.include?(e) == false
# end
#
# puts c

# module M
#   def self.hello
#     puts "hello world"
#   end
# end
#
# M.hello

# h = {hello: 'world', born: 'to be free'}
# s = StatHash.new(h)
# j = StatHash.new(s)
#
# puts j.hello


