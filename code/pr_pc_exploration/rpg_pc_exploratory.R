# посмотрим, информация по каким годам находится в датафрейме
years <- rp_pc_games %>%
  filter(!is.na(year_of_release)) %>%
  reframe(year = year(unique(year_of_release))) %>%
  arrange(year)

print(years)

# в таблице содержится информация об RPG играх на PC с 1996 по 2016 годы, за исключением 1997, 1999 и 2013

# посчитаем число игр в жанре RPG на платформе PC за весь период 1996-2016
num_rp_pc_games <- length(rp_pc_games$name)
print(num_rp_pc_games)

# 104

# посчитаем суммарные мировые продажи таких игр за весь период
sum_global_sales <- sum(rp_pc_games$global_sales)
print(sum_global_sales)

# $47.72 MM

# посчитаем среднее, медиану, среднеквадратичное отклонение и размах мировых продаж для таких игр
games_stats <- rp_pc_games %>%
  reframe(mean = mean(global_sales),
          median = median(global_sales),
          sd = sd(global_sales))

# отдельно посчитаем размах мировых продаж
range <- rp_pc_games %>%
  reframe(range = range(global_sales))

print(range)
print(games_stats)

# размах продаж очень значительный: от 0.01 млн до 6.29 млн. долларов
# половина RPG игр на PC заработали меньше $0.07 млн.
# продажи игр в среднем отклоняются от среднего на $1.03 млн.

# узнаем, какая RPG игра на PC имела наибольшие мировые продажи
rp_pc_games %>%
  filter(global_sales == max(global_sales))
# Wow :)

# топ-10:
top_10 <- rp_pc_games %>%
  arrange(desc(global_sales))

head(top_10, n = 10)