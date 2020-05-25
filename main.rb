require_relative 'lib/console_interface'
require_relative 'lib/game'
require 'colorize'


word = File.readlines("#{__dir__}/data/words.txt", chomp: true).sample

game = Game.new(word)
console_interface = ConsoleInterface.new(game)

until game.over?
  console_interface.print_game_status
  letter = console_interface.get_letter
  game.play!(letter)
end

console_interface.print_game_status
