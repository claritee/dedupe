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

      file = File.new(@filename)
      fail("Unable to dedupe and sort. #{@filename} does not exist") and return unless file

      sort_dedupe_merge(file)
      file.close
    end

    private

    def sort_dedupe_merge(file)
      lines = file.readlines(@bucket_size)
      if lines.count < @bucket_size
        #sort and dedupe
      else
        #keep sorting, then merge
      end
    end
  end
end