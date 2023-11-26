# создадим датафрейм, в которых сохраним данные об играх 
# в жанре RPG на платформе PC
rp_pc_games <- game_sales_cleaned %>%
  filter(genre == "Role-Playing" &
           platform == "PC")

head(rp_pc_games)