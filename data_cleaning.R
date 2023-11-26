library(tidyverse)
library(janitor)

# познакомимся со структурой наших данных
glimpse(game_sales_0)

# видим, что:
# 1. столбцы названы не в соответствии с конвенцией snake_case
# 2. формат данных в некоторых столбцах неправильный
# 3. в некоторых столбцах содержатся "" и NA значения
# 4. столбцы со строками могут содержать лишние пробелы
# 5. оценки критиков приведены по 100-балльной шкале, а оценки пользователей - по 10-балльной

# 1. приведем названия столбцов в соответствие с конвенцией
game_sales_1 <- clean_names(game_sales_0)

glimpse(game_sales_1)

# 2. заменим "" на NA для удобства фильтрации
game_sales_2 <- game_sales_1 %>% 
  mutate(across(everything(), ~ifelse(. == "", NA, .)))

glimpse(game_sales_2)

# 3. удалим из таблицы возможные лишние пробелы
game_sales_3 <- game_sales_2 %>% 
  mutate(across(everything(), ~trimws(.)))

glimpse(game_sales_3)

# 4. исправим формат данных
game_sales_4 <- game_sales_3 %>%
  mutate(year_of_release = paste0(year_of_release, "-01-01")) %>%
  mutate(year_of_release = as.Date(year_of_release)) %>% 
  mutate(across(c(na_sales, 
                  eu_sales, 
                  jp_sales, 
                  other_sales, 
                  global_sales,
                  critic_score,
                  user_score), ~as.numeric(.))) %>% 
  mutate(across(c(critic_count,
                  user_count), ~as.integer(.)))

glimpse(game_sales_4)

# 5. переведем оценки критиков в десятибалльную систему
game_sales_5 <- game_sales_4 %>% 
  mutate(critic_score = critic_score / 10)

glimpse(game_sales_5)

# далее проверим, есть ли в таблице дубликаты по всем столбцам
is_duplicated <- game_sales_5[duplicated(game_sales_5), ]
nrow(is_duplicated)

# полных дубликатов нет, проверим, сколько уникальных значений есть в столбце name
unique_names <- unique(game_sales_4$name)
length(unique_names)

# полных дубликатов нет, но уникальных игровых тайтлов в таблице 11563 против 16719 строк в таблице
# рассмотрим подробнее несколько случайных "дубликатов"
duplicates <- game_sales_5 %>% 
  group_by(name) %>% 
  filter(length(name) >= 2) %>% 
  arrange(desc(name))

head(duplicates, n = 20)

# из таблицы видно, что тайтлы повторяются, поскольку одна и та же игра выходила на разных платформах
# далее проверим, нет ли в столбце name отсутствующих значений:
game_sales_5 %>%
  filter(is.na(name))

# отсутствует название какой-то игры, выпущенной Acclaim Entertainment в 1993 г. 
# в 1993 г. Acclaim Entertainment выпустила для Sega Genesis три игры: 
# Mortal Combat, Spider-Man: The Animated Series, WWF Royal Rumble
# попробуем узнать, какой игры не хватает:
game_sales_5 %>%
  filter(publisher == "Acclaim Entertainment", year_of_release == "1993-01-01")

# можно также найти данные о продажах перечисленных игр и восстановить наши данные 
# но для нашего анализа не имеет большого смысла устанавливать, какие конкретно это игры, 
# поскольку мы собираемся анализировать RPG игры на PC 
# эти две строки можно просто удалить
game_sales_6 <- game_sales_5 %>%
  subset(!is.na(name))

glimpse(game_sales_6)

# далее нужно проверить, нет ли среди оценок критиков или пользователей значений 
# меньше нуля или больше десяти: это явные ошибки
game_sales_6 %>% 
  filter(critic_score < 0 | critic_score > 10 | user_score < 0 | user_score > 10)

# таких значений нет
# сохраним последний вариант очищенных данных в новую переменную, 
# а также сохраним очищенную таблицу в новый файл
game_sales_cleaned <- game_sales_6
write.csv(game_sales_cleaned, "game_sales_cleaned.csv")