require_relative "deck"
require_relative "player"

class War

    attr_reader :p1, :p2
    attr_accessor :reward_pile

    def initialize
        setup
    end

    def setup
        bunny_intro

        print "How many cards? (max 52, divisible by 2):"
        count = gets.chomp.to_i

        shuffled_deck = Deck.all_cards.shuffle.take(count)

        p1_cards = []
        p2_cards = []

        (shuffled_deck.count / 2).times do
            p1_cards << shuffled_deck.shift
            p2_cards << shuffled_deck.shift
        end

        @p1 = Player.new("Alien")
        @p1.hand = p1_cards
        @p2 = Player.new("Predator")
        @p2.hand = p2_cards

        @reward_pile = []
    end

    def round

        return if @p1.hand.count == 0 || @p2.hand.count == 0
        
        puts "#{@p1.hand.first} vs. #{@p2.hand.first}"
        sleep(0.5)


        p1_card = @p1.hand.first.dup
        p2_card = @p2.hand.first.dup

        @reward_pile.concat(@p1.hand.shift(1)).concat(@p2.hand.shift(1))
        
        case p1_card.war_value <=> p2_card.war_value
        when -1
            puts "#{@p2.name}'s #{p2.hand.first} wins #{@reward_pile}!"

            @p2.hand.concat(@reward_pile)

            puts "#{@p1.name} has: #{@p1.hand}"
            puts "#{@p2.name} has: #{@p2.hand}"

            @reward_pile = []    
        when 0
            puts "WAR!!!"
            sleep(0.5)

            if @p1.hand.count == 1 || @p2.hand.count == 1
                @p1.hand.concat(@reward_pile).concat(@p2.hand.shift) if @p2.hand.count <= 2
                @p2.hand.concat(@reward_pile).concat(@p1.hand.shift) if @p1.hand.count <= 2
                @reward_pile = [] 
            else
                @reward_pile.concat(@p1.hand.shift(1))
                @reward_pile.concat(@p2.hand.shift(1))
            end
            
            round
        when 1
            puts "#{@p1.name}'s #{@p1.hand.first} wins #{@reward_pile}!"
            
            @p1.hand.concat(@reward_pile)

            puts "#{@p1.name} has: #{@p1.hand}"
            puts "#{@p2.name} has: #{@p2.hand}"
            
            @reward_pile = []
        end          
    end

    def play
        puts "#{@p1.name} has: #{@p1.hand}"
        puts "#{@p2.name} has: #{@p2.hand}"
        
        until @p1.hand.empty? || @p2.hand.empty?
            round
            sleep(0.5)
        end
        
        if @p1.hand.empty?
            puts "#{@p2.name} won the whole bloody affair!"
        else
            puts "#{@p1.name} won the whole bloody affair!"
        end
        
    end

    private

    def bunny_intro
        puts "WAR!
.......(\_/) 
......( '_') 
..../""""""""""""\======░ ▒▓▓█D 
/"""""""""""""""""""""""'\| 
\_@_@_@_@_@_/
War... War never changes.
' 
    end

end

if $PROGRAM_NAME == __FILE__
  War.new.play
end