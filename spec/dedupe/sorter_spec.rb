require 'spec_helper'

describe Dedupe::Sorter do

  describe 'sorts the file' do
    before do
      @sorter = Dedupe::Sorter.new
      input = data_path('small_valid_input.txt')
      @sorter.sort(File.new(input).readlines)
      @buckets = @sorter.buckets
    end

    after do
      @buckets.each { |key, filename| File.delete(filename) }
    end

    it 'there are correct number of buckets ' do
      expect(@buckets.count).to eq 3
    end
    it 'first element in the bucket is correct' do
      file = File.open(@buckets[:a], 'r')
      lines = file.readlines
      expect(lines.first.strip).to eq 'abc'
    end
    it 'first element in the bucket is correct' do
      file = File.open(@buckets[:a], 'r')
      lines = file.readlines
      expect(lines.last.strip).to eq 'all season camping'
    end
  end
end