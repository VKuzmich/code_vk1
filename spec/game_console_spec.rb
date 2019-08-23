require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe GameConsole do
  let(:game_console) { described_class.new('Rspec', :easy) }

  before do
    allow(STDOUT).to receive(:puts).with(anything)
  end

  describe '#start' do
    before do
      allow(game_console).to receive(:loop).and_yield
    end

    after do
      game_console.start
    end

    it 'calls close method' do
      allow(game_console).to receive(:gets).and_return(GameMenu::EXIT)
      expect(game_console).to receive(:close)
    end

    it 'shows a Game Over text' do
      allow(game_console).to receive(:statistics)
      game_console.instance_variable_get(:@game).instance_variable_set(:@attempts, 0)
      expect(STDOUT).to receive(:puts).with(I18n.t(:game_over))
    end

    it 'calls a use_hint method from Game class' do
      allow(game_console).to receive(:gets).and_return(GameConsole::HINT)
      expect(game_console.instance_variable_get(:@game)).to receive(:use_hint)
    end

    it 'shows a message' do
      allow(game_console).to receive(:gets).and_return(I18n.t(:wrong_input))
      expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_process))
    end

    it 'calls a check method from Game class' do
      allow(game_console).to receive(:gets).and_return("1234\n")
      expect(game_console.instance_variable_get(:@game)).to receive(:check)
    end
  end

  describe '#close' do
    it 'says goodbye' do
      allow(game_console).to receive(:exit)
      expect { game_console.close }.to output(I18n.t(:goodbye)).to_stdout
    end

    it 'closes' do
      expect(game_console).to receive(:exit)
      game_console.close
    end
  end

  describe '#statistics' do
    after do
      game_console.statistics
    end

    # it 'shows a lose message' do
    #   game_console.instance_variable_get(:@game).instance_variable_set(:@win, false)
    #   expect(STDOUT).to receive(:puts).with(I18n.t(:lose))
    # end
    #
    # it 'shows a win message' do
    #   game_console.instance_variable_get(:@game).instance_variable_set(:@win, true)
    #   allow(game_console).to receive(:gets).and_return("no\n")
    #   expect(STDOUT).to receive(:puts).with(I18n.t(:win))
    # end
    #
    # it 'calls save_results method' do
    #   game_console.instance_variable_get(:@game).instance_variable_set(:@win, true)
    #   allow(game_console).to receive(:gets).and_return(GameConsole::SAVE)
    #   expect(game_console).to receive(:save_results)
    # end
  end

  describe '.save_results' do
    it 'calls a save method from DataBase' do
      expect(game_console).to receive(:save)
      game_console.save_results
    end
  end
end
