#BlackJack.rb

class Game

	def initialize
		how_many_players
	end

	def how_many_players
		until $number_of_players != nil && $number_of_players.to_i <= 2
			puts "How many players? (Enter a number <= 2)"
			$number_of_players = gets.chomp
		end
		self.create
	end

	def create
		if $number_of_players.to_i == 1
			$player_1 = Players.new("Player 1")
		else if $number_of_players.to_i == 2
			$player_1 = Players.new("Player 1")
			$player_2 = Players.new("Player 2")
		else if $number_of_players.to_i == nil
			self.how_many_players
		else
			puts "There has been an error creating players."	
		end
		end
		end
	end	
end


class Players
	attr_accessor :card1, :card2, :card3, :card4, :card5, :name

	def initialize(name)
		@name = name
	end

	def hit(current_player)
		if current_player.card3 == nil && card_total(current_player) < 22
			until current_player.card3 != nil
			$discard << current_player.card3 = random_card end
			$deck = $deck - $discard
		elsif current_player.card4 == nil && card_total(current_player) < 22
			until current_player.card4 != nil
			$discard << current_player.card4 = random_card end
			$deck = $deck - $discard
		elsif current_player.card5 == nil && card_total(current_player) < 22
			until current_player.card5 != nil
			$discard << current_player.card5 = random_card end
			$deck = $deck - $discard

		elsif current_player.card_total > 21
			puts "#{current_player} busted with #{current_player.card_total}"
		end
	end	

	def card_total(current_player)
		cards = []
		if current_player.card1 != nil
		cards << card1 = current_player.card1 end
		if current_player.card2 != nil
		cards << card2 = current_player.card2 end
		if current_player.card3 != nil
		cards << card3 = current_player.card3 end
		if current_player.card4 != nil
		cards << card4 = current_player.card4 end
		if current_player.card5 != nil
		cards << card5 = current_player.card5 end
		card_sum = 0
		cards.each do |card|
			if card.match(/[1,2,3,4,5,6,7,8,9,10]/) then card = card.gsub(/\D/, "") elsif card =~ /[jqk]/ then card = "10" elsif card =~ /a/ then card = "11" end
			#puts card.to_i
			card_sum = card_sum + card.to_i
		end
		return card_sum
	end

	def random_card
		random = rand(52)	
		$deck[random]
	end
end

class Dealer
	attr_accessor :card1, :card2, :card3, :card4, :card5, :name, :deck, :discard

	def initialize
		@name = "dealer"
		@card1 = nil
		@card2 = nil
		@card3 = nil
		@card4 = nil
		@card5 = nil
		$deck = ["1s", "2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "10s", "js", "qs", "ks", "as", "1h", "2h", "3h", "4h", "5h", "6h", "7h", "8h", "9h", "10h", "jh", "qh", "kh", "ah", "1d", "2d", "3d", "4d", "5d", "6d", "7d", "8d", "9d", "10d", "jd", "qd", "kd", "ad", "1c", "2c", "3c", "4c", "5c", "6c", "7c", "8c", "9c", "10c", "jc", "qc", "kc", "ac"]
		@deck = $deck
		$discard = []
		@discard = $discard

	end

	def random_card
		random = rand(52)	
		$deck[random]
	end

	def deal
		if $player_1 != nil
			until $player_1.card1 != nil
			$discard << $player_1.card1 = random_card end
			$deck = $deck - $discard
			until $player_1.card2 != nil
			$discard << $player_1.card2 = random_card end
			$deck = $deck - $discard
		end

		if $player_2 != nil
			until $player_2.card1 != nil
			$discard << $player_2.card1 = random_card end
			$deck = $deck - $discard
			until $player_2.card2 != nil
			$discard << $player_2.card2 = random_card end
			$deck = $deck - $discard
		end
		until $dealer1.card1 != nil
		$discard << $dealer1.card1 = random_card end
		$deck = $deck - $discard
		until $dealer1.card2 != nil
		$discard << $dealer1.card2 = random_card end
		$deck = $deck - $discard
	end
end

game1 = Game.new
$dealer1 = Dealer.new
$dealer1.deal
p $player_1.name
puts $player_1.card1
puts $player_1.card2
if $player_2 != nil then p $player_2.name 
puts $player_2.card1
puts $player_2.card2 end
p "Dealer"
puts $dealer1.card1
puts $dealer1.card2
puts "Discard"
p $discard
puts "Deck"
p $deck
puts "Card Total"
puts $player_1.card_total($player_1)