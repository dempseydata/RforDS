# various code associated with working theough Hadley's book

# packages instaleld as part of the book
install.packages('tidyverse')


# data packages to be used
install.packages(c("nycflights13", "gapminder", "Lahman"))


# other code
library('tidyverse')

# book
# http://r4ds.had.co.nz/
# solutions to exercises
# https://jrnold.github.io/e4qf/index.html



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

# the above uses the default stat for the geom, in this case count

demo <- tribble(
    ~a,      ~b,
    "bar_1", 20,
    "bar_2", 30,
    "bar_3", 40
)
# this eaxmple though, uses the "identity", or the actual value supplied - like in an agregate table
# and uses that for the height of the bar
ggplot(data = demo) +
    geom_bar(mapping = aes(x = a, y = b), stat = "identity")

# this one uses the proportion, not the count (relative bar heights are obviously the same)
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# this one uses the stat_summary, whose default geom is geom_errorbar
ggplot(data = diamonds) + 
    stat_summary(
        mapping = aes(x = cut, y = depth),
        fun.ymin = min,
        fun.ymax = max,
        fun.y = median
    )

#3.7.1.1

# duh - use the default geom and call out for the specific stat
ggplot(data = diamonds) + 
    geom_pointrange(
        mapping = aes(x = cut, y = depth),
        stat = "summary",
        fun.ymin = min,
        fun.ymax = max,
        fun.y = median
    )

#3.7.1.2 geom_bar uses the number of records to determine bar height, geom_col uses the value in the data
#3.7.1.3 geom_bar - count, geom_col - identity, geom_hex, stat_binhex, geom_smooth - stat_smooth.... Generally, the default stat is named the with the same suffix as the geom

#3.7.1.4 geom_smooth plots y - predicted value, ymin - lower pointwise confidence interval around the mean, ymax - upper pointwise confidence interval around the mean, se - standard error
# the method paramter controls the method used for the predictions - lm, glm, gam, loess, rlm

#3.7.1.5
# the problem without group = 1, is that the proportions are calucated within each X variable, and thus each X has its own proportion of 1
# by using group = 1, the denominator ends up being the full data set, and thus the overall propotion is calcuate correctly
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group = 1))

# 3.8

# ugly chart!!!! color is for the borders, fill is, well, for the fill - also adds auto stacking
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, color = cut, fill = clarity))

# dodge is useful for the grouping of bars
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#3.8.1.1 - overplotting, use jitter
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_point(position = 'jitter')

#3.8.1.2 - geom_jitter offers both hieght and width iptions for controlling the amount of jitter being applied

#3.8.1.3 - geom_jitter is the same as geom_point, but with automatically added jitter noise
# geom_count on the otherhand, uses the number of points being overplotted, to alter the size of the dot used
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_count()

#3.8.1.4 - geom_boxplot - default position is DODGE, as it groups box plots side by side

ggplot(data = mpg, aes(x = class, y = hwy, color = drv)) +
    geom_boxplot()

# 3.9 

# coord_flip is a quick and easy way to switch x and y axis, easily managing overlapped x axis labels
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
    geom_boxplot() +
    coord_flip()

# 3.9.1.1
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = clarity)) +
    coord_polar() # wow, super simple way to create a polar chart from a bar chart. Still ugly though

#3.9.1.2 labs() is used for modifying all of the labels within a plot
#3.9.1.3 coord_map projects a portion of the earth, which is approximately spherical, onto a flat 2D plane using any projection defined by the mapproj package. Map projections do not, in general, preserve straight lines, so this requires considerable computation. coord_quickmap is a quick approximation that does preserve straight lines. It works best for smaller areas closer to the equator.
#3.9.1.4 as city MPG increases, so does hwy MPG in a roughly linear manner. hwy > city


# 3.10
<<<<<<< HEAD
# 4 Workflow basics
#4.4.1 mispelled variable name
#4.4.2 - filter goes in the data variable, and the carat filter has nothing to do with the mpg data
ggplot(filter(mpg, cyl == 8)) + 
    geom_point(mapping = aes(x = displ, y = hwy))
    
#4.4.3 - opt shift k = popup infor for all short cuts

#5 Data transformation

#    install.packages("nycflights13")
library(nycflights13)

flights
# tibbles are a dataframe tweaked to work better with tidyverse

# filter the data to 3rd january records only
filter(flights, month == 1, day == 3)

jan1 <- filter(flights, month == 1, day == 1)
dec25 <- filter(flights, month == 12, day == 25)

# == does not work as a logic test for floating point numbers, due to differences in absolute accuracy
1/49 * 49 == 1  # comes back as false
near(1/49 * 49, 1) # comes back as true

q3 <- filter(flights, month == 10 | month == 11 | month == 12)
# Yes, using >= 10 would have been better, this was just an example

q3 <- filter(flights, month %in% c(10,11,12))
# this is using the magrittr package to pipe successive commands together

#5.2.4.1 - etc etc. %in% is really useful!!
filter(flights, arr_delay > 120)
filter(flights, arr_delay > 120 & dest %in% c("IAH","HOU"))
filter(flights, arr_delay > 120 & dest %in% c("IAH","HOU") & carrier %in% c("UA","AA","DL"))


#5.2.4.2
filter(flights, between(dep_time, left=0000, right=0600))

