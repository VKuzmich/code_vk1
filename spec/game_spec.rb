require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe Game do
  subject(:game) { described_class.new(name: 'Rspec', difficulty: :easy) }

  describe '.check' do
    it 'returns true when #check_numbers equal secret' do
      expect(game.check(game.secret)).to eq(Game::GOT_IT * 4)
    end
  end

  describe '#use_hint' do
    it 'decrements hints and calls a #hint' do
      game.instance_variable_set(:@hints, 1)
      expect { game.use_hint }.to change(game, :hints).by(-1)
    end

    it 'returns a message if no hints left' do
      game.instance_variable_set(:@hints, 0)
      expect(game.use_hint).to eq(I18n.t(:no_hints))
    end
  end
end
