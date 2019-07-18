# frozen_string_literal: true

class GameConsole
  include Validation
  include Database
  include GameStart
  include Info

  def initialize(name, difficulty)
    @game = Game.new(name: name, difficulty: difficulty)
  end

  def start
    loop do
      break if @game.attempts.zero? || @game.win

      start_info(@game.attempts, @game.hints)
      input = gets.chomp
      case input
      when 'exit' then break close
      when 'hint' then next hint_info(@game.use_hint)
      when /^[1-6]{4}/ then check_info(@game.check(input))
      else next wrong_process_info unless guess_is_valid?(input)
      end
    end
    game_over_info
    statistics
  end

  def statistics
    summary_info(@game.secret)
    if @game.win
      win_info
      save_info
      save_results if gets.chomp == 'save'
    else
      lose_info
    end
  end

  def save_results
    attempts_total = calc_counts(@game.difficulty)[0]
    hints_total = calc_counts(@game.difficulty)[1]
    summary = {
        name: @game.name,
        difficulty: @game.difficulty,
        attempts_total: attempts_total,
        att_used: attempts_total - @game.attempts,
        hints_total: hints_total,
        hints_used: hints_total - @game.hints
    }
    save(summary)
  end

  def close
    goodbye_info
    exit
  end
end
