require_relative 'spec_helper'
require_relative '../dependencies'

RSpec.describe TableData do
  let(:test) { 'test' }

  it 'shows correctly' do
    row = described_class.new(
        name: test,
        difficulty: test,
        attempts_total: test,
        attempts_used: test,
        hints_total: test,
        hints_used: test
    )
    expect(row.to_s).to eq(I18n.t(:stats,
                                  name: test,
                                  difficulty: test,
                                  attempts_total: test,
                                  attempts_used: test,
                                  hints_total: test,
                                  hints_used: test))
  end
end
