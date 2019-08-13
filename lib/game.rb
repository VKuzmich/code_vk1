# frozen_string_literal: true

require_relative '../dependencies'

class Game
  # include GameStart
  include Validation

  NOT_YET = '-'
  GOT_IT = '+'
  DIFFICULTY_LEVEL = {
      easy: { attempts: 15, hints: 3 },
      medium: { attempts: 10, hints: 2 },
      hell: { attempts: 5, hints: 1 }
  }.freeze

  attr_accessor :attempts_total, :attempts, :difficulty, :hints_total, :hints, :name, :win, :secret

  def initialize(name:, difficulty:)
    @name = name
    @difficulty = difficulty
    @attempts = DIFFICULTY_LEVEL[difficulty][:attempts]
    @hints = DIFFICULTY_LEVEL[difficulty][:hints]
    @win = false
    @secret = make_number
    @unused_hints = @secret.chars
  end


  def make_number(numbers = 6)
    (1..Validation::SECRET_CODE_LENGTH).map { rand(1..numbers) }.join
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
    secret.shuffle.pop
  end

  def check(number)
    @attempts -= 1
    result = check_numbers(@secret.chars, number.chars)
    @win = true if result == GOT_IT * Validation::SECRET_CODE_LENGTH
    result
  end

  def use_hint
    return I18n.t(:no_hints) unless @hints.positive?

    @hints -= 1
    hint(@unused_hints)
  end
end
