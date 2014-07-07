#1. Come up with requirements/specifications, which will determine the scope of your application. (usually the manager/client does this who are usually
# not technical)
#2. As programmers, we next need to think about application logic. Not code, but just the logical sequence of steps that need to be taken in order to complete the job
#3. Translation of these steps into code
#4. Run to test the code

# draw a board

# assign player1 to "X"
# assign computer to "O"

# loop until a winner or all squares are taken
#   player picks an empty square
#   checkwin
#   computer picks an empty square
#   checkwin

# if there is a winner 
#   show the winner
# else 
#   it's a tie
# end

def check_winner b, player
  winning_lines = [ [1,2,3],
                    [4,5,6],
                    [7,8,9],
                    [1,4,7], 
                    [2,5,8],
                    [3,6,9],
                    [1,5,9],
                    [3,5,7] ]

    winning_lines.each do |line|
        return "#{player}" if (b[line[0]] == "X" && b[line[1]] == "X" && b[line[2]] == "X")
        return "Computer" if (b[line[0]] == "O" && b[line[1]] == "O" && b[line[2]] == "O")
        end
        nil
end

def initialize_board
  b = {}
  (1..9).each {|x| b[x] = '_'}
  b
end

def draw_board(b)
  system 'cls'
  puts "_#{b[1]}_|_#{b[2]}_|_#{b[3]}_"
  puts "_#{b[4]}_|_#{b[5]}_|_#{b[6]}_"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end


def player_picks_square b
  empty_square = false

  while empty_square == false
    puts "Pick a square (1-9)"
    position = gets.chomp.to_i
    if b[position] == '_'
      b[position] = 'X'
      empty_square = true
    else
      puts "Sorry, square is not available. Please try again"
    end
  end
end

def empty_positions b
  #returns an array of keys which represent the available positions on the game board
  b.select {|k,v| v == '_'}.keys
  
end


def computer_picks_square b
  position = empty_positions(b).sample
  b[position] = 'O'
end


#main program
puts "Hello, welcome to Larry's Tic Tac Toe game!".center(80)
puts "Press [Enter]..."
gets
puts "What is your name?"
name = gets.chomp

keep_playing = true

while keep_playing == true

  board = initialize_board
  draw_board board

  begin
    player_picks_square board
    winner = check_winner board, name
    if winner
      draw_board board
      break
    end
    computer_picks_square board
    draw_board board
    winner = check_winner board, name
  end until winner || empty_positions(board).empty?
  #binding.pry
  if winner
    puts "#{winner} won!"
  else
    puts "It's a tie"
  end
  gets
  puts "Would you like to play again? (y/n)"
  answer = gets.chomp
  if answer != 'y'
    keep_playing = false
  else
    puts "Thank you for playing!"
  end
end