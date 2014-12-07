require 'set'

# Public: Class that handles sorting the input.
# Each input is added to it's bucket and sorted by alphabetical order.
# Duplicates are removed as a part of this process.
# Buckets are saved on disk and updated with new unique elements
#
# Examples
#
#   Dedupe::Sorter.new.sort(lines)
#
module Dedupe
  class Sorter

    attr_reader :buckets

    def initialize
      @buckets = {}
    end

    def sort(lines)
      sort_buckets(partition(lines))
    end

    private

    def partition(lines)
      segments = {}
      lines.each { |line| add_element_to_partition(segments, line.chr.downcase, line) }
      segments
    end

    def add_element_to_partition(segments, key, value)
      segments[key.to_sym] = segments[key.to_sym].nil? ? [value] : segments[key.to_sym] << value
    end

    def sort_buckets(segments)
      segments.each do |key, values|
        lines = add_to_bucket(bucket_filename(key), values)
        sorted = lines.sort.uniq
        write_new_buckets(sorted, key)
      end
    end

    def bucket_filename(key)
      @buckets[key] || "#{key}.txt"
    end

    def add_to_bucket(bucket_filename, values)
      File.exists?(bucket_filename) ? File.readlines(bucket_filename).concat(values) : values
    end

    def write_new_buckets(sorted, key)
      @buckets[key.to_sym] = bucket_filename(key)
      output = File.open(bucket_filename(key), 'w+')
      sorted.each { |line| output << line }
      output.close
    end
  end
end