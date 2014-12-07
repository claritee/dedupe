# Public: Class that handles merging all the sorted buckets
# Each bucket on disk is read and written to an output file
#
# Examples
#
#   Dedupe::Merger.new.sort('output.txt', buckets)
#
module Dedupe
  class Merger
    def merge(output, buckets)
      output_file = File.open(output, 'w+')
      buckets.keys.sort.each do |key|
        File.readlines(buckets[key]).each { |line| output_file << format_line(line) }
      end
      output_file.close
    end

    private

    def format_line(line)
      line.end_with?("\n") ? line : line << "\n"
    end
  end
end