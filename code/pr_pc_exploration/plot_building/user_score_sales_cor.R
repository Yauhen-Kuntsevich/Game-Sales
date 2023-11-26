rpg_games_user <- game_sales_cleaned %>%
  select(name, genre, platform, global_sales, user_score) %>%
  na.omit() %>%
  filter(genre == "Role-Playing" &
           platform == "PC")

rpg_games_user %>%
  ggplot(mapping = aes(x = user_score, 
                       y = global_sales)) +
  geom_jitter(color = "#80B1D3", size = 4, alpha = 0.5) +
  geom_smooth(color = "darkgray", se = FALSE) +
  labs(title = "Мировые Продажи vs. Оценки Пользователей",
       subtitle = "Корреляция между продажами и оценками пользователей",
       caption = "Dataset: Video Game Sales with Ratings") +
  xlab("Оценка пользователей") + ylab("Мировые продажи") +
  theme(legend.position = "none")