#!/usr/bin/ruby

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
			raise ArgumentError, "There is no option: '#{option}'"
		end
		id = @options[option]
		id += 1
		arg = @argv[id]
		unless arg
			raise ArgumentError, "No argument for option '#{option}'"
		end
		if arg[0] == "-"
			raise "'#{arg}' is not an argument, tis an option"
		end
		arg
	end
end

x = Parser.new ARGV
puts x.option_exist? "-b"
puts x.get_arg_for_option "-b"
