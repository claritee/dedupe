module Dedupe
  class Application
    DEFAULT_BUCKET_SIZE = 200

    def initialize(args = {})
      @input = args[:input] || $stdin
      puts "started"
    end

    def process_file(filename)

    end
  end
end