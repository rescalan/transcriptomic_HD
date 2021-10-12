
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


# reactable ---------------------------------------------------------------

  pathway_data %>% 
    # mutate(adj_p = round(adj_p, 1))
    reactable(
      # ALL one page option (no scrolling or page swapping)
      pagination = TRUE,
      # compact for an overall smaller table width wise
      compact = TRUE,
      # borderless - TRUE or FALSE
      borderless = FALSE,
      # Stripes - TRUE or FALSE
      striped = FALSE,
      # fullWidth - either fit to width or not
      fullWidth = FALSE,
      # apply defaults
      # 100 px and align to center of column
      defaultColDef = colDef(
        align = "center",
        minWidth = 100
      ))



# color background --------------------------------------------------------

# Function by Greg Lin
# Notice bias here = a positive number. 
# Higher values give more widely spaced colors at the high end

make_color_pal <- function(colors, bias = 1) {
  get_color <- colorRamp(colors, bias = bias)
  function(x) rgb(get_color(x), maxColorValue = 255)
}

good_color <- make_color_pal(c("#ffffff", "#f2fbd2", "#c9ecb4", "#93d3ab", "#35b0ab"), bias = 2)
# good_color <- make_color_pal(c("#ffffff", "#f2fbd2", "#c9ecb4", "#93d3ab", "#35b0ab"), bias = 0.000001)
# Generate a vector of example numbers between 0 and 1
seq(0.1, 0.9, length.out = 12)

good_color(seq(0.1, 0.9, length.out = 12))
# display the colors
seq(0, 0.001, length.out = 12) %>% 
  good_color() %>% 
  scales::show_col()

# test --------------------------------------------------------------------

pathway_data %>% 
  # mutate(salary = round(salary, 1)) %>% 
  reactable(
    # ALL one page (no scrolling or page swapping)
    pagination = TRUE,
    # compact for an overall smaller table width wise
    compact = TRUE,
    # borderless - TRUE or FALSE
    borderless = FALSE,
    # Stripes - TRUE or FALSE
    striped = FALSE,
    # fullWidth - either fit to width or not
    fullWidth = FALSE,
    # apply defaults
    # 100 px and align to center of column
    defaultColDef = colDef(
      align = "center",
      minWidth = 100
    ),
    
    ##########################
    ### This section changed
    ##########################
    
    # This part allows us to apply specific things to each column
    columns = list(
      salary = colDef(
        name = "Adjusted p-value",
        style = function(value) {
          value
          normalized <- (value - min(pathway_data$adj_p)) / (max(pathway_data$adj_p) - min(pathway_data$adj_p))
          color <- good_color(normalized)
          list(background = color)
        }
      )
    )
    
  )
  
# test --------------------------------------------------------------------

data <- iris[10:29, ]
orange_pal <- function(x) rgb(colorRamp(c("#ffe4cc", "#ff9500"))(x), maxColorValue = 255)

reactable(
  data,
  columns = list(
    Sepal.Width = colDef(style = function(value) {
      normalized <- (value - min(data$Sepal.Width)) / (max(data$Sepal.Width) - min(data$Sepal.Width))
      color <- orange_pal(normalized)
      list(background = color)
    })
  )
)

# color scale function -------------------------------------------------------------

orange_pal <- function(x) rgb(colorRamp(c("#ffe4cc", "#ff9500"))(x), maxColorValue = 255)

orange_pal(4/4)


# color function 2 --------------------------------------------------------

make_color_pal <- function(colors, bias = 1) {
  get_color <- colorRamp(colors, bias = bias)
  function(x) rgb(get_color(x), maxColorValue = 255)
}

good_color <- make_color_pal(c("#ffffff", "#f2fbd2", "#c9ecb4", "#93d3ab", "#35b0ab"), bias = 2)

good_color(4)

# plot column -------------------------------------------------------------

min_log_adj_p <- min(pathway_data$log_adj_p)
max_log_adj_p <- max(pathway_data$log_adj_p)

pathway_data <- pathway_data %>% 
  dplyr::mutate(color = (log_adj_p - min(log_adj_p))/ (max(log_adj_p) - min(log_adj_p))) %>% 
  mutate(color2 = orange_pal(color))

pathway_data %>% 
  # slice(1:10) %>% 
  reactable(
    columns = list(
      log_adj_p = colDef(style = function(value) {
        # normalized <- (value - min(data$log_adj_p)) / (max(data$log_adj_p) - min(data$log_adj_p))
        color <- orange_pal(color)
        # color <- "#ffe4cc"
        list(background = color)
      })
    )
  )



