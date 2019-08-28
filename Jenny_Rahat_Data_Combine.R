setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/")
#Read in the HMS output 
hms_output=read.csv("hms_TOoutputs.csv") 
setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Hourly_Data_Revised_4/")
#Read in the hourly temperature and precipitation data for each subbasin 
for (i in 0:28){
    df = read.csv(paste0("Subbasin_",i,".csv"), sep=",") 
    df=df[6577:192120,]
    colnames(df)=c("Dates","Year", "Month", "Day","Hours", "Precipitation","Temperature")
    relevant_hms_column=data.frame(hms_output[,paste0("X",i)])
    colnames(relevant_hms_column)=c("Outflow")
    df$Outflow=relevant_hms_column$Outflow[3:185546]
    setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Cut_Data/Precip_Temp/")
    filename=paste0("Subbasin_",i,".csv")
    write.csv(df, file = filename, row.names = FALSE)
    setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/Hourly_Data_Revised_4/")
}



