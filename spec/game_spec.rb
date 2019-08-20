require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe Game do
  subject(:game) { described_class.new(name: 'Rspec', difficulty: :easy) }

  describe '.check_numbers' do
    let(:examples) { YAML.load_file('spec/fixtures/examples.yml') }

    it 'returns a correct answer' do
      examples.each do |example|
        result = game.send(:check_numbers, example[0].chars, example[1].chars)
        expect(result).to eq(example[2])
      end
    end
  end

  describe '.hint' do
    let(:secret_code) { '1234' }
    let(:unused_hints) { secret_code.chars }

    it 'is included in secret code' do
      result = game.send(:hint, secret_code)
      expect(result).to include(game.hint(unused_hints))
    end

    it 'is shorter then before' do
      old_length = unused_hints.length + 1
      result = game.send(:hint, unused_hints)
      expect(result.length).to be < old_length
    end
  end

  describe '.check' do
    it 'returns ++++' do
      expect(game.check(game.secret)).to eq('++++')
    end
  end

  describe '#use_hint' do
    it 'decrements hints and calls a hint method if hints > 0' do
      game.instance_variable_set(:@hints, 1)
      expect { game.use_hint }.to change(game, :hints).by(-1)
    end

    it 'returns a message if no hints left' do
      game.instance_variable_set(:@hints, 0)
      expect(game.use_hint).to eq(I18n.t(:no_hints))
    end
  end
end
