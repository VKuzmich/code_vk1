# frozen_string_literal: true

module GameStart
  DIFFICULTY_LEVEL= {
      I18n.t(:easy) => [15, 3],
      I18n.t(:medium) => [10, 2],
      I18n.t(:hell) => [5, 1]
  }.freeze

  def make_number(chars = 4, numbers = 6)
    (1..chars).map { rand(1..numbers) }.join
  end

  def check_numbers(secret, numbers)
    minuses = (secret & numbers).map { |element| [secret.count(element), numbers.count(element)].min }.sum
    result = '-' * minuses

    numbers.each.with_index do |number, index|
      result.sub!('-', '+') if number == secret[index]
    end

    result
  end

  def hint(secret)
    secret.shuffle!.pop
  end

  def calc_counts(difficulty)
    DIFFICULTY_LEVEL[difficulty]
  end
end
