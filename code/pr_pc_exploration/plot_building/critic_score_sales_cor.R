# изучим связь между мировыми продажами игр и их критическими оценками:
rpg_games_cr <- game_sales_cleaned %>%
  select(name, genre, platform, global_sales, critic_score) %>%
  na.omit() %>%
  filter(genre == "Role-Playing" &
           platform == "PC")

rpg_games_cr %>%
  ggplot(mapping = aes(x = critic_score, 
                       y = global_sales)) +
  geom_jitter(color = "#80B1D3", size = 4, alpha = 0.5) +
  geom_smooth(color = "darkgray", se = FALSE) +
  labs(title = "Мировые Продажи vs. Оценки Критиков",
       subtitle = "Корреляция между продажами и оценками критиков",
       caption = "Dataset: Video Game Sales with Ratings") +
  xlab("Оценка критиков") + ylab("Мировые продажи") +
  theme_minimal()