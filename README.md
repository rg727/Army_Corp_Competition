# Army_Corp_Competition
Data and Processing Scripts for HMS



Hourly Predictions with Whole Dataset for Training

1)	Jenny_Rahat_Data_Combine.R- combines the precipitation and temperature data from Rahat with Jenny’s HMS output runs and produces “Subbasin_X.csv” in Cut_Data/Precip_Temp folder
2)	Aggregation.R-calculates the relevant interaction and aggregate variables and produces “Sub_X.csv” in Aggregated_Data/Hourly
3) Then run the csv through the NN or relevant model
4)	Prediction.R-Takes the predicted values and appends the correct date and actual value and creates a file "SubX_Predictions_Final.csv"
5)	Flow_Duration_Curve.R-Takes the final prediction csv and calculates metrics and corresponding visualizations 


Hourly Predictions with Dataset Split by Season


1)	Jenny_Rahat_Data_Combine.R- combines the precipitation and temperature data from Rahat with Jenny’s HMS output runs and produces “Subbasin_X.csv” in Cut_Data/Precip_Temp folder
2)	Aggregation.R-calculates the relevant interaction and aggregate variables and produces “Sub_X” in Aggregated_Data/Hourly
3)	Seasonal.R splits the training data up into a wet season and dry season depending on the month. It returns “Wet_Subbasin_X” and “Dry_Subbasin_X” 
4) Then run the csv through the NN or relevant model
5) Prediction_Seasonal.R- combines the predictions with the original file to get the corresponding dates and actual values. Produces an output such as "Wet_Sub12_60_40_Predictions_Final.csv" in NN_Predictions/Final_Prediction_Files/
6)	Merge Final Predictions.R – takes the Wet and Dry csv files for a specific subbasin and combines them, taking the best prediction for the months that overlap. This script also evaluates the metrics and makes visualizations 


