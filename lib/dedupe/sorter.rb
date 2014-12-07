module Dedupe
  class Sorter

    DEFAULT_BUCKET_SIZE = 200

    attr_reader :buckets

    def initialize(bucket_size = DEFAULT_BUCKET_SIZE)
      @buckets = {}
      @bucket_size = bucket_size
    end

    def sort(lines)
      segments = partition(lines)
      sort_buckets(segments)
    end

    private

    def partition(lines)
      segments = {}
      lines.each { |line| add_element_to_partition(segments, line.chr.downcase, line) }
      segments
    end

    def add_element_to_partition(segments, key, value)
      segments[key.to_sym].nil? ? segments[key.to_sym] = [value] : segments[key.to_sym] << value
    end

    def sort_buckets(segments)
      segments.each do |key, values|
        lines = read_bucket(bucket_filename(key), values)
        sorted = SortedSet.new(lines.flatten)
        write_new_buckets(sorted.to_a, key)
      end
    end

    def bucket_filename(key)
      @buckets[key] || "#{key}.txt"
    end

    def read_bucket(bucket_filename, values)
      file = File.open(bucket_filename, 'w+')
      lines = [file.readlines, values]
      file.close
      lines
    end

    def write_new_buckets(sorted, key)
      output = File.open(bucket_filename(key), 'w+')
      sorted.each { |line| output << line }
      @buckets[key.to_sym] = bucket_filename(key)
      output.close
    end
  end
end