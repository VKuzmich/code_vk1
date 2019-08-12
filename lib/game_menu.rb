# frozen_string_literal: true

require_relative '../dependencies'

class GameMenu
  extend Validation
  extend Database
  extend GameStart

  START = 'start'
  RULES = 'rules'
  STATISTICS = 'stats'
  EXIT = 'exit'

  class << self
    def welcome
      puts I18n.t(:greeting)
      run
    end

    def run
      loop do
        puts I18n.t(:menu)
        case gets.chomp
        when START then break registration
        when RULES then rules
        when STATISTICS then stats
        when EXIT then break close
        else puts I18n.t(:wrong_run)
        end
      end
    end

    def registration
      GameConsole.new(choose_name, choose_difficulty).start
      welcome
    end

    def choose_name
      loop do
        puts I18n.t(:choose_name)
        name = gets.chomp
        break close if name == EXIT
        break name if name_is_valid?(name)

        puts I18n.t(:wrong_name)
      end
    end

    def choose_difficulty
      loop do
        puts I18n.t(:choose_difficulty)
        input = gets.chomp
        break close if input == EXIT
        break input.to_sym if GameStart::DIFFICULTY_LEVEL.keys.include? input.to_sym
        puts I18n.t(:wrong_difficulty)
      end
    end

    def rules
      puts I18n.t(:rules)
    end

    def stats
      return puts I18n.t(:no_stats) unless File.exist?('seed.yaml')

      table = load.sort_by { |row| [row.hints_total, row.attempts_used] }
      table.map { |row| row.difficulty = DIFFICULTY_LEVEL.key([row.attempts_total, row.hints_total]) }
      puts table
    end

    def close
      puts I18n.t(:goodbye)
      exit
    end
  end
end
