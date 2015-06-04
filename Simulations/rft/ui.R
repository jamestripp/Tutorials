# File:           ui.R
# Version:        1
# Last changed:   Thursday 4th June 2015
# Purpose:        Code defining interface. Ppt can edit w and 
#		  predictions are calculated by server.R then
#		  plotted using plotOutput function. 
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

library(shiny)

shinyUI(fluidPage(
  verticalLayout(
  titlePanel("Range effects: Range frequency theory"),
      plotOutput("distPlot"),
    wellPanel(
sliderInput("w",
                  "Weight range:",
                  min = 0,
                  max = 1,
                  value = 0.5),
      p('Here you can change the weighing of the range and rank position of an item by varying the value of w from 0 (Rank only) to  1 (Range only)')
    )
    )
  )
)
