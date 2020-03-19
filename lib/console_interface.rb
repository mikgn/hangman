class ConsoleInterface
  def initialize(game)
    @game = game
  end

  def print_figure
    figures = Dir["#{__dir__}/../data/figures/*.txt"]
              .map { |path| File.read(path) }
              .sort

    figures[@game.errors_made]
  end

  def print_game_status
    puts <<~END
      Слово: #{print_word_status}

      #{print_figure}

      Ошибки (#{@game.errors_made}): #{errors}

      У вас осталось ошибок: #{@game.errors_allowed}
    END

    if @game.won?
      puts "Вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли"
      puts "Загаданное слово #{@game.word}"
    end
  end

  def print_word_status
    @game.letters_to_guess.map { |l| l.nil? ? "__" : l }.join(" ")
  end

  def get_letter
    print "Введите букву: "
    letter = STDIN.gets[0].upcase
    letter
  end

  def errors
    @game.errors.join(", ")
  end
end
