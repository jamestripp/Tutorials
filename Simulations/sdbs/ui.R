# File:           ui.R
# Version:        1
# Last changed:   Thursday 4th June 2015
# Purpose:        Takes values of c and s, then passes to plotOutput
#		  in the server.R file.
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

library(shiny)

shinyUI(fluidPage(
  verticalLayout(
  titlePanel("Range effects: SIMPLE and DbS"),
      plotOutput("distPlot"),
    wellPanel(
sliderInput("c",
                  "Confusability:",
                  min = 0.01,
                  max = 6,
                  value = 1),
      sliderInput("s",
                  "Slope:",
                  min = 10,
                  max = 20,
                  value = 18),
      p('Above are parameters for the SIMPLE model of item distinctiveness. 
        Confusability represents how easily one item is confused with another.
        The relative spacing of items has the greatest effect when confusability is low.
        Slope represent the scale of the differences in discriminability of items.
        High value of slope accentuate differences in discriminability.'),
      p('The discriminability of the items are shown in the top panes of the right hand figure.
       Here we use the stimuli from Brown, et al (2008). The discriminability of the items 
      are entered into the relative rank DbS model. The predictions are shown in the bottom panes')
    )
    )
  )
)
