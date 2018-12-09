require_relative "deck"
require_relative "player"
require "colorize"

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

        print "Auto? (y/n):"
        yn = gets.chomp.downcase
        @auto = yn == "n" ? false : true
        
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
            puts "#{@p2.name}'s " + "#{p2_card}".green + " wins #{@reward_pile.reverse}!"
            if @p1.hand.empty?
                return
            end
            @p2.hand.concat(@reward_pile.reverse)
            render
            @reward_pile = []    
        when 0
            puts "WAR!!!"
            gets.chomp unless @auto
            @reward_pile << @p1.hand.shift
            @reward_pile << @p2.hand.shift
            puts "The stakes are now: #{reward_pile}"
            gets.chomp unless @auto
            if @p1.hand.empty? || @p2.hand.empty?
                return
            end
            render
            round
        when 1
            puts "#{@p1.name}'s " + "#{p1_card}".green+ " wins #{@reward_pile}!"
            if @p2.hand.empty?
                return
            end
            @p1.hand.concat(@reward_pile)
            render
            @reward_pile = []
        end
        
    end

    def play
        render
        
        until @p1.hand.empty? || @p2.hand.empty?
            round
            gets.chomp unless @auto
        end
        
        if @p1.hand.empty?
            puts "#{@p2.name} won the whole bloody affair!"
        else
            puts "#{@p1.name} won the whole bloody affair!"
        end

    end

    def render

        case p1.hand.first.war_power <=> p2.hand.first.war_power
        when -1
            print "#{@p1.name} #{@p1.hand.reverse[0...-1]} " + "#{@p1.hand.first}".red + " vs. " + "#{@p2.hand.first}".green + "#{@p2.hand[1..-1]} #{@p2.name}" 
        when 0
            print "#{@p1.name} #{@p1.hand.reverse[0...-1]} " + "#{@p1.hand.first}".red + " vs. " + "#{@p2.hand.first}".red + "#{@p2.hand[1..-1]} #{@p2.name}" 
        when 1
            print "#{@p1.name} #{@p1.hand.reverse[0...-1]} " + "#{@p1.hand.first}".green + " vs. " + "#{@p2.hand.first}".red + "#{@p2.hand[1..-1]} #{@p2.name}" 
        end
        puts      
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

# Sample Output
# Alien [7♥, 10♦, A♣, 7♦] 5♥ vs. 6♥[5♠, A♥, K♠, Q♠] Predator
# Predator's 6♥ wins [6♥, 5♥]!
# Alien [7♥, 10♦, A♣] 7♦ vs. 5♠[A♥, K♠, Q♠, 6♥, 5♥] Predator
# Alien's 7♦ wins [7♦, 5♠]!
# Alien [5♠, 7♦, 7♥, 10♦] A♣ vs. A♥[K♠, Q♠, 6♥, 5♥] Predator
# WAR!!!
# The stakes are now: [A♣, A♥, 10♦, K♠]
# Alien [5♠, 7♦] 7♥ vs. Q♠[6♥, 5♥] Predator
# Predator's Q♠ wins [Q♠, 7♥, K♠, 10♦, A♥, A♣]!
# Alien [5♠] 7♦ vs. 6♥[5♥, Q♠, 7♥, K♠, 10♦, A♥, A♣] Predator
# Alien's 7♦ wins [7♦, 6♥]!
# Alien [6♥, 7♦] 5♠ vs. 5♥[Q♠, 7♥, K♠, 10♦, A♥, A♣] Predator
# WAR!!!
# The stakes are now: [5♠, 5♥, 7♦, Q♠]
# Alien [] 6♥ vs. 7♥[K♠, 10♦, A♥, A♣] Predator
# Predator's 7♥ wins [7♥, 6♥, Q♠, 7♦, 5♥, 5♠]!
# Predator won the whole bloody affair!