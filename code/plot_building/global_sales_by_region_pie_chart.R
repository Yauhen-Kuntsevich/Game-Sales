# посчитаем суммарные продажи по регионам за все годы
sales_by_region <- game_sales_cleaned %>%
  filter(genre == "Role-Playing" &
           platform == "PC") %>%
  select(na_sales,
         eu_sales,
         jp_sales,
         other_sales) %>%
  summarize(across(everything(), ~sum(.)))

head(sales_by_region)

# преобразуем широкую таблицу в длинную для удобства построения графика
sales_by_region_long <- gather(sales_by_region, 
                               key = "region", 
                               value = "sum_sales")
print(sales_by_region_long)

# продаж RPG игр на PC в Японии не было вообще

# построим круговую диаграмму
sales_by_region_long %>%
  filter(region != "jp_sales") %>% # отфильтруем японские продажи, поскольку они равны нулю
  ggplot(mapping = aes(x = "", 
                       y = sum_sales, 
                       fill = region)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(label = sum_sales), 
            position = position_stack(vjust = 0.5)) +
  labs(title = "Мировые продажи RPG игр на PC",
       subtitle = "Доли по регионам",
       caption = "Dataset: Video Game Sales with Ratings") +
  xlab("") + ylab("") +
  scale_fill_manual(values = c("eu_sales" = "#8F95D3",
                               "na_sales" = "#F4743B",
                               "other_sales" = "#DEDBD2"),
                    labels = c("eu_sales" = "Europe",
                               "na_sales" = "North America",
                               "other_sales" = "Other")) +
  theme_minimal() +
  theme(axis.text = element_blank())
