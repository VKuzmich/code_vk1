require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe GameMenu do
  describe '.welcome' do
    after do
      described_class.welcome
    end

    it 'shows greeting' do
      allow(described_class).to receive(:run)
      expect(STDOUT).to receive(:puts).with(I18n.t(:greeting))
    end

    it 'calls run method' do
      expect(described_class).to receive(:run)
    end
  end

  describe '.run' do
    let(:start) {"start\n"}
    let(:rules) {"rules\n"}
    let(:stats) {"stats\n"}
    let(:exit) {"exit\n"}
    before do
      allow(described_class).to receive(:loop).and_yield
    end

    after do
      described_class.run
    end

    it 'calls registration method' do
      allow(described_class).to receive(:gets).and_return(start)
      expect(described_class).to receive(:registration)
    end

    it 'calls rules method' do
      allow(described_class).to receive(:gets).and_return(rules)
      expect(described_class).to receive(:rules)
    end

    it 'calls stats method' do
      allow(described_class).to receive(:gets).and_return(stats)
      expect(described_class).to receive(:stats)
    end

    it 'calls close method' do
      allow(described_class).to receive(:gets).and_return(exit)
      expect(described_class).to receive(:close)
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return('wrong input')
      expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_run))
    end
  end

  describe '.rules' do
    it 'shows the rules' do
      expect { described_class.rules }.to output(I18n.t(:rules)).to_stdout
    end
  end

  describe '.stats' do
    it 'shows a stats' do
      expect(described_class).to receive(:puts)
      described_class.stats
    end
  end

  describe '.close' do
    it 'says goodbye' do
      allow(described_class).to receive(:exit)
      expect { described_class.close }.to output(I18n.t(:goodbye)).to_stdout
    end

    it 'closes' do
      expect(described_class).to receive(:exit)
      described_class.close
    end
  end

  describe '.registration' do
    it 'returns GameConsole start' do
      allow(described_class).to receive(:loop).and_yield
      allow(described_class).to receive(:gets).and_return("Name\n", "Easy\n")
      expect(GameConsole).to receive_message_chain(:new, :start)
      described_class.registration
    end
  end

  describe '.choose_difficulty' do
    before do
      allow(described_class).to receive(:loop).and_yield
    end

    it 'calls close method' do
      allow(described_class).to receive(:gets).and_return("exit\n")
      expect(described_class).to receive(:close)
      described_class.choose_difficulty
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return('wrong input')
      expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_difficulty))
      described_class.choose_difficulty
    end

    it 'returns a correct difficulty level' do
      {
          'easy' => :easy,
          'medium' => :medium,
          'hell' => :hell
      }.each_pair do |input, output|
        allow(described_class).to receive(:gets).and_return(input)
        expect(described_class.choose_difficulty).to eq(output)
      end
    end
  end

  describe '.choose_name' do
    before do
      allow(described_class).to receive(:loop).and_yield
    end

    it 'calls close method' do
      allow(described_class).to receive(:gets).and_return("exit\n")
      expect(described_class).to receive(:close)
      described_class.choose_name
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return("no\n")
      expect(STDOUT).to receive(:puts).with(I18n.t(:wrong_name))
      described_class.choose_name
    end

    it 'returns a choosen name' do
      allow(described_class).to receive(:gets).and_return("Name\n")
      expect(described_class.choose_name).to eq('Name')
    end
  end
end
