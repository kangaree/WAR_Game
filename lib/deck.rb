require "byebug"
require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    pile = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        pile << Card.new(suit, value)
      end
    end
    pile
  end

  def initialize(cards = Deck.all_cards)
      @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if n > self.count
    @cards.shift(n)
  end

  # Returns an array of cards to the bottom of the deck.
  def return(new_cards) #renamed it new_cards in case it throws an error?
    @cards.concat(new_cards)
  end

  def inspect
    @cards.join
  end

  def to_s
    @cards.join
  end

  def empty?
    @cards.empty?
  end

  def peek
    @cards.first
  end

end

# STEP ONE: Players are each dealt half the deck in an alternating pattern.

# 52 cards of four suits and thirteen values.

# [2♣, 3♣, 4♣, 5♣, 6♣, 7♣, 8♣, 9♣, 10♣, J♣, Q♣, K♣, A♣, 
# 2♦, 3♦, 4♦, 5♦, 6♦, 7♦, 8♦, 9♦, 10♦, J♦, Q♦, K♦, A♦, 
# 2♥, 3♥, 4♥, 5♥, 6♥, 7♥, 8♥, 9♥, 10♥, J♥, Q♥, K♥, A♥, 
# 2♠, 3♠,4♠, 5♠, 6♠, 7♠, 8♠, 9♠, 10♠, J♠, Q♠, K♠, A♠]
# p Deck.all_cards

# A shuffled array of cards is given
# e.g.,
# [4♦, J♦, 7♠, 10♣, A♦, 7♦, J♠, 4♥, 5♣, 3♦, 3♠, 3♣, J♣, A♣, 
# 7♥, 8♥, 10♦, 10♠, 6♦, 5♠, 9♣, Q♣, J♥, 2♠, K♥, 4♠, Q♠, 2♦, 
# Q♦, 8♠, 4♣, 6♥, 8♦, 7♣, 8♣, 3♥, K♣, K♠, Q♥, 6♠, 5♥,9♥, 2♣, 
# 10♥, A♥, 5♦, 6♣, 9♦, K♦, 2♥, 9♠, A♠]
# p Deck.all_cards.shuffle

# # The deck is split into halves.
# shuffled_deck = Deck.all_cards.shuffle
# puts "unsplit deck:#{shuffled_deck}"
# puts

# count = shuffled_deck.count # => nb: default is 26
# half_count = count / 2

# p1_deck_half, p2_deck_half = shuffled_deck.take(half_count), shuffled_deck.drop(half_count)
# puts "p1: #{p1_deck_half}" 
# puts
# puts "p2:#{p2_deck_half}"

# STEP TWO: Players each take their top card and lay it face UP.

# p rigged_deck1 = Deck.new([Card.new(:clubs, :ace), Card.new(:clubs, :three), 
# Card.new(:clubs, :four), Card.new(:clubs, :five), Card.new(:clubs, :six)])
# p rigged_deck2 = Deck.new([Card.new(:spades, :ace), Card.new(:spades, :king), Card.new(:spades, :queen), Card.new(:spades, :queen), Card.new(:spades, :queen)])
# puts

# shuffled_deck = Deck.all_cards.shuffle
# p1_deck_half = Deck.new(shuffled_deck.take(26))
# p2_deck_half = Deck.new(shuffled_deck.drop(26))

# # puts "p1: #{p1_deck_half}" 
# # puts "p2: #{p2_deck_half}"

# reward_pile = []

# def round
#   puts "#{p1_deck_half.peek}vs.#{p2_deck_half.peek}"  

#   case p1_deck_half.peek.war_value <=> p2_deck_half.peek.war_value
#   when -1
#     puts "#{p2_deck_half.peek} wins!"
#     puts
#     p2_deck_half.return([p1_deck_half.take(1), p2_deck_half.take(1)].concat(reward_pile))
#     reward_pile = []    
#   when 0
#     puts "WAR!!!"

#     reward_pile << p1_deck_half.take(2)
#     reward_pile << p2_deck_half.take(2)
    
#     round

#   when 1
#     puts "#{p1_deck_half.peek} wins!"
#     puts
#     p1_deck_half.return([p2_deck_half.take(1),p1_deck_half.take(1)].concat(reward_pile))
#     reward_pile = []
#   end  
# end

# until p1_deck_half.empty? || p2_deck_half.empty?
#   round
# end

# p rigged_deck1.empty?
# p rigged_deck2.empty?

# # p rigged_deck3 = Deck.new([])
# # p rigged_deck3.empty?
# # p rigged_deck2.empty?

# # STEP THREE: If the last drawn cards are different ranks, all the cards drawn in this round are awarded to the drawer of the higher ranked card.

# # STEP FOUR: If either player runs out of cards at any time, that player loses and the game ends.
