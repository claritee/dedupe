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

  it 'processes the file' do
    application = Dedupe::Application.new({filename: data_path('small_valid_input.txt')})
    expect { application.run }.not_to raise_error
  end

  pending 'sorts and dedupes'
end