# various code associated with working theough Hadley's book

# packages instaleld as part of the book
install.packages('tidyverse')


# data packages to be used
install.packages(c("nycflights13", "gapminder", "Lahman"))


# other code
library('tidyverse')

# http://r4ds.had.co.nz/data-visualisation.html

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) # scatter plot of displacement vs highway mileage
#3.2.4.1
ggplot(data = mpg) # blank grey background
#3.2.4.2
dim(mtcars) # 32 rows, 11 columns
#3.2.4.3
# drv is the type of drivetrain such as 4wd
#3.2.4.4
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = hwy, y = cyl)) # scatter plot of highway mileage vs cylinders
#3.2.4.5
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = class, y = drv)) # scatter plot of class vs drive
# not really that useful 4/f are more common tha rear, but other displays could be better


ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

