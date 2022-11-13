#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(stringr)
library(plotly)
library(cowplot)
load("LogisticRegression.rda")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$predict <- renderText({
    df<-data.frame(matrix(ncol=23,nrow=1))
    x <- c("tenure","MonthlyCharges","TotalCharges","gender","SeniorCitizen","Partner","Dependents","PhoneService","MultipleLines","InternetService.xFiber.optic","InternetService.xNo","OnlineSecurity","OnlineBackup","DeviceProtection", "TechSupport","StreamingTV","StreamingMovies","Contract.xOne.year","Contract.xTwo.year","PaperlessBilling","PaymentMethod.xCredit.card..automatic.","PaymentMethod.xElectronic.check","PaymentMethod.xMailed.check")
    colnames(df) <- x
    df[is.na(df)] <- 0
    isolate({
      df$tenure<-input$tenure
      df$MonthlyCharges<-input$mon_charge
      df$TotalCharges<-input$Total_charge
      df$gender<-ifelse(input$gender==0,0,1)
      df$SeniorCitizen<-ifelse(input$snr_ctzn==0,0,1)
      df$Partner<-ifelse(input$partner==0,0,1)
      df$Dependents<-ifelse(input$dependents==0,0,1)
      df$PhoneService<-ifelse(input$Phone_Service=="No"||input$Phone_Service=="No phone service",0,1)
      df$MultipleLines<-ifelse(input$mul_lines=="No"||input$mul_lines=="No phone service",0,1)
      df$InternetService.xFiber.optic<-ifelse(input$Int_srvc=="Fiber Optic",1,0)
      df$InternetService.xNo<-ifelse(input$Int_srvc=="No",1,0)
      df$OnlineSecurity<-ifelse(input$online_srvc=="No"||input$online_srvc=="No Internet Service",0,1)
      df$OnlineBackup<-ifelse(input$online_bkup=="No"||input$online_bkup=="No Internet Service",0,1)
      df$DeviceProtection<-ifelse(input$dvc_prtct=="No"||input$dvc_prtct=="No Internet Service",0,1)
      df$TechSupport<-ifelse(input$tec_sprt=="No"||input$tec_sprt=="No Internet Service",0,1)
      df$StreamingTV<-ifelse(input$strm_tv=="No"||input$strm_tv=="No Internet Service",0,1)
      df$StreamingMovies<-ifelse(input$strm_mve=="No"||input$strm_mve=="No Internet Service",0,1)
      df$Contract.xOne.year<-ifelse(input$contract=="One Year",1,0)
      df$Contract.xTwo.year<-ifelse(input$contract=="Two Year",1,0)
      df$PaperlessBilling<-ifelse(input$billing==0,0,1)
      df$PaymentMethod.xCredit.card..automatic.<-ifelse(input$pymnt_mthd=="Credit Card(Auto)",1,0)
      df$PaymentMethod.xElectronic.check<-ifelse(input$pymnt_mthd=="Electronic Cheque",1,0)
      df$PaymentMethod.xMailed.check<-ifelse(input$pymnt_mthd=="Mailed Cheque",1,0)
    })
    prob <- predict(fit,newdata=df,type = "response")
    input$click
    req(input$click)
    pred <- ifelse(prob > 0.5, 1, 0)
    if(pred==1)
    {
      isolate(paste("<font color=\"#FF0000\">","Churn","</font>"))
    }
    else{
      isolate(paste("<font color=\"#00FF00\">","Retain","</font>"))
    }
  })

  data_file <- reactive({
    req(input$file1)
    inFile <- input$file1
    df1 <- read.csv(inFile$datapath)
    return(df1)
  })
  
  exst_colnames <- c("gender","SeniorCitizen","Partner","Dependents","tenure","PhoneService","MultipleLines","InternetService","OnlineSecurity","OnlineBackup",
                     "DeviceProtection","TechSupport","StreamingTV","StreamingMovies","Contract","PaperlessBilling","PaymentMethod","MonthlyCharges","TotalCharges")
  output$distPlot<-renderPlotly({
    df1 <- data_file()
    column_names <- colnames(df1)
    column_names <- gsub(" ","",column_names)
    df1 <- df1[,(tolower(names(df1)) %in% tolower(exst_colnames))]
    if(ncol(df1) == length(exst_colnames)){
      
      df1<-na.omit(df1)
      df1$SeniorCitizen <- as.factor(ifelse(df1$SeniorCitizen==1, 'YES', 'NO'))
      df1<- data.frame(lapply(df1, function(x) {
        gsub("No internet service", "No", x)}))
      
      df1<- data.frame(lapply(df1, function(x) {
        gsub("No phone service", "No", x)}))
      # Numerical columns to separate dataset
      num_columns <- c("tenure", "MonthlyCharges", "TotalCharges")
      df1[num_columns] <- sapply(df1[num_columns], as.numeric)
      # Normalization
      churn_int <- df1[,c("tenure", "MonthlyCharges", "TotalCharges")]
      #churn_int <- data.frame(scale(churn_int))
      # Remove customer ID and numerical values (dataset for only categorical variables)
      churn_cat <- df1[,-c(5,18,19)]
      
      #Creating Dummy Variables for categorical data
      dummy<- data.frame(sapply(churn_cat,function(x) data.frame(model.matrix(~x-1,data =churn_cat))[,-1]))
      
      #Combining the data
      churn_final <- cbind(churn_int,dummy)
      prob <- predict(fit,churn_final,type = "response")
      df1$Churn <- ifelse(prob>0.5,"Churn","No")
      ggplotly(ggplot(df1, aes(Churn)) + 
        geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn))) + 
        scale_y_continuous(labels=scales::percent) + theme_bw()+ xlab("Churn") + 
        ylab("Percent")+ ggtitle("Churn Percent")+ theme())
      
      
    }
    else{
    ggplotly(ggplot() + annotate("text",x=10,y=10,size=6,label = "The dataset doesn't match with the format. Please load a Valid Dataset") + theme_void())
    }
  })
  output$ana_plot<-renderPlot({
    
    df1 <- data_file()
    column_names <- colnames(df1)
    column_names <- gsub(" ","",column_names)
    df1 <- df1[,(tolower(names(df1)) %in% tolower(exst_colnames))]
    if(ncol(df1) == length(exst_colnames) && input$show_plot){
      
      df1<-na.omit(df1)
      df1$SeniorCitizen <- as.factor(ifelse(df1$SeniorCitizen==1, 'YES', 'NO'))
      df1<- data.frame(lapply(df1, function(x) {
        gsub("No internet service", "No", x)}))
      
      df1<- data.frame(lapply(df1, function(x) {
        gsub("No phone service", "No", x)}))
      # Numerical columns to separate dataset
      num_columns <- c("tenure", "MonthlyCharges", "TotalCharges")
      df1[num_columns] <- sapply(df1[num_columns], as.numeric)
      # Normalization
      churn_int <- df1[,c("tenure", "MonthlyCharges", "TotalCharges")]
      #churn_int <- data.frame(scale(churn_int))
      # Remove customer ID and numerical values (dataset for only categorical variables)
      churn_cat <- df1[,-c(5,18,19)]
      
      #Creating Dummy Variables for categorical data
      dummy<- data.frame(sapply(churn_cat,function(x) data.frame(model.matrix(~x-1,data =churn_cat))[,-1]))
      
      #Combining the data
      churn_final <- cbind(churn_int,dummy)
      prob <- predict(fit,churn_final,type = "response")
      df1$Churn <- ifelse(prob>0.5,"Churn","No")
      if(input$choice == 1){
        plot_grid(
          
          ggplot(df1, aes(x=gender,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)))+ scale_y_continuous(labels=scales::percent) + ylab("Percent") + theme_bw()+theme(legend.position="none"),
          
          ggplot(df1, aes(x=SeniorCitizen,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none"),
          
          ggplot(df1, aes(x=Partner,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw(),
          
          ggplot(df1, aes(x=Dependents,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none"))
      }
      else if(input$choice ==2 ){
        plot_grid(
          
          ggplot(df1, aes(x=PhoneService,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none"),
          
          ggplot(df1, aes(x=MultipleLines,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none") + 
            scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=InternetService,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none"), 
          
          ggplot(df1, aes(x=OnlineSecurity,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none")+scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=OnlineBackup,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none")+ scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=DeviceProtection,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none")+ scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=TechSupport,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw()+theme(legend.position="none") + scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          ggplot(df1, aes(x=StreamingMovies,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw() + theme(legend.position="none") + scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=StreamingTV,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw() + scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
        )
        
      }
      else if(input$choice == 3){
        plot_grid(
          ggplot(df1, aes(x=Contract,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw() + scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=PaperlessBilling,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw() + theme(legend.position="none") + scale_x_discrete(labels = function(x) str_wrap(x, width = 10)),
          
          ggplot(df1, aes(x=PaymentMethod,fill=Churn))+ geom_bar(aes(y = (..count..)/sum(..count..), fill = factor(Churn)),position = 'fill')+scale_y_continuous(labels=scales::percent) + ylab("Percent")+theme_bw() + theme(legend.position="none") + scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
        )
      }
    }
    
  })
  
})
