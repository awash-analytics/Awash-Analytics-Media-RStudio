
defects_long <- user_loc_lalibela %>% 
  dplyr::filter(is.na(lon_user_location) | is.na(City)) %>% 
  print()

defects_city <- user_loc_lalibela %>% 
  dplyr::filter(is_empty(City)) %>% 
  print()

defects_long <- test2 %>% 
  dplyr::filter(is.na(b)) %>% 
  print()

defects_long <- test3 %>% 
  dplyr::filter(is.na(b)) %>% 
  print()
