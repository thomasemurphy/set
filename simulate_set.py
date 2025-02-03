import itertools as it
import numpy as np
import pandas as pd

# set number of simulations
# 10,000 takes about 4 seconds
n_sims = 10000

# make a full deck
full_deck = np.array(list(it.product(
	range(3),
	repeat = 4
	)))

# ledger for the number of cards it took for the board to produce a set
board_length_record = []

for sim_count in range(n_sims):

	# randomly pick two cards from the deck
	rows_to_remove = np.random.choice(
		full_deck.shape[0],
		size = 2,
		replace = False
		)

	# put the cards on the board
	board = full_deck[rows_to_remove]

	# remove cards from deck
	deck = np.delete(
		full_deck,
		rows_to_remove,
		axis = 0
		)

	# no set on the board
	is_set = False

	# draw cards until set is found
	while is_set == False:

		# pick a card from the deck
		draw_index = np.random.choice(
			deck.shape[0],
			size = 1
			)

		# draw the card and remove from deck
		draw_card = deck[draw_index][0]
		deck = np.delete(deck, draw_index, axis = 0)

		# check for sets
		for i in range(len(board) - 1):
			card_1 = board[i]
			for j in range(i + 1, len(board)):
				card_2 = board[j]
				
				# initialize set_card with bogus values
				set_card = [3,3,3,3]

				# for each attribute...
				for k in range(4):
					if card_1[k] == card_2[k]:
						# all cards same in kth attribute
						set_card[k] = card_1[k]
					else:
						# all cards different in kth attribute
						set_card[k] = [x for x in [0,1,2] if x not in [card_1[k], card_2[k]]][0]
				
				# check if draw card is set card
				if np.array_equal(draw_card, set_card):
					is_set = True

		# add card to the board
		board = np.vstack((board, draw_card))

	# add this board size to the ledger
	board_length_record.append(len(board))

# save results
pd.DataFrame(board_length_record).to_csv(f'{n_sims}_sims.csv')