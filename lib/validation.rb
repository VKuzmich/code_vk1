# frozen_string_literal: true

module Validation
  NUMBERS = 4

  def name_is_valid?(name)
    name.is_a?(String) && name.length.between?(3, 20)
  end

  def guess_is_valid?(guess)
    /^[1-6]{NUMBERS}$/.match(guess, NUMBERS)
  end
end
