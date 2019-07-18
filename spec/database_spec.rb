

require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe Database do
  let(:game_class) { Class.new { extend Database } }
  let(:path) { 'seed.yaml' }

  let(:summary) do
    {
        name: 'Rspec',
        difficulty: 'Easy',
        attempts_total: 15,
        attempts_used: 1,
        hints_total: 3,
        hints_used: 1
    }
  end

  describe '#save' do
    it 'saves a TableData object to a new file' do
      random_file = 'random_file_name.yaml'
      game_class.save(summary, random_file)
      expect(File.exist?(random_file)).to eq(true)
      File.delete(random_file)
    end

    it 'saves a TableData object to exists file' do
      old_size = File.new(path).size
      game_class.save(summary, path)
      new_size = File.new(path).size
      expect(new_size).to be > old_size
    end
  end

  describe '#load' do
    it 'loads a TableData object array from file' do
      game_class.save(summary, path)
      expect(game_class.load(path)[0].is_a?(TableData)).to eq(true)
    end
  end
end
