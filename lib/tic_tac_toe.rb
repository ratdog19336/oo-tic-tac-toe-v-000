require 'pry'
class TicTacToe
  def initialize
    @board = Array.new(9," ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    @index = user_input.to_i-1
  end

  def move(index, player="X")
    @board[index.to_i-1] = player
  end

  def position_taken?( index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(position)
    !position_taken?(position.to_i-1) && position != "invalid" && position.to_i > -1
  end

  def turn
    puts "Please input a number between 1 and 9"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      display_board
    else
      puts "invalid"
      turn
    end
  end

  def turn_count
    turn_count = @board.count("X") + @board.count("O")
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.find do |win_combination|
      if @board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X"
        return win_combination
      elsif @board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O"
        return win_combination
      else
        false
      end
    end
  end

  def full?
    @board.all?{|positions| positions == "X" || positions == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    full? && !won? || won?
  end

  def winner
    winning_variable = won?
    if winning_variable
      winning_index = winning_variable[0]
      return @board[winning_index]
    else
      nil
    end
  end

  def play
    until !over
      turn
    end
    if won?
      puts "Congratulations"
    else
      puts "Cats game!"
    end
  end
end
