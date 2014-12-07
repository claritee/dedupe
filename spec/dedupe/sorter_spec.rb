require 'spec_helper'

describe Dedupe::Sorter do

  describe 'sorts the file' do
    before :all do
      @sorter = Dedupe::Sorter.new
      input = data_path('small_valid_input.txt')
      @sorter.sort(File.new(input).readlines)
      @buckets = @sorter.buckets
    end

    after :all do
      @buckets.each { |key, filename| File.delete(filename) }
    end

    it 'there are correct number of buckets ' do
      expect(@buckets.count).to eq 3
    end

    it 'elements are sorted in a bucket' do
      expected_result = File.open(data_path('a.txt')).readlines
      bucket_data = File.open(@buckets[:a]).readlines
      expect(bucket_data).to eql expected_result
    end
  end
end