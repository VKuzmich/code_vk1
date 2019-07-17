# frozen_string_literal: true

class GameConsole
  include Validation
  include Database
  include GameStart
  include Output

  def initialize(name, difficulty)
    @game = Game.new(name: name, difficulty: difficulty)
  end

  def start
    loop do
      break if @game.attempts.zero? || @game.win

      start_output(@game.attempts, @game.hints)
      input = gets.chomp
      case input
      when 'exit' then break close
      when 'hint' then next hint_output(@game.use_hint)
      when /^[1-6]{4}/ then check_output(@game.check(input))
      else next wrong_process_output unless guess_is_valid?(input)
      end
    end
    game_over_output
    game_summary
  end

  def game_summary
    summary_output(@game.secret)
    if @game.win
      win_output
      save_output
      save_results if gets.chomp == 'save'
    else
      lose_output
    end
  end

  def save_results
    att_total = calc_attempts_and_hints(@game.difficulty)[0]
    hints_total = calc_attempts_and_hints(@game.difficulty)[1]
    summary = {
        name: @game.name,
        difficulty: @game.difficulty,
        att_total: att_total,
        att_used: att_total - @game.attempts,
        hints_total: hints_total,
        hints_used: hints_total - @game.hints
    }
    save(summary)
  end

  def close
    goodbye_output
    exit
  end
end
