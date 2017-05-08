# PHASE 2
def convert_to_int(str)
  begin
    num = Integer(str)
  rescue ArgumentError
    puts "Cannot convert to Integer. Enter a valid number string."
  ensure
    num ||= nil
  end

  num
end



# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class InvalidFruit < StandardError
  def message
    puts "Not fruit or coffee"
  end
end
#
class Coffee < StandardError
  def message
    puts "Thanks for coffee!"
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise Coffee
  else
    raise InvalidFruit
    # puts "Invalid Fruit. Feed me coffee to retry."
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue Coffee => error
    error.message
    retry
  rescue InvalidFruit => error
    error.message
  end
end

# PHASE 4
class NotBesties < StandardError
  def message
    puts "You can't enter them as a BestFriend. You haven't known them long enough."
  end
end

class InvalidInput < StandardError
  def message
    puts "Name and/or fav_pastime is blank."
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

    raise NotBesties if @yrs_known < 5
    raise InvalidInput if @name.length <= 0 || @fav_pastime.length <= 0
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
