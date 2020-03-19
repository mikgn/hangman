class Game
  def initialize(word)
    @word_letters = word.chars
    @user_guesses = []
  end

  TOTAL_ERRORS_ALLOWED = 7

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.size
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @word_letters.map { |l| @user_guesses.include?(normalize_letter(l)) ? l : nil }
  end

  def normalized_letters
    @word_letters.map { |l| normalize_letter(l) }
  end

  def play!(letter)
    l = normalize_letter(letter)
    @user_guesses << l unless @user_guesses.include?(l) && !over?
  end

  def normalize_letter(letter)
    if letter == "Ё"
      "Е"
    elsif letter == "Й"
      "И"
    else
      letter
    end
  end

  def over?
    won? || lost?
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def lost?
    errors_allowed.zero?
  end

  def word
    @word_letters.join
  end
end
