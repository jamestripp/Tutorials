# File:           server.ui 
# Version:        1
# Last changed:   Thursday 4th June 2015
# Purpose:        Plots predictions of sdbs
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

library(shiny)

source('sdbs_functions.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output[["distPlot"]] <- renderPlot({
    
    stimuli.positive <- c(17.2, 17.6, 18.1, 18.7, 19.5, 20.3, 21.4, 22.7, 24.3, 26.1, 28.4)
    discriminability.positive <- get.sdbs.discriminability(stimuli.positive, input$c, input$s)
    model.prediction.positive <- get.sdbs.prediction(discriminability.positive)
    
    stimuli.negative <- c(17.2, 19.5, 21.3, 22.9, 24.2, 25.3, 26.1, 26.9, 27.5, 28, 28.4)
    discriminability.negative <- get.sdbs.discriminability(stimuli.negative, input$c, input$s)
    model.prediction.negative <- get.sdbs.prediction(discriminability.negative)
    
    stimuli.unimodal <- c(17.2, 20, 21.5, 22.2, 22.6, 22.8, 23, 23.4, 24.1, 25.6, 28.4)
    discriminability.unimodal <- get.sdbs.discriminability(stimuli.unimodal, input$c, input$s)
    model.prediction.unimodal <- get.sdbs.prediction(discriminability.unimodal)
    
    stimuli.bimodal <- c(17.2, 17.4, 17.8, 18.5, 20, 22.8, 25.6, 27.1, 27.8, 28.2, 28.4)
    discriminability.bimodal <- get.sdbs.discriminability(stimuli.bimodal, input$c, input$s)
    model.prediction.bimodal <- get.sdbs.prediction(discriminability.bimodal)
    
    stimuli.low_range <- c(14.3, 17.1, 18.6, 20, 21.4, 22.8, 25.9, 26.8, 27.5, 28, 28.4)
    discriminability.low_range <- get.sdbs.discriminability(stimuli.low_range, input$c, input$s)
    model.prediction.low_range <- get.sdbs.prediction(discriminability.low_range)
    
    stimuli.high_range <- c(17.2, 17.6, 18.1, 18.8, 19.7, 22.8, 24.2, 25.6, 27.1, 28.5, 31.3)
    discriminability.high_range <- get.sdbs.discriminability(stimuli.high_range, input$c, input$s)
    model.prediction.high_range <- get.sdbs.prediction(discriminability.high_range)
    
    par(mfrow = c(2,6))
    p1 = plot(x = stimuli.positive, y = discriminability.positive, ylim = c(0, 1), main = 'Positive Skew', xlab = '', ylab = 'Discriminability', cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.positive, labels=rep('', 11))
    p2 = plot(x = stimuli.negative, y = discriminability.negative, ylim = c(0, 1), main = 'Negative Skew', xlab = '', ylab = '', cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.negative, labels=rep('', 11))
    p3 = plot(x = stimuli.unimodal, y = discriminability.unimodal, ylim = c(0, 1), main = 'Unimodal', xlab = '', ylab = '', cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.unimodal, labels=rep('', 11))
    p4 = plot(x = stimuli.bimodal, y = discriminability.bimodal, ylim = c(0, 1), main = 'Bimodal', xlab = '', ylab = '', cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.bimodal, labels=rep('', 11))
    p5 = plot(x = stimuli.low_range, y = discriminability.low_range, ylim = c(0, 1), main = 'Low Range', xlab = '', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.low_range, labels=rep('', 11))
    p6 = plot(x = stimuli.high_range, y = discriminability.high_range, ylim = c(0, 1), main = 'High Range', xlab = '', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.high_range, labels=rep('', 11))
    p7 = plot(x = stimuli.positive, y = model.prediction.positive, type = 'b', col='red', main = '', xlab = 'Wages', ylab = 'Response',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.positive, labels=rep('', 11))
    p8 = plot(x = stimuli.negative, y = model.prediction.negative, type = 'b', col = 'green', main = '', xlab = 'Wages', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.negative, labels=rep('', 11))
    p9 = plot(x = stimuli.unimodal, y = model.prediction.unimodal, type = 'b', col = 'blue', main = '', xlab = 'Wages', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.unimodal, labels=rep('', 11))
    p10 = plot(x = stimuli.bimodal, y = model.prediction.bimodal, type = 'b', col = 'black', main = '', xlab = 'Wages', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.bimodal, labels=rep('', 11))
    p11 = plot(x = stimuli.low_range, y = model.prediction.low_range, type = 'b', col = 'deepskyblue', main = '', xlab = 'Wages', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.low_range, labels=rep('', 11))
    p12 = plot(x = stimuli.high_range, y = model.prediction.high_range, type = 'b', col = 'orangered1', main = '', xlab = 'Wages', ylab = '',cex.lab=1.5, cex.main = 2)
    axis(1, at=stimuli.high_range, labels=rep('', 11))
    })

})
