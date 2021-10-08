
# load libraries ----------------------------------------------------------

library(pacman)
p_load(tidyverse, reactable, readxl, targets)

# Fancy visualizations, gene counts
# Box plots for some of the genes
# gene annotations
# integration with some other things
# read in data ------------------------------------------------------------


pathway_data <- "data/13024_2018_259_MOESM2_ESM.xlsx" %>% readxl::read_xlsx(sheet =1 , skip = 3) %>% janitor::clean_names()

# Perhaps have a selection of different data sets contrasts for each sheet


reactable(pathway_data)
