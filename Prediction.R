setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Hourly_Predictions")

Prediction = read.csv(file="Sub12_60_40.csv", header=TRUE, sep=",")

setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Aggregated_Data/Hourly")

Original=read.csv(file="Sub_12.csv", header=TRUE, sep=",")

training_fraction=0.6
split_index=floor(training_fraction*length(Original$X))
lag=18

testing_starts=split_index+1+lag+1

Prediction$Dates=Original$Dates[testing_starts:length(Original$Dates)]
Prediction$Year=Original$Year[testing_starts:length(Original$Dates)]
Prediction$Month=Original$Month[testing_starts:length(Original$Dates)]
Prediction$Day=Original$Day[testing_starts:length(Original$Dates)]
Prediction$Temperature=Original$Temperature[testing_starts:length(Original$Dates)]
Prediction$Precipitation=Original$Precipitation[testing_starts:length(Original$Dates)]

names(Prediction) <- c("Prediction", "Actual","Dates","Year","Month", "Day", "Temperature", "Precipitation") 
setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Hourly_Predictions/Final")
write.csv(Prediction, file = "Sub12_Predictions_Final.csv")
