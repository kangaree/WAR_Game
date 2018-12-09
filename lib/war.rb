require_relative "deck"
require_relative "player"

class War

    attr_reader :p1, :p2
    attr_accessor :reward_pile

    def initialize
        setup

        @reward_pile = []
    end

    def setup
        shuffled_deck = Deck.all_cards.shuffle

        p1_cards = []
        p2_cards = []

        shuffled_deck.count.times do |i|
            if i.even?
                # p1_cards.concat(shuffled_deck.shift(1))
                p1_cards << shuffled_deck.shift
            else
                # p2_cards.concat(shuffled_deck.shift(1))
                p2_cards << shuffled_deck.shift
            end
        end

        @p1 = Player.new("Muhammed")
        @p1.hand = p1_cards
        @p2 = Player.new("Hines")
        @p2.hand = p2_cards
    end

    def round
        puts "#{@p1.hand.first} vs. #{@p2.hand.first}"
        sleep(0.5)  
        
        case @p1.hand.first.war_value <=> @p2.hand.first.war_value
        when -1
            puts "#{@p2.name}'s #{p2.hand.first} wins this round!"
            @reward_pile.concat([@p1.hand.shift,@p2.hand.shift])

            @p2.hand.concat(@reward_pile)

            puts "#{@p1.name} has: #{@p1.hand}"
            puts "#{@p2.name} has: #{@p2.hand}"

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
            puts "#{@p1.name}'s #{@p1.hand.first} wins this round!"

            puts "#{@p1.name}: #{@p1.hand}"
            puts "#{@p2.name} #{@p2.hand}"
            
            @reward_pile.concat([@p1.hand.shift,@p2.hand.shift])
            @p1.hand.concat(@reward_pile)
            
            
            @reward_pile = []
        end          
    end

    def play
        puts "This is war!"
        puts "#{@p1.name}: #{@p1.hand}"
        puts "#{@p2.name}: #{@p2.hand}"
        
        until @p2.hand.empty? || @p1.hand.empty?
            round
            sleep(0.5)
        end
        
        puts "#{@p1.name} has: #{@p2.hand}"
        puts "#{@p2.name} has: #{@p1.hand}"
        
        if @p2.hand.empty?
            puts "P2 won the whole game!"
        else
            puts "P1 won the whole game!"
        end
    end

end

War.new.play