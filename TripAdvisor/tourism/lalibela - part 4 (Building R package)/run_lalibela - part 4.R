
## Step 1: load package, needed for building the package
library(devtools)
library(roxygen2)

## Step 2: Modify NAMESPACE file. That is, specify your main functions as shown below:
# exportPattern("^[[:alpha:]]+")
# export(load_lalibelaLib)
# export(get_10Reviews)
# export(get_allReviews)

## Step 3: Modify DESCRIPTION file

## Step 4: Run the next command
## - It should retunr <Loading lalibela>
devtools::load_all()

## Step 5: Create documentation files
roxygen2::roxygenise(package.dir = "./")

## STEP-6: Proceed with building the pkg
## -- Go to 'Build', then click 'Build & Reload'

## STEP-7: Check package using pgk::devtools.
## Note that this step doesn't work in RStudio interface
devtools::check()

## STEP-8: Build binary package
## -- Go to 'Build', then click 'More' -> 'Build Binary package'
# devtools::build(binary = TRUE, args = c('--preclean'))    ## other option

## STEP-9: For Windows user, .tar.gz folder should be created
## - source: https://github.com/chrisadolph/tile-simcf/wiki/Building-R-packages-for-PC,-Mac,-and-Linux-or-Unix
## STEP-9a: Go to the terminal and run the command below. This creates, .tar.gz folder for Windows user
## - In case, R command is not recognized by mac, do the ff:
##   1. Get the path for R.exe file by running this command in RStudio, > R.home()
##   2. Then, go to the terminal and paste the path using this command, > export PATH="/Library/Frameworks/R.framework/Resources:$PATH"
## > R CMD BUILD lalibela/



