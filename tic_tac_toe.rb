# frozen_string_literal: true

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

class TicTacToe
  attr_reader :player_one, :player_two, :current_player, :game_board, :player_move, :check_board, :current_player_win

  def initialize
    @game_board = Board.new
    @player_one = player_one
    @move = 0
    @check_board = check_board
  end

  def play_game
    puts "Welcome to Tic Tac Toe!\n\n"
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

  def check_winner
    @check_board = WIN_COMBOS.map do |line|
      line.map do |position|
        @game_board.board[position]
      end
    end
    @current_player_win = Array.new(3, @current_player.marker.to_s)
    if @check_board.include?(@current_player_win)
      puts "\n"
      puts "#{current_player.name} wins!! Play again!"
      puts "\n"
      new_game
    end
  end

  def new_game
    puts 'Play again?? (Y/N)'
    @new_game_answer = gets.downcase.chomp
    case @new_game_answer
    when 'y'
      puts "\n"
      @game_board.board = %w[1 2 3 4 5 6 7 8 9]
      @game_board.available_positions = [0, 1, 2, 3, 4, 5, 6, 7, 8]
      @move = 0
      play_game
    when 'n'
      puts 'Thanks for playing!'
      exit
    else
      puts 'Invalid answer. Respond with Y or N'
      new_game
    end
  end
end

def game_move
  loop do
    puts "#{@current_player.name}, choose a space!"
    @player_move = gets.chomp.to_i
    unless @game_board.available_positions.include?(@player_move - 1)
      puts 'Invalid Move. Please choose another number between 1 - 9'
      @move -= 1
    end
    if @game_board.available_positions.include?(@player_move - 1)
      @game_board.board[@player_move - 1] =
        @current_player.marker.to_s
    end
    @game_board.available_positions.delete(@player_move - 1)
    @move += 1
    @game_board.show_board
    check_winner
    @current_player = @move.even? ? @player_one : @player_two
    if @move >= 9
      puts 'Game is a draw!'
      new_game
    end
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

new_game = TicTacToe.new
new_game.play_game
