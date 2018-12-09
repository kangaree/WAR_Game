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
  def return(cards) #renamed it new_cards in case it throws an error?
    @cards.concat(cards)
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