module Dedupe
  class Application
    DEFAULT_BUCKET_SIZE = 200

    def initialize(args = {})
      @filename = args[:filename]
      @bucket_size = args[:bucket_size] || DEFAULT_BUCKET_SIZE
    end

    def run
      # buffer read in chunks
      # sort and remove duplicates each chunk into separate files
      # merge and remove duplicates when merging
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