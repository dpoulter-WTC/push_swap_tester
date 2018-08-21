#!/usr/bin/ruby

# Usage:
#  ruby pushswaptest.rb ./push_swap_binary "3 2 1"
#  ruby pushswaptest.rb ./push_swap_binary

require 'set'

def rand_n(n, max)
	randoms = Set.new
	loop do
		randoms << rand(max)
		return randoms.to_a if randoms.size >= n
	end
end

def check_string(string)
	string.scan(/\D/).empty?
end

$counter = 0

class List

	attr_accessor :a, :b

	def initialize(numbers)
		@a = numbers || []
		@b = []
	end

	def sa
		@a[0], @a[1] = @a[1], @a[0] unless @a.count <= 1
	end

	def sb
		@b[0], @b[1] = @b[1], @b[0] unless @b.count <= 1
	end

	def ss
		sa
		sb
	end

	def pa
		@a.unshift(@b.slice!(0)) unless @b.count == 0
	end

	def pb
		@b.unshift(@a.slice!(0)) unless @a.count == 0
	end

	def ra
		@a.rotate!
	end

	def rb
		@b.rotate!
	end

	def rr
		ra
		rb
	end

	def rra
		@a.rotate!(-1)
	end

	def rrb
		@b.rotate!(-1)
	end

	def rrr
		rra
		rrb
	end

	def to_s
		" -> #{@a.to_s}\n -> #{@b.to_s}"
	end

end

$amount = 500

if ARGV[1].nil? || ARGV[1] == ""
	numbers = rand_n(500, 10000)
else
	if check_string(ARGV[1])
		numbers = rand_n(ARGV[1].to_i, 10000)
	else
		numbers = ARGV[1].split(' ').map(&:to_i)
	end
end

save = list = List.new numbers
commands = `#{ARGV[0]} #{numbers.join(' ')}`.split(' ')

puts "Begin", list, "\n"

commands.each do |command|
	if !List.methods.map(&:to_s).include? command
		item = 0
		for item in commands
			list.send item
			$counter = $counter + 1
		end
		break
	end
end

puts "\nFinal", list, "\n"

if list.a == save.a.sort || list.a == save.a.sort.reverse
	print "Moves: ", $counter
	puts " "
	puts "[   OK   ]"
	exit 0
else
	puts "[  FAIL  ]"
	exit 1
end