#5.2.4.3 - 8255 have missing departure times
filter(flights, is.na(dep_time))
count(filter(flights, is.na(dep_time)))


#5.2.4.4 anything to the power of 0, is zero. 'cause "maths".

#5.3 arrange() - ordering function

#missing values are always sorted at the end, regardless of the desc/asc
arrange(flights, year, desc(month), desc(day))


#5.3.1.1 note - FALSE is sorted before TRUE in ASC order, since it is a 0!!!
arrange(flights, !is.na(dep_time))

#5.3.1.2
arrange(flights, desc(arr_delay))
arrange(flights, dep_time)

#5.3.1.3 If "fast" is the shortest flight time
(arrange(flights, desc(air_time)))
# nope, we have distance! so....
arrange(flights, desc(distance/air_time))
 # etc etc

#5.4 select()

# trim down the number of variables in the tibble
select(flights, year, month, day) # specific columns
select(flights, year:dep_delay)  # a range of columns that are next to each other
select(flights, -(year:dep_delay)) # or the opposite - all other columns except that range

select(flights, contains("delay")) # or just those colums that contain a certain string in their name

# rename() is much better to use to change a column name, as it does NOT dropp all the others (like select() does)

select(flights, hour, minute, everything()) # pull some colums to the front, and keep all others

#5.4.1.1
#5.4.1.2 - does not allow for a column to be selected more than once (no replication)
select(flights, hour, hour, minute, minute, hour)

#5.4.1.3 No difference in results, but it allos the passing of a vector / list, into the SELECT function
# so code can be made dynamic
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights,one_of(vars))

#5.4.1.4 contains is not case sensitive! unless you change the default to FALSE
select(flights, contains("TIME", ignore.case=FALSE))

#5.5 mutate()
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)

mutate(flights_sml,
       gain_per_hour = gain / hours,
       gain = arr_delay - dep_delay,
       hours = air_time / 60
)    # you can refer to columns you create in mutaute, but only AFTER the cration statement, not like the above

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)
# transmute ONLY provides the specified columns mutaate adds them to the end of the dataframe

# functions used in mutate must be vectorized

#5.5.2.1 - something like this - you get the idea
flights
transmute(flights,
        dep_time, dep_delay, arr_time, arr_delay, hour, minute,
        dep_after_midnight = (hour * 60) + minute,
        arr_after_midnight = dep_after_midnight + air_time
        )

#5.5.2.2 - bad match, obviously, since these intergers are actually HHMM, not proper incremental numbers
transmute(flights,
       arr_time, dep_time,
       delta = arr_time - dep_time)

#5.5.2.3 - only works when the result stays within 0-60 bounds, as per above issue
transmute(flights,
          dep_time, sched_dep_time, dep_delay,
          added_together = sched_dep_time + dep_delay,
          matching = (dep_time == added_together))

#5.5.2.4 = min_rank gives the delay from smallest to largest, so using DESC flips it to give the biggest delay first

x <- c(5, 1, 3, 2, 2, NA)
min_rank(x)
arrange(flights, desc(min_rank(dep_delay)))

#5.5.2.5 - due to 3 not being a multiple of 10, it does not overlap properly
# add the values of vesctor 1, in sequential order, to the values of vector 2, looping through vector 1 three and a third times
1:3 + 1:10

#5.6 summarize() - grouped summaries

# summarize works best with a group by, collapsing the data set to 1 record per group by combo, just like SQL
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
          
          
          
# piping with %>% FLOWS much better and soes not the creation of intermediate variable just to HOLD things
# ELSE, you can just embed function within function withing function, using far too manay levels of parenthesis
delays <- flights %>%   # first take the flights data
    group_by(dest) %>%   # then group it by desination, # then sumamrize it to add these vars by dest
    summarise( 
        count = n(),
        dist = mean(distance, na.rm = TRUE),
        delay = mean(arr_delay, na.rm = TRUE)
    ) %>%  
    filter(count > 20, dest != "HNL") 
# then filter destinations with more than 20 delays that are not honolulu - the na.rm removes NAs when calculating the mean, so as not to have the mean be NA (unknown, becuase it has an unknown value on at least one input record)

ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
    geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = FALSE)


not_cancelled <- flights %>% 
    filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
    group_by(year, month, day) %>% 
    summarise(mean = mean(dep_delay))

delays <- not_cancelled %>% 
    group_by(tailnum) %>% 
    summarise(
        delay = mean(arr_delay)
    )

delays <- not_cancelled %>% 
    group_by(tailnum) %>% 
    summarise(
        delay = mean(arr_delay, na.rm = TRUE),
        n = n()
    )

## ggplot2 does not use PIPE, bu ggvis, its replacement wILL use the pipe

delays %>% 
    filter(n > 25) %>% 
    ggplot(mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)



## baseball 
#install.packages("Lahman")
library(Lahman)
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
    group_by(playerID) %>% 
    summarise(
        ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
        ab = sum(AB, na.rm = TRUE)
    )

batters %>% 
    filter(ab > 100) %>% 
    ggplot(mapping = aes(x = ab, y = ba)) +
    geom_point() + 
    geom_smooth(se = FALSE)

# teams preferably pick their better batters, giving them more at=bats, and thus an opportunity to improve their batting-average - duh! Bias

# therefore, you need to be careful in how you look at some chunks of data as a result of thing like "selection" bias

#5.6.7.1 just before this link
# http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters

