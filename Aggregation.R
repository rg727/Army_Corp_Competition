
##########################################################Aggregation of Values################
setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Cut_Data/Precip_Temp/")


sub12 = read.csv(file="Subbasin_28.csv", header=TRUE, sep=",")

sub12$sin_day=0
sub12$cos_day=0
sub12$Three_Day_Flow=0
sub12$Two_Week_Flow=0
sub12$Month_Flow=0
sub12$Season_Flow=0
sub12$Precip_Times_Temperature=0
sub12$Temperature_Times_Day=0
sub12$Precip_Times_Temperature_Times_Day=0




library(zoo)
sub12$sin_day=sin(sub12$Day)
sub12$cos_day=cos(sub12$Day)
sub12$Three_Day_Flow=rollsumr(sub12$Precipitation,k=72,fill=0)
sub12$Two_Week_Flow=rollsumr(sub12$Precipitation,k=168,fill=0)
sub12$Month_Flow=rollsumr(sub12$Precipitation,k=720,fill=0)


library(dplyr)
sub12$Hours=as.numeric(sub12$Hours)

#Total flow since the beginning of the water year 
for (i in 1:length(sub12$Year)){
  if (sub12$Month[i]==10|sub12$Month[i]==11|sub12$Month[i]==12){
    water_year_index=which(sub12$Year==sub12$Year[i] & sub12$Month==10 & sub12$Day==1 & sub12$Hours==1)
    sub12$Season_Flow[i]=sum(sub12$Precipitation[water_year_index]:sub12$Precipitation[i])
  }
  else{
    water_year_index=which(sub12$Year==sub12$Year[i]-1 & sub12$Month==10 & sub12$Day==1 & sub12$Hours==1)
    sub12$Season_Flow[i]=sum(sub12$Precipitation[water_year_index]:sub12$Precipitation[i])
  }
}

sub12$Precip_Times_Temperature=sub12$Precipitation*sub12$Temperature
sub12$Temperature_Times_Day=sub12$Temperature*sub12$sin_day
sub12$Precip_Times_Temperature_Times_Day=sub12$Precipitation*sub12$Temperature*sub12$sin_day

setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Aggregated_Data/Hourly/")

write.csv(sub12, file = "Sub_28.csv")




