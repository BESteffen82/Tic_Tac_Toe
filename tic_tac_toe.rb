# frozen_string_literal: true

require 'pry-byebug'

WIN_COMBOS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
].freeze

class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class TicTocToe
  attr_reader :player_one, :player_two, :current_player, :game_board, :player_move

  def initialize
    @game_board = Board.new
    @player_one = player_one
    @move = 0
  end

  def play_game
    puts "Lets play Tic Tac Toe!\n\n"
    assign_player_one
    assign_player_two
    @game_board.show_board
    game_move
  end

  def assign_player_one
    puts 'Player One, what\'s your name?'
    @player_one = Player.new(gets.chomp, 'X')
    @current_player = player_one
    puts "\n"
  end

  def assign_player_two
    puts 'Player Two, what\'s your name?'
    @player_two = Player.new(gets.chomp, 'O')
  end
end

def game_move
  loop do
    puts "#{@current_player.name}, choose a space!"
    @player_move = gets.chomp.to_i
		unless @game_board.available_positions.include?(@player_move - 1)
			puts "Invalid Move. Please choose another number between 1 - 9"
		end
    if @game_board.available_positions.include?(@player_move - 1)
      @game_board.board[@player_move - 1] =
        @current_player.marker.to_s
    end
		@game_board.available_positions.delete(@player_move - 1)
		@move += 1    
    @game_board.show_board
		@move % 2 == 0? @current_player = @player_one: @current_player = @player_two				
	end		
end

class Board
  attr_accessor :available_positions, :board

  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @available_positions = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def show_board
    divider = '--+---+--'
    puts "\n#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts divider
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts divider
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}\n\n"
  end
end

new_game = TicTocToe.new
new_game.play_game
