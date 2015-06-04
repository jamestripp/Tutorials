# SIMPLE + SDbS simulation

I have created a little online simulations using the shiny server which can be found [here](http://jtripp.ddns.net/simulations/sdbs/). The simulation demonstrates how the weighting parameter changes predictions from being purely rank based to purely range based. The stimuli are taken from Brown et al (2008).

These are the files from the shiny server used to create the simulation. 

* 'sdbs_functions' contains the functions needed to implement the SIMPLE + DbS model.
* 'server.R' contains the server side code. The w parameter is taken from the ui and then used to return and plot the model predictions.
* 'ui.R' defines the interface which participants are faced with when the page is loaded.
* 'DESCRIPTION' is an information file used by the server.
