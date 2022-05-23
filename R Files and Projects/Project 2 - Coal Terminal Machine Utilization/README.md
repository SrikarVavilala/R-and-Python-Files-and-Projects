Introduction and Applied Ideas:

For this project, I inspect a month's worth of data for heavy machines that are used at a coal terminal and format it in lists to understand the usage capacity of the
machines over time. This data is in Time-Series/Date-Time format, and I experimented with such data as well as lists, using functions/ideas including the following:
- Deriving a utilization column and rearranging columns within a dataframe
- Handling Date-Time data with POSIXct
- Constructing, manipulating columns of, and extracting values of lists
- Building a timeseries plot for all machines to visualize data utilization over standardized time

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Project Overview:

One month worth of data has been aggregated for all of the heavy machines at a coal terminal. This dataset shows what percentage of capacity for each machine
was idle (unused) in any given hour. Deliverables involve an R list with the following components:
- Character: Machine name
- Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
- Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
- Vector: All hours where utilisation is unknown (NA’s)
- Dataframe: For this machine
- Plot: For all machines

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Final Thoughts and Overall Understanding:

Overall, I learned a lot about working with Date-Time data and lists. The structure of a list is not too unlike a dataframe, with the added benefit of being simple to 
visualize. Further, Date-Time and the POSIXct standard utilization allows for a more real-world application of Data Science and Analytics, with the ability to sort, process,
and visualize data with intuitive metrics such as day and time.

