module Dedupe
  class Merger
    def merge(output, buckets)
      output_file = File.open(output, 'w+')
      buckets.keys.sort.each do |key|
        bucket = File.open(buckets[key], 'r')
        lines = bucket.readlines
        lines.each { |line| output_file << format_line(line) }
        bucket.close
      end
      output_file.close
    end

    private

    def format_line(line)
      line.end_with?("\n") ? line : line << "\n"
    end
  end
end