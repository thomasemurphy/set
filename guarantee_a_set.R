library(tidyverse)

n_showing <- 6
n_cards_deck <- 81

# probability of setting in 3
running_total <- 1 / (n_cards_deck - 2)

for (n_showing_counter in 4:n_showing) {
  n_deck <- n_cards_deck
  n_outs <- choose(n_showing_counter, 2)
  running_total <- (
    running_total + 
      (
        (n_cards_deck - (n_showing_counter - 1)) /
          (n_cards_deck - (n_showing_counter - 2))
      ) *
      choose(n_showing, 2) *
      1 / (n_cards_deck - (n_showing_counter - 1))
  )
}

pct_set <- (
  1 / (n_cards_deck - 2) +
    (n_cards_deck - 3) / (n_cards_deck - 2) * choose(n_showing, 2) * 1 / (n_cards_deck - 3)
)

pct_set
