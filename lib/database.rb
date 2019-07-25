# frozen_string_literal: true

module Database
  SEED = 'seed.yaml'

  def load(path = SEED)
    YAML.load_file(path)
  end

  def save(summary, path = SEED)
    row = TableData.new(summary)
    if File.exist?(path)
      table = load(path)
      table << row
      File.write(path, table.to_yaml)
    else
      File.write(path, [row].to_yaml)
    end
  end
end
