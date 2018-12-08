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

# p1 = Player.new("Gary")
# p1.hand = ["test","testing","testing2"]
# p p1.hand => ["test", "testing", "testing2"]