# frozen_string_literal: true

require_relative '../dependencies'

class GameMenu
  class << self
    include Validation
    include Database
    include GameStart

    START = 'start'
    RULES = 'rules'
    STATISTICS = 'stats'
    EXIT = 'exit'

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
        else wrong_input(__method__)
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
        break close if name == 'exit'
        break name if name_is_valid?(name)

        wrong_input(__method__)
      end
    end

    def choose_difficulty
      loop do
        puts I18n.t(:choose_difficulty)
        case gets.chomp
        when 'exit' then break close
        when 'easy' then break :easy
        when 'medium' then break :medium
        when 'hell' then break :hell
        else wrong_input(__method__)
        end
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

    def wrong_input(from)
      wrong_input_hash = {
        choose_difficulty: I18n.t(:wrong_difficulty),
        choose_name: I18n.t(:wrong_name),
        run: I18n.t(:wrong_run)
      }
      puts wrong_input_hash[from]
    end

    def close
      puts I18n.t(:goodbye)
      exit
    end
  end
end
