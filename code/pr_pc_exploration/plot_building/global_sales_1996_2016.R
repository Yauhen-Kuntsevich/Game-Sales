# посмотрим на динамику мировых продаж
sales_by_years <- rp_pc_games %>%
  filter(!is.na(year_of_release)) %>%
  group_by(year_of_release) %>%
  summarize(sum_sales = sum(global_sales))

sales_by_years %>%
  ggplot(mapping = aes(x = year_of_release, y = sum_sales)) +
  geom_col(fill = "#BEBADA") +
  geom_text(aes(label = sum_sales), vjust = -0.5) +
  labs(title = "Мировые продажи игр",
       subtitle = "Жанр - RPG, платформа - PC",
       caption = "Dataset: Video Game Sales with Ratings") +
  xlab("Год релиза") + ylab("Продажи, $млн") +
  theme_minimal()