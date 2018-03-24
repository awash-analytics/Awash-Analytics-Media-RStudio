
## Install lalibela package
# install.packages("package_path", repos = NULL, type = .Platform$pkgType)

## load lalibela package
library(lalibela)

## Run app
reviews_lalibela <- lalibela::get_allReviews(nbr_page = 2,
                                             site_gCode = "480193",
                                             site_dCode = "324957",
                                             site_name = "Rock_Hewn_Churches_of_Lalibela",
                                             site_geoLocation = "Lalibela_Amhara_Region"
                                             )



## ------------------------- ##
## Development area.         ##
## ------------------------- ##
## Testing without the package
# source("./lalibela - part 1 (Web scraping)/functions/load_library.R")
# source("./lalibela - part 1 (Web scraping)/functions/get_10Reviews.R")
# source("./lalibela - part 1 (Web scraping)/functions/get_allReviews_v2.R")
# 
# reviews_lalibela <- get_allReviews(nbr_page = 2,
#                                    site_gCode = "480193",
#                                    site_dCode = "324957",
#                                    site_name = "Rock_Hewn_Churches_of_Lalibela",
#                                    site_geoLocation = "Lalibela_Amhara_Region"
#                                    )
