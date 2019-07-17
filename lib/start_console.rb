# frozen_string_literal: true

require_relative '../dependencies'

class StartConsole

  class << self
    include Validation
    include Database
    include GameStart
    include Output

    def welcome
      welcome_output
      run
    end

    def run
      loop do
        menu_output
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
        name_output
        name = gets.chomp
        break close if name == 'exit'
        break name if name_is_valid?(name)

        wrong_input(__method__)
      end
    end

    def choose_difficulty
      loop do
        difficulty_output
        case gets.chomp
        when 'exit' then break close
        when 'easy' then break I18n.t(:easy)
        when 'medium' then break I18n.t(:medium)
        when 'hell' then break I18n.t(:hell)
        else wrong_input(__method__)
        end
      end
    end

    def rules
      rules_output
    end

    def stats
      return no_stats_output unless File.exist?('seed.yaml')

      table = load.sort_by { |row| [row.hints_total, row.att_used] }
      table.map { |row| row.difficulty = DIFFICULTY_LEVEL.key([row.attempts_total, row.hints_total]) }
      table_output(table)
    end

    def wrong_input(from)
      wrong_input_hash = {
          choose_difficulty: I18n.t(:wrong_difficulty),
          choose_name: I18n.t(:wrong_name),
          run: I18n.t(:wrong_run)
      }
      wrong_input_output(wrong_input_hash[from])
    end

    def close
      goodbye_output
      exit
    end
  end
end
