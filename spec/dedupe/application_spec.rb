require 'spec_helper'

describe 'Dedupe::Application' do

  describe 'checks that the file' do
    it 'needs to be defined' do
      application = Dedupe::Application.new({})
      expect { application.run }.to raise_error
    end
    it 'needs to exist' do
      application = Dedupe::Application.new({filename: 'made_up.txt'})
      expect { application.run }.to raise_error
    end
  end

  describe 'processes the file' do
    after do
      files = %w(a.txt l.txt t.txt deduped_sorted_result.txt)
      files.each { |file| File.delete(file) if File.exists?(file) }
    end
    it 'sorts and dedupes' do
      run_and_check('small_valid_input.txt', 'deduped_sorted_result.txt', 'output_deduped_sorted.txt')
    end
    it 'sorts and dedupes a large file' do
      run_and_check('KW_File.csv', 'deduped_sorted_result.txt', 'KW_File_sorted_deduped.txt')
    end
  end

  def run_and_check(input, output, expected)
    application = Dedupe::Application.new({filename: data_path(input)})
    application.run
    actual_result = File.open(output).readlines
    expected_result = File.open(data_path(expected)).readlines
    expect(actual_result).to match_array(expected_result)
  end
end