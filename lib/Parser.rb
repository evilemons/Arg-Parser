#!/usr/bin/env ruby

class ParseError < StandardError
	attr_reader :object

	def initialize object
		@object = object
	end
end

class Parser
	def initialize arg #(array)
		@argv= arg
		@options = Hash.new
		@argv.each_with_index do |x, i|
			@options[x] = i
		end
	end
	def option_exist? option
		if @options[option]
			true
		else
			false
		end
	end
	def get_arg_for_option option
		unless option_exist? option
			raise ParseError.new("NoOption"), "There is no option: '#{option}'"
		end
		id = @options[option]
		id += 1
		arg = @argv[id]
		unless arg
			raise ParseError.new("NoArgument"), "No argument for option '#{option}'"
		end
		if arg[0] == "-"
			raise ParseError.new("ArgIsOption"), "'#{arg}' is not an argument, tis an option"
		end
		arg
	end
	def arg_for_option option
		opt = self.get_arg_for_option option
		yield opt
	end
end

if __FILE__ == $0

	x = Parser.new ARGV
	x.arg_for_option "-b" do |x|
		puts x
	end

end
