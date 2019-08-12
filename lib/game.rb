# frozen_string_literal: true

require_relative '../dependencies'

class Game
  # include GameStart
  include Validation

  attr_accessor :attempts_total, :attempts, :difficulty, :hints_total, :hints, :name, :win, :secret
  DIFFICULTY_LEVEL = {
      easy: { attempts: 15, hints: 3 },
      medium: { attempts: 10, hints: 2 },
      hell: { attempts: 5, hints: 1 }
  }.freeze

  def initialize(name:, difficulty:)
    @name = name
    @difficulty = difficulty
    @attempts = DIFFICULTY_LEVEL[difficulty][:attempts]
    @hints = DIFFICULTY_LEVEL[difficulty][:hints]
    @win = false
    @secret = make_number
    @unused_hints = @secret.chars
  end

  NOT_YET = '-'
  GOT_IT = '+'

  def make_number(chars = 4, numbers = 6)
    (1..chars).map { rand(1..numbers) }.join
  end

  def check_numbers(secret, numbers)
    minuses = (secret & numbers).map { |element| [secret.count(element), numbers.count(element)].min }.sum
    result = NOT_YET * minuses

    numbers.each.with_index do |number, index|
      result.sub!(NOT_YET, GOT_IT) if number == secret[index]
    end

    result
  end

  def hint(secret)
    secret.shuffle!.pop
  end

  def calc_counts(difficulty)
    DIFFICULTY_LEVEL[difficulty]
  end

  def check(number)
    @attempts -= 1
    result = check_numbers(@secret.chars, number.chars)
    @win = true if result == GOT_IT * Validation::NUMBERS
    result
  end

  def use_hint
    return I18n.t(:no_hints) unless @hints.positive?

    @hints -= 1
    hint(@unused_hints)
  end
end
