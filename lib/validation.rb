# frozen_string_literal: true

module Validation
  MIN_LETTERS = 3
  MAX_LETTERS = 20

  def valid_string_length?(name, min = MIN_LETTERS, max = MAX_LETTERS)
    name.is_a?(String) && name.length.between?(min, max)
  end

  def match_pattern?(guess)
    GameConsole::INPUT_DATA.match(guess, Game::SECRET_CODE_LENGTH)
  end
end
