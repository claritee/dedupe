# Dedupe

This program deduplicates and sorts a large word file.


## Usage

### Install Ruby
First you need to install Ruby. The current supported version is Ruby 2.1 or above.

Please refer to https://www.ruby-lang.org/en/installation/

Then check the version of Ruby via:

     ruby -v


### Install Bundler

Bundler is used to download Ruby dependencies in projects

Please follow the getting started guide here http://bundler.io/

      gem install bundler

### Run the project

Install dependencies

      bundle install

Build the gem
      
      rake install

Run the program
      
      bin/run_program.rb <textfile>
      e.g. 
      bin/run_program.rb spec/data/KW_File.csv

Run tests (located in the specs directory)

      rspec