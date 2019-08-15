# frozen_string_literal: true

require_relative '../dependencies'

class GameConsole
  include Validation
  include Database

  HINT = 'hint'
  SAVE = 'save'

  def initialize(name, difficulty)
    @game = Game.new(name: name, difficulty: difficulty)
  end

  def start
    loop do
      break if @game.attempts.zero? || @game.win

      start_info(@game.attempts, @game.hints)
      input = gets.chomp
      case input
      when GameMenu::EXIT then break close
      when HINT then next puts @game.use_hint
      when /^[1-6]{4}/ then puts @game.check(input)
      else next puts I18n.t(:wrong_process) unless match_pattern?(input)
      end
    end
    puts I18n.t(:game_over)
    statistics
  end

  def start_info(attempts, hints)
    puts I18n.t(:game_process, attempts: attempts, hints: hints)
  end

  def statistics
    summary_info(@game.secret)
    if @game.win
      puts I18n.t(:win)
      print I18n.t(:save)
      save_results if gets.chomp == SAVE
    else
      puts I18n.t(:lose)
    end
  end

  def summary_info(secret)
    puts I18n.t(:secret, secret: secret)
  end

  def close
    puts I18n.t(:goodbye)
    exit
  end
end
