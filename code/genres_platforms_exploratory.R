# посмотрим, какие уникальные платформы и жанры игр представлены в датасете

platforms <- unique(game_sales_cleaned$platform)
print(platforms)

genres <- unique(game_sales_cleaned$genre)
print(genres)
