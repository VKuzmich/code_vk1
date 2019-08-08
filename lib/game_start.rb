# frozen_string_literal: true

module GameStart
  DIFFICULTY_LEVEL = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 2 },
      hell: { attempts: 5, hints: 1 }
  }.freeze

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
end
