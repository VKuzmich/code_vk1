# frozen_string_literal: true

module Validation
  def name_is_valid?(name)
    name.is_a?(String) && name.length.between?(3, 20)
  end

  def guess_is_valid?(guess)
    /^[1-6]{4}$/.match(guess, 4)
  end
end
