require 'spec_helper'

describe Dedupe::Merger do
  let(:merger) { Dedupe::Merger.new }
  let(:buckets) { {a: data_path('a.txt'), l: data_path('l.txt'), t: data_path('t.txt')} }

  after :all do
    File.delete('output.txt')
  end

  it 'should merge results' do
    merger.merge('output.txt', buckets)
    output = File.open('output.txt').readlines
    expected = File.open(data_path('output_deduped_sorted.txt')).readlines
    expect(output).to match_array(expected)
  end
end