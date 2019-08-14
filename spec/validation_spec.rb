require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe Validation do
  let(:game_class) { Class.new { extend Validation } }

  describe '.valid_string_length??' do
    it 'returns true cause of correct data' do
      expect(game_class.valid_string_length?('Rspec')).to eq(true)
    end

    it 'returns false cause of too short data' do
      expect(game_class.valid_string_length?('Rs')).to eq(false)
    end

    it 'returns false cause of too long data' do
      expect(game_class.valid_string_length?('RspecRspecRspecRspecR')).to eq(false)
    end

    it 'returns false cause of empty data' do
      expect(game_class.valid_string_length?('')).to eq(false)
    end

    it 'returns false cause of data is not a string' do
      expect(game_class.valid_string_length?(123)).to eq(false)
    end
  end

  describe '.match_pattern??' do
    it 'returns true cause of correct data' do
      expect(game_class.match_pattern?('1234')) == (true)
    end

    it 'returns false cause of incorrect data' do
      %w[123 12345 0123 3210 1237].each do |incorrect_data|
        expect(game_class.match_pattern?(incorrect_data)) == (false)
      end
    end
  end
end
