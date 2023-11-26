# изучим мировые продажи rpg игр

sales_by_genre <- game_sales_cleaned %>%
  filter(!is.na(genre)) %>%
  group_by(genre) %>%
  summarize(sum_sales = sum(global_sales))

sales_by_genre %>%
  ggplot(mapping = aes(x = sum_sales, 
                       y = reorder(genre, sum_sales),
                       fill = genre)) +
  geom_col() +
  geom_text(aes(label = sum_sales), hjust = 1.1, color = "black") +
  labs(title = "Жанры vs. Мировые Продажи",
       subtitle = "Мировые продажи игр по жанрам",
       caption = "Dataset: Video Game Sales with Rating") +
  xlab("Продажи, $млн") + ylab("Жанр") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "Set3")