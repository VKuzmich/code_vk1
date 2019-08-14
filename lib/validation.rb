# frozen_string_literal: true

module Validation

  MIN_LETTERS = 3
  MAX_LETTERS = 20

  def name_is_valid?(name)
    name.is_a?(String) && name.length.between?(MIN_LETTERS, MAX_LETTERS)
  end

  def guess_is_valid?(guess)
    /^[Game::RANGE_START - Game:RANGE_END]{Game::SECRET_CODE_LENGTH}$/.match(guess, Game::SECRET_CODE_LENGTH)
  end

  # def match_pattern?(input, pattern)
end
