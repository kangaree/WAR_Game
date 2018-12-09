require_relative "deck"
require "byebug"

class War

    attr_accessor :p1_deck_half, :p2_deck_half
    attr_accessor :reward_pile

    def initialize
        shuffled_deck = Deck.all_cards.shuffle

        # change to 26. Currently just takes 5

        @p1_deck_half = Deck.new(shuffled_deck.shift(5))
        @p2_deck_half = Deck.new(shuffled_deck.shift(5))
        @reward_pile = []
    end

    def round
        puts "#{p1_deck_half.peek} vs. #{p2_deck_half.peek}"
        sleep(1)  
        case p1_deck_half.peek.war_value <=> p2_deck_half.peek.war_value
        when -1

            puts "P2's #{p2_deck_half.peek} wins this round!"

            p2_deck_half.return(p1_deck_half.take(1) + p2_deck_half.take(1) + self.reward_pile)

            puts "P1 is now: #{p1_deck_half.inspect}"
            puts "P2 is now: #{p2_deck_half.inspect}"

            self.reward_pile = []    
        when 0
            puts "WAR!!!"

            if p1_deck_half.count <= 2
                puts "Player 2 wins inside war"
                self.p1_deck_half = Deck.new([]) # must use self with setter
                return
            end

            if p2_deck_half.count <= 2
                puts "Player 1 wins inside war"
                self.p2_deck_half = Deck.new([])
                return
            end

            self.reward_pile.concat(p1_deck_half.take(2))
            self.reward_pile.concat(p2_deck_half.take(2))
            
            round

        when 1
            puts "P1's #{p1_deck_half.peek} wins this round!"
            puts "P1: #{p1_deck_half.inspect}"
            puts "P2: #{p2_deck_half.inspect}"
            p1_deck_half.return(p1_deck_half.take(1) + p2_deck_half.take(1) + self.reward_pile)
            
            puts "P1 is now: #{p1_deck_half.inspect}"
            puts "P2 is now: #{p2_deck_half.inspect}"
            
            self.reward_pile = []
        end          
    end

    def play
        puts "Welcome!"
        puts "P1: #{p1_deck_half.inspect}"
        puts "P2: #{p2_deck_half.inspect}"
        
        until p1_deck_half.empty? || p2_deck_half.empty?
            round
            sleep(1)
        end
        
        if p1_deck_half.empty?
            puts "P2 won the whole game!"
        else
            puts "P1 won the whole game!"
        end
    end

end

War.new.play



# No Win War Condition
# Player 1: 10S JS KD 6C 6D 2S 7S AC 3S 8D 5C 5D 8H 
#           AD KH 2D 4S 7C 3H 3D 10C 4D KC 4H 6H 7D
# Player 2: 9H 4C QC 9S 10D QH 5H QS 10H 8C AH 8S JH
#          QD JD 2C KS 9D 3C 5S 6S 7H 9C AS JC 2H

# '''
#   _||======
# _|   |__
# \oooooo/'''