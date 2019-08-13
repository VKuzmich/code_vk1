# frozen_string_literal: true

module Validation
  SECRET_CODE_LENGTH = 4
  MIN_LETTERS = 3
  MAX_LETTERS = 20

  def name_is_valid?(name)
    name.is_a?(String) && name.length.between?(MIN_LETTERS, MAX_LETTERS)
  end

  def guess_is_valid?(guess)
    /^[1-6]{SECRET_CODE_LENGTH}$/.match(guess, SECRET_CODE_LENGTH)
  end
end
