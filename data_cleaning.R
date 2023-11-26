library(tidyverse)
library(janitor)

glimpse(game_sales_0)

game_sales_1 <- clean_names(game_sales_0)

glimpse(game_sales_1)

game_sales_2 <- game_sales_1 %>% 
  mutate(across(everything(), ~ifelse(. == "", NA, .)))

glimpse(game_sales_2)