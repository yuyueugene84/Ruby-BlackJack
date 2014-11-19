#create deck
#shuffle deck, pop two cards to player, another two to dealer
#display cards, ask if ask if player wants to continue

#if player don't want to contunue, caculate total, decide winner, break
#if player continue, add one more card to player array, if sum > 21, kaboom, print you lose
#if player hit 21, print "blackjack, you win!"
#


require 'pry'

def get_new_card(deck, deck2)
  rand_num = rand(1..2)
  if rand_num == 1
    return deck.pop
  else
    return deck2.pop
  end
end

def preparedeck
  suits = ['Heart', 'Diamond', 'Spade', 'Club']
  cards = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
  deck = suits.product(cards)
  deck.shuffle!
end

def calculate_total(cards)
  sum = 0
  cards.each do |card|
    sum += card2value(card[1])
  end
  cards.select{|e| e[0] == "Ace"}.count.times do
    sum -= 10 if sum > 21
  end
  sum
end

def card2value(card)
  card_values = {'2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8, '9'=>9, '10'=>10, 'Jack'=>10, 'Queen'=>10, 'King'=>10, 'Ace'=>11}
  return card_values.fetch(card)
end

def check_win(dealer, player, name)
  player_sum = calculate_total(player)
  dealer_sum = calculate_total(dealer)
  puts "your card total is: #{player_sum}"
  puts "dealer card total is: #{dealer_sum}"
  if player_sum > dealer_sum
    puts "Congrats #{name}, you win, top job!"
  elsif player_sum <= dealer_sum
    puts "Sorry, you lose!"
  else
    puts "Tie, no one wins."
  end
end


begin
#-----------------Preprocessing-------------------------
    deck = preparedeck
    deck2 = preparedeck
    player_cards = []
    dealer_cards = []
    playing = true
#------------Main Program Starts Here-------------------

    puts "Welcome to Blackjack!"
    puts "Please enter your name:"

    user_name = gets.chomp

    2.times do
      player_cards << get_new_card(deck, deck2)
      dealer_cards << get_new_card(deck, deck2)
    end

    player_sum = calculate_total(player_cards)
    dealer_sum = calculate_total(dealer_cards)

    p "#{user_name}, your cards are: #{player_cards}"
    p "Dealer cards are: #{dealer_cards}"

    if player_sum == 21
      p "Congradulations #{user_name}! You hit BlackJack!"
      exit
    end

    while player_sum < 21 #the player's turn

      begin
        puts "#{user_name}, please enter one of the following choices: 1)Hit or 2)Stay"
        user_input = gets.chomp
      end while ![1,2].include?(user_input.to_i)

      if user_input.to_i == 2
        puts "#{user_name}, you have chosen to stay!"
        break
      end

      player_cards << get_new_card(deck, deck2)

      p "#{user_name}, you have: #{player_cards}"

      player_sum = calculate_total(player_cards)
      puts "Your total is: #{player_sum}"

      if player_sum > 21
        puts "KABOOM! #{user_name}, you went bust!"
        #exit
      elsif player_sum == 21
        puts "BLACKJACK!!! Congrats #{user_name}, you win!"
        #exit
        #break
      end

    end #end of player's turn

    if dealer_sum == 21 #the dealer's turn
      p "Sorry, looks like dealer hit BlackJack..."
      exit
    end

    while dealer_sum < 17
      dealer_cards << get_new_card(deck, deck2)
      p "The dealder's cards are: #{dealer_cards}"
      dealer_sum = calculate_total(dealer_cards)

      if dealer_sum > 21
        puts "Congrats, dealer just went bust, you win!"
        #exit
      elsif dealer_sum == 21
        puts "Sorry, looks like dealder hit BlackJack..."
        #exit
      end
    end #end of dealer's turn

    check_win(dealer_cards, player_cards, user_name)

    begin
      puts "Do you want to play again? (Y/N)"
      user_input = gets.chomp.downcase
      if user_input == 'y'
        break
      elsif user_input == 'n'
        playing == false
        exit
      end
      #break if palying == false
    end while !['y','n'].include?(user_input)

end while playing != false
exit
