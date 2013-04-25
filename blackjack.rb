#BlackJack.rb

#This is a simple single player blackjack game.
#There are no chips or fancy play like splits, double downs, etc. 
#You play against an AI dealer and the highest hand under 21 wins.
#She will hit if her hand is under 17, and stand if it is over 17.
#Number ards are worth thier face value, J, Q, and K are worth 10, and Aces are 11.
#As in casino blackjack, Aces are soft (They become 1s if an 11 would cause you to bust).
#If taking another card causes your hand total to exceed 21, you 'bust' and lose immediately. 


class Game
	attr_accessor :hand_count
	def initialize
		$player_1 = Players.new("Player 1")
		$dealer1 = Dealer.new
		play_hand
	end

	def play_hand
		$hand_count += 1
		puts "Hand: #{$hand_count}"
		$dealer1.shuffle
		$dealer1.deal
#See Dealer Card
		puts "Dealer is showing #{$dealer1.card1}"
#See Your Cards
		puts "#{$player_1.name} has #{$player_1.card1} and #{$player_1.card2}"
#until you dont want to anymore"
	#Hit
	#See cards and Total
		$player_1.player_action

		$dealer1.dealer_action

		winner

		Game.new
	end

#Shared Methods

	def random_card	
		$deck[rand(52)]
	end

	def hit(current_player)
		if current_player.card3 == nil && card_total(current_player) < 21
			until current_player.card3 != nil
			$discard << current_player.card3 = random_card end
			$deck = $deck - $discard
			current_player.hand << current_player.card3
		elsif current_player.card4 == nil && card_total(current_player) < 21
			until current_player.card4 != nil
			$discard << current_player.card4 = random_card end
			$deck = $deck - $discard
			current_player.hand << current_player.card4
		elsif current_player.card5 == nil && card_total(current_player) < 21
			until current_player.card5 != nil
			$discard << current_player.card5 = random_card end
			$deck = $deck - $discard
			current_player.hand << current_player.card5
		end
	end	

	def card_total(current_player)
		cards = []
		if current_player.card1 != nil
		cards << current_player.card1 end
		if current_player.card2 != nil
		cards << current_player.card2 end
		if current_player.card3 != nil
		cards << current_player.card3 end
		if current_player.card4 != nil
		cards << current_player.card4 end
		if current_player.card5 != nil
		cards << current_player.card5 end
		card_sum = 0
		cards.each do |card|
			if card.match(/[1,2,3,4,5,6,7,8,9,10]/) then card.gsub!(/\D/, "") elsif card =~ /[jqk]/ then card = "10" elsif card =~ /a/ then card = "11" end
			#puts card.to_i
			card_sum = card_sum + card.to_i
		end

		if card_sum > 21 && cards.join(",").include?('a')
			card_sum = card_sum - 10
		end
			return card_sum
	end

	def wait(s=1)
		sleep(s)
	end

	def winner
		if $player_1.hand_total > 21
			puts "#{$player_1.name} busted with #{card_total($player_1)}"
			puts "Dealer had #{$dealer1.hand.join(', ')} for a total of #{card_total($dealer1)}"
			Game.new
		elsif	
			$dealer1.hand_total > $player_1.hand_total && $dealer1.hand_total <= 21
			puts "Dealer wins with #{$dealer1.hand_total}"
		elsif $player_1.hand_total > $dealer1.hand_total && $player_1.hand_total <= 21
			puts "Player wins with #{$player_1.hand_total}"
		elsif $dealer1.hand_total == $player_1.hand_total
			puts "Player and Dealer Tie with #{$dealer1.hand_total}"
		end
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
			wait(2)				
		end
		$dealer1.hand_total = card_total($dealer1)
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
		until player_decision == "stay"
			puts "Would you like to 'hit' or 'stay'?"
			player_decision = gets.chomp
			if player_decision == "hit"
				hit($player_1)
				puts "#{$player_1.name} now has #{$player_1.hand.join(', ')} for a total hand value of #{$player_1.card_total($player_1)}"
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
