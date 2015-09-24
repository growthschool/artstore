require 'byebug/command'
require 'byebug/helpers/file'
require 'byebug/helpers/parse'

module Byebug
  #
  # List parts of the source code.
  #
  class ListCommand < Command
    include Helpers::FileHelper
    include Helpers::ParseHelper

    def regexp
      /^\s* l(?:ist)? (?:\s*([-=])|\s+(\S+))? \s*$/x
    end

    def execute
      exist = File.exist?(@state.file)
      return errmsg "No sourcefile available for #{@state.file}\n" unless exist

      @match ||= match('list')
      max_lines = n_lines(@state.file)
      b, e = range(@match[2], max_lines)
      return errmsg('Invalid line range') unless valid_range?(b, e, max_lines)

      display_lines(b, e)

      @state.prev_line = b
    end

    def description
      <<-EOD
        l[ist][[-=]][ nn-mm]

        Lists lines of code forward from current line or from the place where
        code was last listed. If "list-" is specified, lists backwards instead.
        If "list=" is specified, lists from current line regardless of where
        code was last listed. A line range can also be specified to list
        specific sections of code.
      EOD
    end

    private

    #
    # Line range to be printed by `list`.
    #
    # If <input> is set, range is parsed from it.
    #
    # Otherwise it's automatically chosen.
    #
    def range(input, max_line)
      size = [Setting[:listsize], max_line].min

      return set_range(size, max_line) unless input

      parse_range(input, size, max_line)
    end

    def valid_range?(first, last, max)
      first <= last && (1..max).include?(first) && (1..max).include?(last)
    end

    #
    # Set line range to be printed by list
    #
    # @param size - number of lines to be printed
    # @param max_line - max line number that can be printed
    #
    # @return first line number to list
    # @return last line number to list
    #
    def set_range(size, max_line)
      first = amend(lower(size, @match[1] || '+'), max_line - size + 1)

      [first, move(first, size - 1)]
    end

    def parse_range(input, size, max_line)
      first, err = get_int(lower_bound(input), 'List', 1, max_line)
      return [-1, -1] if err

      if upper_bound(input)
        last, = get_int(upper_bound(input), 'List', 1, max_line)
        return [-1, -1] unless last

        last = amend(last, max_line)
      else
        first -= (size / 2)
      end

      [first, last || move(first, size - 1)]
    end

    def amend(line, max_line)
      return 1 if line < 1

      [max_line, line].min
    end

    def lower(size, direction = '+')
      return @state.line - size / 2 if direction == '=' || !@state.prev_line

      move(@state.prev_line, size, direction)
    end

    def move(line, size, direction = '+')
      line.send(direction, size)
    end

    #
    # Show lines in @state.file from line number <min> to line number <max>.
    #
    def display_lines(min, max)
      puts "\n[#{min}, #{max}] in #{@state.file}"

      File.foreach(@state.file).with_index do |line, lineno|
        break if lineno + 1 > max
        next unless (min..max).include?(lineno + 1)

        mark = lineno + 1 == @state.line ? '=> ' : '   '
        puts format("#{mark}%#{max.to_s.size}d: %s", lineno + 1, line)
      end
    end

    private

    #
    # @param range [String] A string with an integer range format
    #
    # @return [String] The lower bound of the given range
    #
    def lower_bound(range)
      split_range(range)[0]
    end

    #
    # @param range [String] A string with an integer range format
    #
    # @return [String] The upper bound of the given range
    #
    def upper_bound(range)
      split_range(range)[1]
    end

    #
    # @param range [String] A string with an integer range format
    #
    # @return [Array] The upper & lower bounds of the given range
    #
    def split_range(str)
      str.split(/[-,]/)
    end
  end
end
