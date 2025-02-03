library(tidyverse)

sim_results <- read_csv('10000_sims.csv')

sim_results %>% count(`0`)

