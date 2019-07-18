

require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe GameConsole do
  let(:console) { described_class.new('Rspec', 'Easy') }

  before do
    allow(STDOUT).to receive(:puts).with(anything)
  end

  describe '#start' do
    before do
      allow(console).to receive(:loop).and_yield
    end

    after do
      console.start
    end

    it 'calls close method' do
      allow(console).to receive(:gets).and_return("exit\n")
      expect(console).to receive(:close)
    end

    it 'shows a Game Over text' do
      allow(console).to receive(:gstatistics)
      console.instance_variable_get(:@game).instance_variable_set(:@attempts, 0)
      expect(STDOUT).to receive(:puts).with('Game Over')
    end

    it 'calls a use_hint method from Game class' do
      allow(console).to receive(:gets).and_return("hint\n")
      expect(console.instance_variable_get(:@game)).to receive(:use_hint)
    end

    it 'shows a message' do
      allow(console).to receive(:gets).and_return('wrong input')
      expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_process))
    end

    it 'calls a check method from Game class' do
      allow(console).to receive(:gets).and_return("1234\n")
      expect(console.instance_variable_get(:@game)).to receive(:check)
    end
  end

  describe '#close' do
    it 'says goodbye' do
      allow(console).to receive(:exit)
      expect { console.close }.to output(I18n.t(:goodbye)).to_stdout
    end

    it 'closes' do
      expect(console).to receive(:exit)
      console.close
    end
  end

  describe '#statistics' do
    after do
      console.statistics
    end

    it 'shows a lose message' do
      console.instance_variable_get(:@game).instance_variable_set(:@win, false)
      expect(STDOUT).to receive(:puts).with(I18n.t(:lose))
    end

    it 'shows a win message' do
      console.instance_variable_get(:@game).instance_variable_set(:@win, true)
      allow(console).to receive(:gets).and_return("no\n")
      expect(STDOUT).to receive(:puts).with(I18n.t(:win))
    end

    it 'calls save_results method' do
      console.instance_variable_get(:@game).instance_variable_set(:@win, true)
      allow(console).to receive(:gets).and_return("save\n")
      expect(console).to receive(:save_results)
    end
  end

  describe '.save_results' do
    it 'calls a save method from DataUtils' do
      expect(console).to receive(:save)
      console.save_results
    end
  end
end
