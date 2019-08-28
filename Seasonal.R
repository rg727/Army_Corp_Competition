
#Seasonal split of training data 


subbasin_numbers=c(5,7,10,11,12,16,17,18,19,20,23,24,25,26,27,28)
setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Aggregated_Data/Hourly")

for (i in subbasin_numbers){
  
  Subbasin = read.csv(paste0("Sub_",i,".csv"), sep=",")

#Dry season defined as May-October and wet season defined as October-May
  df_dry=Subbasin[which(Subbasin$Month==5|Subbasin$Month==6|Subbasin$Month==7|Subbasin$Month==8|Subbasin$Month==9|Subbasin$Month==10),]
  df_wet=Subbasin[which(Subbasin$Month==1|Subbasin$Month==2|Subbasin$Month==3|Subbasin$Month==4|Subbasin$Month==5|Subbasin$Month==11|Subbasin$Month==12),]

  setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Seasonal/Final")
  
  filename=paste0("Dry_Subbasin_",i,".csv")
  write.csv(df_dry, file = filename, row.names = FALSE)
  filename=paste0("Wet_Subbasin_",i,".csv")
  write.csv(df_wet, file = filename, row.names = FALSE)
  
  setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Aggregated_Data/Hourly")
}