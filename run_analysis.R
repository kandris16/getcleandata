###preliminary settings
  require(plyr)
  require(dplyr)
  require(data.table)
  ##reading in the separate datasets and label/subject infos into R
  
    #training and test sets
      test=read.table(paste(getwd(),"/test/X_test.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
      train=read.table(paste(getwd(),"/train/X_train.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
      
    #subject labels set
      sub_test=read.table(paste(getwd(),"/test/subject_test.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
      sub_train=read.table(paste(getwd(),"/train/subject_train.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
  
    #activity labels set
      act_test=read.table(paste(getwd(),"/test/y_test.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
      act_train=read.table(paste(getwd(),"/train/y_train.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
  
    #features set
      feat=read.table(paste(getwd(),"/features.txt",sep=""),sep="",dec=".",header=FALSE,fill=TRUE)
  

###1.Merges the training and the test sets to create one data set called mData.
     
  mData=rbind(test,train)

  
#----------------------------------------------------------------------------------------------------------#
  
  
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  
  ##order feat by col V1
    feat=arrange(feat,V1)
  
  ##edit feature names
    #substitute '()'s and '-'s by ""
      tempFeat=lapply(as.list(feat[,2]),function(y){gsub("[[:punct:]]","",y)})
  
  ##find std in the TempFeat list (of characters)   
    placeStd=grep("std",tempFeat)
    findStd=vector(mode="integer",length(tempFeat))
    findStd[placeStd]=1
  
  
  ##find mean in the TempFeat list according to the found std-s 
    #change the word 'std' to 'mean' in the feature names
      meanFeat=lapply(tempFeat[placeStd],function(x) {gsub("std","mean",x)})
      meanFeat=lapply(meanFeat,function(x) {gsub("std","mean",x)})
    #find them in the tempFeat list
      placeMean=sapply(meanFeat,function (x) {grep(as.character(x),unlist(tempFeat),fixed=TRUE)[1]})
      findMean=vector(mode="integer",length(tempFeat))
      findMean[placeMean]=1
  
  ##get all the places of the relevant features
    findMeanStd=findMean+findStd  
  
  
  ##subset mData accordingly to get smData
      smData=mData[,findMeanStd==TRUE]
  
  
    
#----------------------------------------------------------------------------------------------------------#

    
  
### 3. Uses descriptive activity names to name the activities in the data set
  
  ##merge act_test and act_train to mAct & sub_test and sub_train to mSub (paying attention to the order - test first, train second)
    mAct=unname(unlist(rbind(act_test,act_train))); mSub=unname(unlist(rbind(sub_test,sub_train)))
  ##give descriptive labels to the activities 
    newLabels=c('Walking','Walking_Upstairs','Walking_Downstairs','Sitting','Standing','Laying')
    mAct=factor(mAct,levels=c("1","2","3","4","5","6"),labels=newLabels) 
  ##cbind smData with mAct and mSub
    smData=cbind(smData,mAct);smData=cbind(smData,mSub)
  

  
#----------------------------------------------------------------------------------------------------------#
  

### 4. Appropriately labels the data set with descriptive variable names. 
  
  ##change (mean and sd) feature names with descriptive labels
    #subset tempFeat according to the smData database (created at the end of section 2)
      finalFeat=tempFeat[findMeanStd==TRUE]
    #change the case of the first letter in the 'mean' and 'std' parts of feature names (e.g. tBodyAccmeanX -> tBodyAccMeanX) to support future text edition (e.g. splitting up by letter cases)
      finalFeat=as.list(gsub("mean","Mean",finalFeat)); finalFeat=as.list(gsub("std","Std",finalFeat))
    #correct the duplication in some variable names in finalFeat (e.g. fBodyBodyAccJerkMag-mean() )
      finalFeat=lapply(finalFeat,function(x) {if (grepl("BodyBody",x,fixed=TRUE)==TRUE) {sub("Body","",x)} else {x}})
  
    #check if there are duplicate variables (or variable names)
  if (length(finalFeat)==length(make.names(finalFeat, unique=TRUE))) {
  
  ##name the smData with the created descriptive labels
      colnames(smData)=c(unlist(finalFeat),"Activity","Subject")
      #colnames(mAct)="Activity"; colnames(mSub)="Subject"
      
  } else {
    
    print("Error in naming the variables in the dataset. Supposedly duplicate variable names. Please correct it!")
  
  }
  
    
  
#----------------------------------------------------------------------------------------------------------#
  
  
  
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    finalDataSet=tbl_df(ddply(smData,.(Activity,Subject),numcolwise(mean)))
    #head(finalDataSet)
  
  
  