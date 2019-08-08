# frozen_string_literal: true

require_relative '../dependencies'

class GameMenu
  class << self
    include Validation
    include Database
    include GameStart
    include Info

    def welcome
      welcome_info
      run
    end

    def run
      loop do
        menu_info
        case gets.chomp
        when 'start' then break registration
        when 'rules' then rules
        when 'stats' then stats
        when 'exit' then break close
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
        name_info
        name = gets.chomp
        break close if name == 'exit'
        break name if name_is_valid?(name)

        wrong_input(__method__)
      end
    end

    def choose_difficulty
      loop do
        difficulty_info
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
      rules_info
    end

    def stats
      return no_stats_info unless File.exist?('seed.yaml')

      table = load.sort_by { |row| [row.hints_total, row.attempts_used] }
      table.map { |row| row.difficulty = DIFFICULTY_LEVEL.key([row.attempts_total, row.hints_total]) }
      table_info(table)
    end

    def wrong_input(from)
      wrong_input_hash = {
        choose_difficulty: I18n.t(:wrong_difficulty),
        choose_name: I18n.t(:wrong_name),
        run: I18n.t(:wrong_run)
      }
      wrong_input_info(wrong_input_hash[from])
    end

    def close
      goodbye_info
      exit
    end
  end
end
