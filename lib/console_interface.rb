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
      Word: #{print_word_status}

      #{print_figure}

      Misses (#{@game.errors_made}): #{errors}

      Attempts left: #{@game.errors_allowed}
    END

    if @game.won?
      puts "You Win!"
    elsif @game.lost?
      puts "You lose"
      puts "The Word Was '#{@game.word.capitalize}'"
    end
  end

  def print_word_status
    @game.letters_to_guess.map { |l| l.nil? ? "__" : l }.join(" ")
  end

  def get_letter
    print "Enter Your Letter: "
    letter = STDIN.gets[0].upcase
    letter
  end

  def errors
    @game.errors.join(", ")
  end
end
