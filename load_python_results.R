library(tidyverse)
library(scales)

sim_results <- read_csv('100000_sims.csv') %>%
  rename(c(
    'sim_no' = '...1',
    'n' = '0'
    ))

sim_results %>% count(n)

pct_summary <- sim_results %>%
  group_by(n) %>%
  summarize(tot = n()) %>%
  ungroup() %>%
  mutate(pct = tot / nrow(sim_results)) %>%
  mutate(cumpct = cumsum(pct)) %>%
  print(n = 100)

ggplot(
  pct_summary,
  aes(
    x = n,
    y = pct
  )
) +
  geom_bar(
    stat = 'identity',
    color = "black",
    fill = NA,
    size = 0.2,
    width = 0.75
    ) +
  scale_x_continuous(
    name = 'number of cards onto the board to produce a set (from full deck)',
    breaks = seq(
      3,
      max(sim_results$n)
      )
  ) +
  scale_y_continuous(
    name = 'share of 100,000 simulations',
    limits = c(0, 1.1 * max(pct_summary))
    breaks = seq(0, 0.18, 0.03)
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.title.x = element_text(
      size = 10,
      color = '#333333',
      margin = margin(t = 10)
      ),
    axis.title.y = element_text(
      size = 10,
      color = '#333333',
      margin = margin(r = 10)
    ),
    axis.text = element_text(
      size = 9,
      color = '#444444'
      ),
    plot.margin = margin(10,10,2,10)
  )
