# frozen_string_literal: true

require_relative '../lib/game_start'

class Game
  include GameStart

  attr_accessor :att_total, :attempts, :difficulty, :hints_total, :hints, :name, :win, :secret

  def initialize(name:, difficulty:)
    @name = name
    @difficulty = difficulty
    @attempts = calc_attempts_and_hints(difficulty)[0]
    @hints = calc_attempts_and_hints(difficulty)[1]
    @win = false
    @secret = make_number
    @unused_hints = @secret.chars
  end

  def check(number)
    @attempts -= 1
    result = check_numbers(@secret.chars, number.chars)
    @win = true if result == '++++'
    result
  end

  def use_hint
    return I18n.t(:no_hints) unless @hints.positive?

    @hints -= 1
    hint(@unused_hints)
  end
end