
## --------------------------------------------- ##
## Understanding derivation of important days    ##
## (e.g., weekday, holiday, season)              ##
## --------------------------------------------- ##

## get week day
day_wkday <- daily_data %>% 
  dplyr::select(dteday, weekday) %>% 
  # dplyr::mutate(weekday_mine_str = weekdays(as.Date(dteday, "%y-%m-%d"))) %>% 
  dplyr::mutate(weekday_mine_str = lubridate::wday(as.Date(dteday, "%y-%m-%d"), label = TRUE, abbr = FALSE)) %>%
  dplyr::mutate(weekday_mine_num = lubridate::wday(as.Date(dteday, "%y-%m-%d")))

## get season
day_season <- daily_data %>% 
  dplyr::select(dteday, season) 
# dplyr::mutate(season_mine, lubridate::get)

day_split <- daily_data %>% 
  dplyr::select(dteday) %>% 
  dplyr::mutate(year_mine = lubridate::year(dteday)) %>% 
  dplyr::mutate(month_mine = lubridate::month(dteday)) %>% 
  dplyr::mutate(day_mine = lubridate::day(dteday)) 

## extract time
hr <- now()
hr2 <- hms("03:22:14")

lubridate::hour(hr2)
lubridate::minute(hr2)
lubridate::second(hr2)

## ------------------------------ ##
## Step 2: Examine your data.     ##
## ------------------------------ ##
daily_data$Date = as.Date(daily_data$dteday)

ggplot(daily_data, aes(Date, cnt)) + 
  geom_line() + 
  scale_x_date('month')  +
  ylab("Daily Bike Checkouts") + xlab("")

## Handling outliers
count_ts = ts(daily_data[, c('cnt')])
daily_data$clean_cnt = tsclean(count_ts)

ggplot() +
  geom_line(data = daily_data, aes(x = Date, y = clean_cnt)) + 
  ylab('Cleaned Bicycle Count')