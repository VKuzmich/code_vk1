require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe Game do
  subject(:game) { described_class.new(name: 'Rspec', difficulty: :easy) }

  let(:examples) { YAML.load_file('spec/fixtures/examples.yml') }
  let(:guess_plus) { Game::GOT_IT }
  let(:guess_minus) { Game::NOT_YET }

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

  describe '#check' do
    it 'returns true when #check_numbers equal secret' do
      expect(game.check(game.secret)).to eq(Game::GOT_IT * 4)
    end
  end

  describe '#check "1234" ' do
    before { game.instance_variable_set(:@secret, '1111') }

    it 'returns a correct answer' do
      examples.each do |example|
        result = game.send(:check_numbers, example[0].chars, example[1].chars)
        expect(result).to eq(example[2])
      end
    end
  end

  describe '#check "1234" ' do
    before { game.instance_variable_set(:@secret, '1234') }

    it do
      numbers = '3214'
      expect(game.check(numbers)).to eq (guess_plus + guess_plus + guess_minus + guess_minus)
    end

    it do
      numbers = '1524'
      expect(game.check(numbers)).to eq (guess_plus + guess_plus + guess_minus)
    end
  end

  describe '#check "6133" ' do
    before { game.instance_variable_set(:@secret, '6133') }

    context 'getting pluses' do
      it do
        numbers = '5613'
        expect(game.check(numbers)).to eq (guess_plus + guess_minus + guess_minus)
      end

      it do
        numbers = '1243'
        expect(game.check(numbers)).to eq (guess_plus + guess_minus)
      end

      it do
        numbers = '4433'
        expect(game.check(numbers)).to eq (guess_plus + guess_plus)
      end

      it do
        numbers = '6133'
        expect(game.check(numbers)).to eq (guess_plus + guess_plus + guess_plus + guess_plus)
      end
    end

    context 'getting minuses' do
      it do
        numbers = '3256'
        expect(game.check(numbers)).to eq (guess_minus + guess_minus)
      end

      it do
        numbers = '1214'
        expect(game.check(numbers)).to eq (guess_minus)
      end

      it do
        numbers = '5555'
        expect(game.check(numbers)).to eq ('')
      end
    end
  end
end
