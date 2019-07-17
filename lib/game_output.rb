# frozen_string_literal: true

module Output
  def welcome_output
    puts I18n.t(:greeting)
  end

  def menu_output
    puts I18n.t(:menu)
  end

  def name_output
    puts I18n.t(:choose_name)
  end

  def difficulty_output
    puts I18n.t(:choose_difficulty)
  end

  def rules_output
    puts I18n.t(:rules)
  end

  def no_stats_output
    puts I18n.t(:no_stats)
  end

  def table_output(table)
    puts table
  end

  def wrong_input_output(from)
    puts from
  end

  def start_output(attempts, hints)
    puts I18n.t(:game_process, attempts: attempts, hints: hints)
  end

  def hint_output(use_hint)
    puts use_hint
  end

  def wrong_process_output
    puts I18n.t(:wrong_process)
  end

  def check_output(check)
    puts check
  end

  def game_over_output
    puts I18n.t(:game_over)
  end

  def summary_output(secret)
    puts I18n.t(:secret, secret: secret)
  end

  def win_output
    puts I18n.t(:win)
  end

  def save_output
    print I18n.t(:save)
  end

  def lose_output
    puts I18n.t(:lose)
  end

  def goodbye_output
    puts I18n.t(:goodbye)
  end
end