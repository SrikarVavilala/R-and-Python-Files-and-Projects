Introduction and Applied Ideas:

For this project, I inspect a meteorological data for four different cities in the United States. After reading them to dataframes, conversions are done to work with the data
in the format lists and matrices in order to apply mathematical functions to them and create tables with useful insights. I experimented with such data, as well as lists, 
using functions/ideas including the following:
- Aggregating the various dataframes into a list
- Transforming the data by utilizing the .apply() family, thereby generating my own functions to find mean, average highs and lows, etc.
- Constructing, manipulating columns of, and extracting values of lists
- Building user-friendly tables that showcase the end results of the applied functions (in accordance with the deliverables)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Project Overview:

One year's-worth of data, averaged and split between months, has been aggregated for each of four US cities. Each dataset shows features such as the average-high temperature,
the average low temperature, the average precipitation in inches, the number of days with precipitation, and the hours of sunshine for every month in a year for every city. 
Deliverables involve R tables as follows:
1. A table showing the annual averages of each observed metric for every city
2. A table showing by how much temperature fluctuates each month from min to max (in %)
3. A table showing the annual maximums of each observed metric for every city
4. A table showing the annual minimums of each observed metric for every city
5. A table showing in which months the annual maximums of each metric were observed in every city

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Final Thoughts and Overall Understanding:

Overall, I learned a lot about working with the .apply() family of functions, lists, and tables. lapply returns a list of the same length of some variable X, and each element
is the result of applying a function to the corresponding element of X. Similarly, sapply is a more "user-friendly" version and wrapper of lapply. It, by default, returns
a vector, a matrix, or an array (if simplify = "array" by applying the simplify2array() function). By understanding this family of functions, I am better able to understand
the intricacies of modifiying large amounts of data with fewer lines in a way that is more intrinsic to R, as opposed to languages like Python. Finally, I learned of ways to
better present the data in a more user-friendly format.
