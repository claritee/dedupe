# Public: Application that coordinates sorting, merging and deduping.
# Examples
#
#   Dedupe::Application.new({filename: 'input.txt'})
#   # => 'result.txt'
module Dedupe
  class Application
    DEFAULT_BUCKET_SIZE = 200

    def initialize(args = {})
      @filename = args[:filename]
      @bucket_size = args[:bucket_size] || DEFAULT_BUCKET_SIZE
      @sorter = Dedupe::Sorter.new
    end

    # Public: Processes an input file for sorting and deduping
    #
    # For large files, the input file will be buffered and read in blocks
    # Each block will be sorted and deduped separately (something like bucket sort, key is start of the word)
    # Each block will be merged
    #
    # Examples
    #
    #   Dedupe::Application.new.run
    #   # => 'result.txt'
    #
    # Returns the sorted and deduped result filename
    def run
      fail('Unable to dedup and sort. No filename provided') and return unless @filename
      fail("Unable to dedupe and sort. #{@filename} does not exist") and return unless File.exists?(@filename)
      sort_dedupe_merge
    end

    private

    def sort_dedupe_merge
      sorter = Dedupe::Sorter.new
      sort(sorter)
      merge(sorter.buckets)
      clean_up(sorter.buckets)
    end

    def sort(sorter)
      File.foreach(@filename).each_slice(@bucket_size) { |lines| sorter.sort(lines) }
    end

    def merge(buckets)
      Dedupe::Merger.new.merge('deduped_sorted_result.txt', buckets)
    end

    def clean_up(buckets)
      buckets.each { |key, filename| File.delete(filename) }
    end
  end
end