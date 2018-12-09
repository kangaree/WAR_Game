class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
  end

  def return_cards(deck)
    hand.return_cards(deck)
    self.hand = nil
  end
end