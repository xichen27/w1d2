def rock_paper_scissors
  options = Hash[2, "rock", 1, "scissors", 0, "paper"]
  computer_choice = options[rand(3)]

  puts "Choose rock paper scissors"
  player_choice = gets.chomp
  puts computer_choice
  
  diff = options.key(player_choice) - options.key(computer_choice)
  check_modules = diff % 3
  return "win" if check_modules == 1
  return "draw" if check_modules == 0
  return "lose" if check_modules == 2
end

def remix(array)
  result = []
  alcohol_array = array.transpose[0].shuffle!
  mixer_array = array.transpose[1].shuffle!
  (0..alcohol_array.count - 1).each do |n|
    result << [alcohol_array[n], mixer_array[n]]
  end
 result     
end

  # p remix([
  #   ["rum", "coke"],
  #   ["gin", "tonic"],
  #   ["scotch", "soda"]
  # ])
  
  
def num_greater_divisible
  i = 250
  while i % 7 != 0
    i += 1
  end
  i
end

def factors(num)
  factors_array = []
  (1..num/2).each do |n|
    factors_array << n if num % n == 0
  end
  factors_array
end

#p factors(20)

def bubble_sort(array)
  
  sorted = false
  until sorted
    (array.length - 1).times do # don't need this loop
      (0..array.count - 2).each do |j|
        if array[j] > array[j+1]
          array[j], array[j+1] = array[j+1], array[j]
          sorted = false
        else
          sorted = true
        end
      end
    end
  end
  array
end

#p bubble_sort([4, 2, 5, 1])

def substrings(str)
  result = []
  #str_array = str.split('')
  (0..str.length - 1).each do |i|
    (i..str.length - 1).each do |j|
      result << str[i..j] unless result.include?(str[i..j])
    end
  end
  result
end

#p substrings("dinasour")
    
def subwords(str)
  words = File.readlines("dictionary.txt").map {|w| w.chomp}
  result = []
  substrings(str).each do |word|
    result << word if words.include?(word) 
  end
  # substrings(str).select { |word| words.include?(word) }
  result
end

#p subwords("bate")

def super_print(str, options = {})
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false,
  }
  
  options = defaults.merge(options)
  
  str = str.upcase if options[:upcase] == true
  str = str.reverse if options[:reverse] == true
  str = str *  options[:times]
  
  str
end

#p super_print("Hello", :reverse => true, :upcase => true) 

def number_guessing_game
  target_number = rand(100) + 1
  guess_number = 0
  
  until guess_number == target_number
    puts "Guess a number"
    guess_number = gets.chomp.to_i
    puts "Too high" if guess_number > target_number
    puts "Too low" if guess_number < target_number
  end
  
  "Yay!! You got it"
end

class Student
  
  attr_accessor :first_name, :last_name, :courses
  
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
    @courses = []
  end
  
  def name
    @name = "#{@first_name} #{@last_name}"
  end
  
  def enroll(new_course)
    return "Time conflict" if has_conflict?(new_course)
    return if 
    courses << new_course
    new_course.students << self
  end
  
  def has_conflict?(new_course)
    self.courses.any? {|c| c.conflict_with?(new_course)}  
  end
  
  def course_load
    result = Hash.new(0)
    courses.each do |c|
      # result[c.department] += c.number_of_credits
      result.merge({c.department => c.number_of_credits})
    end
    result
  end
  
end

class Course
  
  attr_accessor :course_name, :department, :number_of_credits, 
                :students, :time
  
  def initialize(course_name, department, number_of_credits, time)
    @course_name = course_name
    @department = department
    @number_of_credits = number_of_credits
    @students = []
    @time = time
  end
  
  def add_student(student)
    enroll(self)
  end
  
  def conflict_with?(course2)
    self.time.each_key do |d|
      return true if self.time[d] == course2.time[d]
    end
    false 
  end
  
end
  
#puts student_a = Student.new("John", "Doe")
#puts course_a = Course.new("Computers 101", 1, 12)
#puts student_a.enroll(course_a)
#puts student_a.courses # => [<Course #43214132>]
#puts student_a.courses.first


class Board
  
  def initialize
    @arrangement = [[0, 0, 0],
                    [0, 0, 0],
                    [0, 0, 0]]
  end
  
  def won?
     horizontal_win || vertical_win || diagonal_win
  end
  
  def horizontal_win
    (0..2).any? do |n|
      @arrangement[n] == Array.new(3, 1) || 
      @arrangement[n] == Array.new(3, 2)
    end
  end
  
  def vertical_win
    vert_arrangement = @arrangement.transpose
    (0..2).any? do |n| 
      vert_arrangement[n] == Array.new(3, 1) || 
      vert_arrangement[n] == Array.new(3, 2)}
    end
  end
  
  def diagonal_win
    @arrangement == [[1, 0, 0], [0, 1, 0], [0, 0, 1]] ||
    @arrangement == [[2, 0, 0], [0, 2, 0], [0, 0, 2]] ||
    @arrangement == [[0, 0, 1], [0, 1, 0], [1, 0, 0]] ||
    @arrangement == [[0, 0, 2], [0, 2, 0], [2, 0, 0]]          
  end
  
  def winner
  end
  
  def empty?(pos)
    @arrangement[pos[0]][pos[1]] == 0
  end
  
  def place_mark(pos, mark)
    @arrangement[pos[0]][pos[1]] = mark
  end

end

class Game
  def initialize(player1, player2)
    @board = Board.new
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
  end
  
  def play
    until @board.win?
      @human.human_move
      until !board.empty?(@human.human_move)
        puts "Please pick an empty position."
        @human.move
      end
      
      place_mark(pos, 1)
      
      return "The winner is the human." if @board.win?
      
      @computer.move until !board.empty?(@computer.computer_move)
      
      place_mark(pos, 2)
      return "The winner is the computer." if @board.win?
    end
    
    "Game over! You are both losers."
  end
  
end

def HumanPlayer
  attr_reader :human_move
  
  def move
    puts "Choose a position to place the mark."
    @human_move = gets.chomp
  end

end

def ComputerPlayer
  attr_reader :computer_move
   
  def move
    return @computer_move = [rand(3),rand(3)] if self.last_move == false
    @computer_move = self.last_move
  end
  
  def last_move
    board_dup = @board
    0.upto(2) do |i|
      0.upto(2) do |j|
        return [i, j] if place_mark([i, j], 2).won?
        board_dup = @board
      end
    end
          
    false
  end


end

puts "Choose an empty position." if human_move[pos[0]][pos[1]] != 0

if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new
  p2 = ComputerPlayer.new
  game = Game.new(p1, p2)
  game.play
end
