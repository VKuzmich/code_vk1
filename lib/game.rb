# frozen_string_literal: true

require_relative '../dependencies'

class Game
  include GameStart
  include Validation

  attr_accessor :attempts_total, :attempts, :difficulty, :hints_total, :hints, :name, :win, :secret

  def initialize(name:, difficulty:)
    @name = name
    @difficulty = difficulty
    @attempts = GameStart::DIFFICULTY_LEVEL[difficulty][:attempts]
    @hints = GameStart::DIFFICULTY_LEVEL[difficulty][:hints]
    @win = false
    @secret = make_number
    @unused_hints = @secret.chars
  end

  def check(number)
    @attempts -= 1
    result = check_numbers(@secret.chars, number.chars)
    @win = true if result == GameStart::GOT_IT * Validation::NUMBERS
    result
  end

  def use_hint
    return I18n.t(:no_hints) unless @hints.positive?

    @hints -= 1
    hint(@unused_hints)
  end
end
