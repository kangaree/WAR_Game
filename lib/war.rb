require_relative "deck"
require_relative "player"
require "byebug"

class War

    attr_reader :p1, :p2
    attr_accessor :reward_pile

    def initialize
        setup

        @reward_pile = []
    end

    def setup
        # Delete the take of 10 at the end!
        shuffled_deck = Deck.all_cards.shuffle
        p1_cards = []
        p2_cards = []

        shuffled_deck.count.times do |i|
            i.even? ? p1_cards.concat(shuffled_deck.shift(1)) : p2_cards.concat(shuffled_deck.shift(1))
        end

        @p1 = Player.new("Gary")
        @p1.hand = p1_cards
        @p2 = Player.new("George")
        @p2.hand = p2_cards
    end

    def round
        puts "#{@p1.hand.first}vs. #{@p2.hand.first}"
        sleep(0.5)  
        
        case p1.hand.first.war_value <=> p2.hand.first.war_value
        when -1
            puts "P2's #{p2.hand.first} wins this round!"

            @p2.hand.concat([@p2.hand.shift, @p1.hand.shift]).concat(@reward_pile)

            puts "P1 is now: #{@p2.hand}"
            puts "P2 is now: #{@p1.hand}"

            @reward_pile = []    
        when 0
            puts "WAR!!!"
            sleep(0.5)

            if @p2.hand.count <= 2
                puts "Player 2 wins inside war"
                p1.hand = []
                return
            end

            if @p1.hand.count <= 2
                puts "Player 1 wins inside war"
                p2.hand = []
                return
            end

            @reward_pile.concat(@p1.hand.shift(2))
            @reward_pile.concat(@p2.hand.shift(2))
            
            round
        when 1
            puts "P1's #{@p1.hand.first} wins this round!"

            puts "P1: #{@p2.hand}"
            puts "P2: #{@p1.hand}"
            
            @p1.hand.concat([@p2.hand.shift, @p1.hand.shift]).concat(@reward_pile)
            
            puts "P1 is now: #{@p2.hand}"
            puts "P2 is now: #{@p1.hand}"
            
            @reward_pile = []
        end          
    end

    def play
        puts "This is war!"
        puts "P1: #{@p1.hand}"
        puts "P2: #{@p2.hand}"
        
        until @p2.hand.empty? || @p1.hand.empty?
            round
            sleep(0.5)
        end
        
        if @p2.hand.empty?
            puts "P2 won the whole game!"
        else
            puts "P1 won the whole game!"
        end
    end

end

War.new.play