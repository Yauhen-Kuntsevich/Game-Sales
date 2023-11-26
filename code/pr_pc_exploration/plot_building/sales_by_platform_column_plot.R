# изучим мировые продажи игр на PC

sales_by_platform <- game_sales_cleaned %>%
  filter(!is.na(platform)) %>%
  group_by(platform) %>%
  summarize(sum_sales = sum(global_sales))

sales_by_platform %>%
  ggplot(mapping = aes(x = sum_sales, 
                       reorder(platform, sum_sales),
                       fill = platform,
                       alpha = 0.5)) +
  geom_col() +
  geom_text(aes(label = sum_sales)) +
  labs(title = "Платформа vs. Мировые Продажи",
       subtitle = "Суммарные продажи игр по платформам",
       caption = "Dataset: Video Game Sales with Rating") +
  xlab("Продажи, $млн") + ylab("Платформа") +
  theme_minimal() +
  theme(legend.position = "none")