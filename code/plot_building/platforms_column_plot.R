# изучим место pc среди других платформ

games_by_platform <- game_sales_cleaned %>%
  filter(!is.na(platform)) %>%
  group_by(platform) %>%
  summarize(num_games = length(unique(name)))

games_by_platform %>%
  ggplot(mapping = aes(x = num_games, 
                       y = reorder(platform, num_games),
                       fill = platform,
                       alpha = 0.5)) +
  geom_col() +
  geom_text(aes(label = num_games), hjust = 0.3) +
  labs(title = "Платформы vs. Опубликованные Игры",
       subtitle = "Количество опубликованных игр по платформам",
       caption = "Dataset: Video Game Sales with Rating") +
  xlab("Количество игр") + ylab("Платформа") +
  theme_minimal() +
  theme(legend.position = "none")