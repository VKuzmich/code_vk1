# require 'spec_helper'
# require_relative '../dependencies'
#
#
# RSpec.describe GameStart do
#   let(:game_class) { Class.new { extend GameStart } }
#
#   describe '.check_numbers' do
#     let(:examples) { YAML.load_file('./spec/examples.yml') }
#
#     it 'returns a correct answer' do
#       examples.each do |example|
#         expect(game_class.check_numbers(example[0].chars, example[1].chars)).to eq(example[2])
#       end
#     end
#   end
#
#   describe '.hint' do
#     let(:secret_code) { '1234' }
#     let(:unused_hints) { secret_code.chars }
#
#     it 'is included in secret code' do
#       expect(secret_code).to include(game_class.hint(unused_hints))
#     end
#
#     it 'is shorter then before' do
#       old_length = unused_hints.length
#       game_class.hint(unused_hints)
#       expect(unused_hints.length).to be < old_length
#     end
#
#     it 'is unique' do
#       expect(unused_hints).not_to include(game_class.hint(unused_hints))
#     end
#   end
#
#   describe '.make_number' do
#     it 'is a number of 4 digits, each digit is in the range 1-6' do
#       secret_code = game_class.make_number
#       expect(secret_code).to match(/^[1-6]{4}$/)
#     end
#   end
#
#   describe '.calc_counts' do
#     it 'returns a number of attempts depends on difficulty' do
#       test_data = [
#           [:easy, 15],
#           [:medium, 10],
#           [:hell, 5]
#       ]
#
#       test_data.each do |test_case|
#         expect(game_class.calc_counts(test_case[0])[:attempts]).to eq(test_case[1])
#       end
#     end
#
#     it 'returns a number of hints depends on difficulty' do
#       test_data = [
#           [:easy, 3],
#           [:medium, 2],
#           [:hell, 1]
#       ]
#       test_data.each { |test_case| expect(game_class.calc_counts(test_case[0])[:hints]).to eq(test_case[1]) }
#     end
#   end
# end
