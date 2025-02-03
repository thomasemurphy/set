library(tidyverse)

# make deck
full_deck <- list()
for (i in 0:2) {
  for (j in 0:2) {
    for (k in 0:2) {
      for (m in 0:2) {
        card <- list(c(i, j, k, m))
        full_deck <- append(full_deck, card)
      }
    }
  }
}

# dummy vector for use later
dvec <- c(0, 1, 2)

# vector of simulation results:
# number of cards on board to produce a set
n_cards_for_set <- c()

# simulate
n_sims <- 1000

for (sim_count in 1:n_sims) {
  
  # 2 cards on the board to start
  selected_indices <- sample(
    length(full_deck),
    2,
    replace = FALSE
  )
  
  # take the 2 cards out of the deck, put on board
  deck <- full_deck[-selected_indices]
  board <- full_deck[selected_indices]
  
  is_set <- FALSE
  
  while(is_set == FALSE) {
    
    draw_index <- sample(
      length(deck),
      1
    )
    
    deck <- deck[-draw_index]
    draw_card <- deck[draw_index][[1]]
    
    # check for sets
    for (i in 1:(length(board) - 1)){
      for (j in (i + 1):length(board)) {
        card_1 <- board[[i]]
        card_2 <- board[[j]]
        set_card <- c(3,3,3,3)
        for (k in 1:4) {
          if (card_1[k] == card_2[k]) {
            set_card[k] <- card_1[k]
          } else {
            cvec <- c(card_1[k], card_2[k])
            set_card[k] <- dvec[!(dvec %in% cvec)]
          }
        }
        if (prod(draw_card == set_card) == 1) {
          is_set <- TRUE
        }
      }
    }
    board <- append(board, list(draw_card))
  }
  
  n_cards_for_set <- append(
    n_cards_for_set,
    length(board)
  )
  if (length(board) == 3) {
    print(board)
  }
}

my_df <- data.frame(n_cards = n_cards_for_set)

my_count <- my_df %>% count(n_cards)

ggplot(
  my_count,
  aes(
    x = n_cards,
    y = n
    )
) +
  geom_bar(
    stat = 'identity'
  )
