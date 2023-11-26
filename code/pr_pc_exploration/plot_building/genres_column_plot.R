# изучим место rpg среди других жанров

games_by_genres <- game_sales_cleaned %>%
  filter(!is.na(genre)) %>%
  group_by(genre) %>%
  summarize(num_games = length(unique(name))) %>%
  arrange(num_games)

games_by_genres %>%
  ggplot(mapping = aes(x = num_games, 
                       y = reorder(genre, num_games), 
                       fill = genre)) +
  geom_col() +
  geom_text(aes(label = num_games), hjust = 1.1, size = 4, color = "black") +
  labs(title = "Жанры vs. Опубликованные Игры",
       subtitle = "Количество опубликованных игр по жанрам",
       caption = "Dataset: Video Game Sales with Rating") +
  xlab("Количество игр") + ylab("Жанр") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "Set3")
