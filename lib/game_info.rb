# frozen_string_literal: true

module Info
  def welcome_info
    puts I18n.t(:greeting)
  end

  def menu_info
    puts I18n.t(:menu)
  end

  def name_info
    puts I18n.t(:choose_name)
  end

  def difficulty_info
    puts I18n.t(:choose_difficulty)
  end

  def rules_info
    puts I18n.t(:rules)
  end

  def no_stats_info
    puts I18n.t(:no_stats)
  end

  def table_info(table)
    puts table
  end

  def wrong_input_info(from)
    puts from
  end

  def start_info(attempts, hints)
    puts I18n.t(:game_process, attempts: attempts, hints: hints)
  end

  def hint_info(use_hint)
    puts use_hint
  end

  def wrong_process_info
    puts I18n.t(:wrong_process)
  end

  def check_info(check)
    puts check
  end

  def game_over_info
    puts I18n.t(:game_over)
  end

  def summary_info(secret)
    puts I18n.t(:secret, secret: secret)
  end

  def win_info
    puts I18n.t(:win)
  end

  def save_info
    print I18n.t(:save)
  end

  def lose_info
    puts I18n.t(:lose)
  end

  def goodbye_info
    puts I18n.t(:goodbye)
  end
end
