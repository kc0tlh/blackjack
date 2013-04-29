#BlackJack.rb

#This is a simple single player blackjack game.
#There are no chips or fancy play like splits, double downs, etc. 
#You play against an AI dealer and the highest hand under 21 wins.
#She will hit if her hand is under 17, and stand if it is equal to or over 17.
#Number cards are worth thier face value, J, Q, and K are worth 10, and Aces are 11.
#As in casino blackjack, Aces are soft (They become 1s if an 11 would cause you to bust).
#If taking another card causes your hand total to exceed 21, you 'bust' and lose immediately. 


class Game
	def initialize
		$player_1 = Players.new("Player 1")
		$dealer1 = Dealer.new
		play_hand
	end

	def play_hand
		$hand_count += 1
		puts "Hand: #{$hand_count}"
		wait
		$dealer1.shuffle
		$dealer1.deal

#Check if dealer or player wins instantly with blackjack (2 card 21 IE: Ace, King)
		has_blackjack?($dealer1, $player_1)

#See Dealer Card
		puts "Dealer is showing #{$dealer1.hand[0]}"
		wait
#See Your Cards
		puts "#{$player_1.name} has #{$player_1.hand.join(', ')} for a total hand value of #{card_total($player_1)}"
		wait
#until you dont want to anymore"
	#Hit
	#See cards and Total
		$player_1.player_action
		wait	

		$dealer1.dealer_action

		winner
		wait(2)
	end

#Shared Methods

	def random_card	
		$deck[rand(52)]
	end

	def has_blackjack?(dealer, player)
		if card_total(dealer) == 21 && card_total(player) == 21
			puts "Dealer and #{player.name} have Blackjack! This hand is a push."
			Game.new
		elsif card_total(dealer) == 21
			puts "Dealer wins with Blackjack!"
			Game.new
		elsif card_total(player) == 21
			"#{player.name} wins with Blackjack! Dealer had #{dealer.hand.join(', ')}"
			Game.new
		end
	end

	def hit(current_player)
		if current_player.card3 == nil
			until current_player.card3 != nil
			$discard << current_player.card3 = random_card end
			$deck = $deck - $discard
			current_player.hand << current_player.card3
		elsif current_player.card4 == nil
			until current_player.card4 != nil
			$discard << current_player.card4 = random_card end
			$deck = $deck - $discard
			current_player.hand << current_player.card4
		elsif current_player.card5 == nil
			until current_player.card5 != nil
			$discard << current_player.card5 = random_card end
			$deck = $deck - $discard
			current_player.hand << current_player.card5
		end
	end	

	def card_total(current_player)
		cards = current_player.hand.dup
		card_sum = parse_cards(cards)

		ace_index = cards.find_index {|c| c.match( /a{1,1}\D{1,1}/ )}

		if card_sum > 21 &&	ace_index != nil
			soft_ace(cards, ace_index)
		else
			return card_sum
		end 
	end

	def parse_cards(cards)
		card_sum = 0
		cards.each do |card|
			if card =~ /[jqk]/ then card = "10" elsif card =~ /a/ then card = "11" end
			card_sum = card_sum + card.to_i
		end
		return card_sum
	end

	def soft_ace(cards, ace_index)
		cards[ace_index] = "1"
		card_sum = parse_cards(cards)
		return card_sum
	end

	def wait(s=0.5)
		sleep(s)
	end

	def winner
		$player_1.hand_total = card_total($player_1)
		$dealer1.hand_total = card_total($dealer1)
		
		if $player_1.hand_total > 21
			puts "#{$player_1.name} busted with #{$player_1.hand_total}"
			puts "Dealer won with #{$dealer1.hand.join(', ')} for a total of #{$dealer1.hand_total}"
		elsif $dealer1.hand_total > 21
			puts "Dealer busted with #{$dealer1.hand_total}"
			puts "#{$player_1.name} won with #{$player_1.hand.join(', ')} for a total of #{$player_1.hand_total}"
		elsif $dealer1.hand_total > $player_1.hand_total && $dealer1.hand_total <= 21
			puts "Dealer wins with #{$dealer1.hand_total}"
		elsif $player_1.hand_total > $dealer1.hand_total && $player_1.hand_total <= 21
			puts "Player wins with #{$player_1.hand_total}"
		elsif $dealer1.hand_total == $player_1.hand_total
			puts "Player and Dealer Tie with #{$dealer1.hand_total}"
		end

		puts ''
		puts ''

		Game.new
	end	
end

class Dealer < Game
	attr_accessor :card1, :card2, :card3, :card4, :card5, :hand, :hand_total, :name, :deck, :discard
	
	def initialize
		@name = "dealer"
		@card1 = nil
		@card2 = nil
		@card3 = nil
		@card4 = nil
		@card5 = nil
		@hand = []
		@hand_total = 0
	end

	def shuffle
		$deck = ["1s", "2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "10s", "js", "qs", "ks", "as", "1h", "2h", "3h", "4h", "5h", "6h", "7h", "8h", "9h", "10h", "jh", "qh", "kh", "ah", "1d", "2d", "3d", "4d", "5d", "6d", "7d", "8d", "9d", "10d", "jd", "qd", "kd", "ad", "1c", "2c", "3c", "4c", "5c", "6c", "7c", "8c", "9c", "10c", "jc", "qc", "kc", "ac"].shuffle
		@deck = $deck
		$discard = []
		@discard = $discard
	end

	def deal
		until $player_1.card1 != nil
		$discard << $player_1.card1 = random_card end
		$deck = $deck - $discard
		$player_1.hand << $player_1.card1
		until $player_1.card2 != nil
		$discard << $player_1.card2 = random_card end
		$deck = $deck - $discard
		$player_1.hand << $player_1.card2

		until $dealer1.card1 != nil
		$discard << $dealer1.card1 = random_card end
		$deck = $deck - $discard
		$dealer1.hand << $dealer1.card1
		until $dealer1.card2 != nil
		$discard << $dealer1.card2 = random_card end
		$deck = $deck - $discard
		$dealer1.hand << $dealer1.card2
	end

	def dealer_action
		puts "Dealer has #{$dealer1.hand.join(', ')} for a total hand value of #{card_total($dealer1)}"
		until card_total($dealer1) >= 17
			hit($dealer1)
			puts "Dealer has #{$dealer1.hand.join(', ')} for a total hand value of #{card_total($dealer1)}"
			wait(1)				
		end

		$dealer1.hand_total = card_total($dealer1)

		if $dealer1.hand_total > 21
			winner
		end	
	end	
end


class Players < Game
	attr_accessor :card1, :card2, :card3, :card4, :card5, :hand, :hand_total, :name

	def initialize(name)
		@name = name
		@hand = []
		@hand_total = 0
	end

	def player_action
		player_decision = nil
		until player_decision == "stay" || player_decision == "s" || card_total($player_1) >= 21
			puts "Would you like to 'Hit' or 'Stay'?"
			player_decision = gets.chomp.downcase
			if ["hit", "h"].include? player_decision
				hit($player_1)
				puts "#{$player_1.name} now has #{$player_1.hand.join(', ')} for a total hand value of #{$player_1.card_total($player_1)}"
			elsif ["exit", "e", "quit", "q"].include? player_decision
				exit
			end
		end

		$player_1.hand_total = card_total($player_1)

		if $player_1.hand_total > 21
			winner
		end	
	end	
end

$hand_count = 0
game1 = Game.new