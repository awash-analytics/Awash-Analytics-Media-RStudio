
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



