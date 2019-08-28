setwd("C:/Users/Rohini/Desktop/Share-Price-Prediction-master/NN_Predictions/Final_Prediction_Files/")

Wet_Prediction = read.csv(file="Wet_Sub12_60_40_Predictions_Final.csv", header=TRUE, sep=",")
Dry_Prediction = read.csv(file="Dry_Sub12_60_40_Predictions_Final.csv", header=TRUE, sep=",")

Final_Prediction = rbind(Wet_Prediction,Dry_Prediction)

Final_Prediction_Sorted=Final_Prediction[order(Final_Prediction$Year,Final_Prediction$Month,Final_Prediction$Day),]

library(Metrics)
RMSE=rmse(Final_Prediction_Sorted$Prediction,Final_Prediction_Sorted$Actual)


library(hydroGOF)
Nash_Sutcliffe=NSE(Final_Prediction_Sorted$Prediction,Final_Prediction_Sorted$Actual)

#Plot hydrograph (actual and predicted)
plot(Final_Prediction_Sorted$Actual,type="l",xlab="Hour", ylab="Flow (cfs)",col="orange")
lines(Final_Prediction_Sorted$Prediction,type="l",xlab="Hour", ylab="Flow (cfs)",col="blue")
title("Sub-Basin 12 Prediction vs. Model Output")
legend("topright",legend=c("HMS", "NN"),col=c("orange", "blue"), lty=1,cex=0.7)


#Plot hydrograph on log scale 
plot(Final_Prediction_Sorted$Prediction,log="y",type="l",xlab="Hour", ylab="Flow (cfs)",col="blue")
lines(Final_Prediction_Sorted$Actual,type="l",xlab="Hour", ylab="Log Model Flow (cfs)",col="orange")
title("Sub-Basin 12 Prediction vs. Model Output (Log Scale)")
legend("topright",legend=c("HMS", "NN"),col=c("orange", "blue"), lty=1,cex=0.7)


sorted_model=sort(Final_Prediction_Sorted$Actual, decreasing=TRUE)
sorted_nn=sort(Final_Prediction_Sorted$Prediction, decreasing=TRUE)

#Step 2:Assign a rank, starting with 1 for the largest value
rank_model=rank(-sorted_model)
rank_nn=rank(-sorted_nn)

#Step 3: Calculate the exceedance probability 
P_model=numeric(length(Final_Prediction_Sorted$Actual))
P_nn=numeric(length(Final_Prediction_Sorted$Actual))

P_model=100*(rank_model/((length(P_model)+1)))
P_nn=100*(rank_nn/((length(P_model)+1)))


#Lots of zeros, doesn't work for a log plot 
for (i in 1:length(sorted_model)){
  if (sorted_model[i]==0){
    sorted_model[i]=0.1
  }
}

plot(P_model,sorted_model,log="y",type="l",xlab="Exceedance Probability", ylab="Flow (cfs)",lwd = 3,col="orange")
title("Flow Duration Curve")


lines(P_nn,sorted_nn,type="l",lwd = 3,col="blue")
legend("topright",legend=c("HMS", "NN"),col=c("orange", "blue"), lty=1)


#More metrics 

#%BiasRR

BiasRR=(sum(Final_Prediction_Sorted$Prediction-Final_Prediction_Sorted$Actual)/sum(Final_Prediction_Sorted$Actual))*100

#Vertical redistribution (percent bias in the FDC midsegment slope)

P_nn_70=sorted_nn[min(which(ceiling(P_nn)==70))]
P_nn_20=sorted_nn[min(which(ceiling(P_nn)==20))]  
P_model_70=min(sorted_model[which(abs(P_model-70)==min(abs(P_model-70)))])
P_model_20=min(sorted_model[which(abs(P_model-20)==min(abs(P_model-20)))])

BiasFMS=(((log(P_nn_70)-log(P_nn_20))-(log(P_model_70)-log(P_model_20)))/(log(P_model_70)-log(P_model_20)))*100

#High flow bias

BiasFHV=(sum(sorted_nn[(which((P_nn)<2))])-sum(sorted_model[(which((P_model)<2))]))/sum(sorted_model[(which((P_model)<2))])*100

#Low flow bias

######Time lag?###########
#Low flow bias

low_nn_10_70=sorted_nn[(which((P_nn)>70 &(P_nn)<100))]
low_model_10_70=sorted_model[(which((P_model)>70 &(P_model)<100))]
sum_nn=0
for (i in 1:length(low_nn_10_70)){
  if(low_nn_10_70[i]<=0.1){
    low_nn_10_70[i]=0.1
  } 
  x=log(low_nn_10_70[i])-log(min(low_nn_10_70))
  sum_nn=sum_nn+x
}

sum_model=0
for (i in 1:length(low_model_10_70)){
  x=log(low_model_10_70[i])-log(min(low_model_10_70))
  sum_model=sum_model+x
}
BFLV=((sum_nn-sum_model)/sum_model)*100


####Median Flow##########

BiasFMM=100*(log(median(Final_Prediction_Sorted$Prediction))-log(median(Final_Prediction_Sorted$Actual)))/log(median(Final_Prediction_Sorted$Actual))

#Doesn't work when median of the actual values is 1 




