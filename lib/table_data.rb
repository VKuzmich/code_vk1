# frozen_string_literal: true

class TableData
  attr_accessor :name, :difficulty, :att_total, :att_used, :hints_total, :hints_used

  def initialize(name:,
                 difficulty:,
                 att_total:,
                 att_used:,
                 hints_total:,
                 hints_used:)
    @name = name
    @difficulty = difficulty
    @att_total = att_total
    @att_used = att_used
    @hints_total = hints_total
    @hints_used = hints_used
  end

  def to_s
    I18n.t(:stats,
           name: @name,
           difficulty: @difficulty,
           att_total: @att_total,
           att_used: @att_used,
           hints_total: @hints_total,
           hints_used: @hints_used)
  end
end
