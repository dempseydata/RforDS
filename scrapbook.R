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

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy), color = "Blue", shape = 20) # color in this case, it OUTSIDE of the AES, as it is not a column in the data


# 3.3.1.1 - points are not blue as color within ES is expecting a variable in that data, in this case, o constant string value of "blue"
# 3.3.1.2
summary(mpg) # gives a summary of data types within the data and their ranges
#3.3.1.3
# cont - cannot be in the SHAPE aesthetic
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = cyl, shape = year))
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = cty, y = hwy, shape = class))
# 3.3.1.4 - same var to multiple aes - a line of points
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = hwy, y = hwy))

# 3.3.1.5 # stroke is the thickness of the line (and thus size of the dot)
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = class), shape = 20, stroke = 1)

# 3.3.1.6 The X nnow becomes a TRUE FALSE as the "<5" is treated as a logic test, NOT a filter
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = (displ < 5) , y = hwy, color = class), shape = 20, stroke = 1)


ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_wrap(~ class, ncol = 2)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_grid(class ~ drv)

#3.5.1.1 - continuous gets treated as categorical! Should bucketize instead
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_grid(class ~ hwy)

#3.5.1.2 - The second plot pivots the x and y for the facet (not the plots), and drops 7 from the cylinder facet due to not points being plotted
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = drv, y = cyl)) +
    facet_grid(drv ~ cyl)

#3.5.1.3 - Basically the same as facet_wrap, with its limit set to the number of categories in the variable used in facet_grid
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ .)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(. ~ cyl)

#3.5.1.4 - advantage of facet - avoids issues with color blind people and easily separates outd the classess
# disadvantage is that each individual plot is much smaller than a single all classes plot
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_wrap(~ class, nrow = 2)

# 3.5.1.5 - facet_wrap has limits for the number of rows or columns to control the flow. facet_grid does not, as it is intended to put all values of variables on the axis

# 3.5.1.5 - facet_grid normally has the higher cardinality variable in the columns, due to the average display shape - landscape mode


ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy))

# uses a LOESS smoothing function
ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy, group = drv, color = drv))+ # group is repetitive here, due to "color" being used
    geom_point(mapping = aes(x = displ, y = hwy, color = drv))

# but there is some duplication in the code above, with the repeating og x, y and color

# this is cleaner below
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
    geom_smooth()+
    geom_point()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = class)) + 
    geom_smooth()

# data tweak for a separate layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = class)) + 
    geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) # se is the standard erro of the smoothed line

#3.6.1.1 geom_line, geom_boxplot, geom_freqpoly (histogram), geom_area

#3.6.1.2 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
    geom_point() + 
    geom_smooth(se = FALSE)

#3.6.1.3 - hides the legend for that particular layer only
#3.6.1.4 - "se" is the standard error area of the geom_smooth layer

#3.6.1.5 - both charts will be the same, as they have the same AES setting. the scecond just needed more typing to write

#3.6.1.6.a

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(aes(color = drv)) + 
    geom_smooth(aes(linetype = drv), se = FALSE)


# 3.7

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut))

http://r4ds.had.co.nz/data-visualisation.html

