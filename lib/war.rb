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

        p1_card = @p1.hand.shift
        p2_card = @p2.hand.shift

        @reward_pile.push(p1_card).push(p2_card)
        
        case p1_card.war_power <=> p2_card.war_power
        when -1
            puts "#{@p2.name}'s #{p2_card} wins #{@reward_pile}!"
            @p2.hand.concat(@reward_pile)
            render
            @reward_pile = []    
        when 0
            puts "WAR!!!"
            sleep(0.5)
            @reward_pile.concat(@p1.hand.shift(1))
            @reward_pile.concat(@p2.hand.shift(1))
            if @p1.hand.empty? || @p2.hand.empty?
                return
            end
            render
            round
        when 1
            puts "#{@p1.name}'s #{p1_card} wins #{@reward_pile}!"
            @p1.hand.concat(@reward_pile)
            render
            @reward_pile = []
        end
        
    end

    def play
        render
        
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

    def render
        puts "#{@p1.name} #{@p1.hand.reverse} vs. #{@p2.hand} #{@p2.name}"        
    end

    private

    def bunny_intro
        puts "WAR!
.......(\_/) 
......( '_') 
..../""""""""""""\======░ ▒▓▓█D 
/"""""""""""""""""""""""'\| 
\_@_@_@_@_@_/
War... '
        sleep(0.5)
        puts "War never changes."
        sleep(0.5)
    end

end

if $PROGRAM_NAME == __FILE__
  War.new.play
end