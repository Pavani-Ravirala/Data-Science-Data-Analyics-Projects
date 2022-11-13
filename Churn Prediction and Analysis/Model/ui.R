library(shiny)
library(plotly)

# Define UI ----
shinyUI(fluidPage(
  titlePanel("Customer Churn Prediction"),
  tabsetPanel(
    tabPanel("Predict for Individual CUstomer",
             fluidRow(
               
               column(3, 
                      numericInput("mon_charge", h3("Monthly Charge"),
                                   min = 0, max = 100, value = 50),
                      numericInput("Total_charge", h3("Total Charge"),
                                   min = 0, max = 5000, value = 100),
                      numericInput("tenure", h3("Tenure"),
                                   min = 0, max = 100, value = 5),
                      selectInput("pymnt_mthd", h3("Payment Method"), 
                                  choices = c("Credit Card(Auto)","Electronic Cheque","Mailed Cheque","Bank Transfer(Auto)"), selected = 1),
                      selectInput("online_bkup", h3("Online Backup"), 
                                  choices = c("Yes","No","No Internet Service"), selected = 1),
                      selectInput("contract", h3("Contract"), 
                                  choices = c("Month to Month","One Year","Two Year"), selected = 1)
               ),
               column(2,
                      radioButtons("gender", h3("Gender"),
                                   choices = list("Male" = 1, "Female" = 0),
                                   selected = 1),
                      radioButtons("snr_ctzn", h3("Senior Citizen"),
                                   choices = list("Yes" = 1, "No" = 0),
                                   selected = 0),
                      radioButtons("partner", h3("Partner"),
                                   choices = list("Yes" = 1, "No" = 0),
                                   selected = 1),
                      radioButtons("dependents", h3("Dependents"),
                                   choices = list("Yes" = 1, "No" = 0),
                                   selected = 1),
                      radioButtons("billing", h3("Paperless Billing"),
                                   choices = list("Yes" = 1, "No" = 0),
                                   selected = 1),
                      
               ),
               column(4,
                      selectInput("Phone_Service", h3("Phone Service"), 
                                  choices = c("Yes","No","No phone service"), selected = 1),
                      selectInput("mul_lines", h3("Multiple Lines"), 
                                  choices = c("Yes","No","No phone service"), selected = 1),
                      selectInput("Int_srvc", h3("Internet Service"), 
                                  choices = c("No","DSL","Fiber Optic"), selected = 1),
                      selectInput("online_srvc", h3("Online Security"), 
                                  choices = c("Yes","No","No Internet Service"), selected = 1),
                      actionButton("click","Predict")
                      
               ),
               column(3,
                      selectInput("dvc_prtct", h3("Device Protection"), 
                                  choices = c("Yes","No","No Internet Service"), selected = 1),
                      selectInput("tec_sprt", h3("Tech Support"), 
                                  choices = c("Yes","No","No Internet Service"), selected = 1),
                      selectInput("strm_tv", h3("Streaming TV"), 
                                  choices = c("Yes","No","No Internet Service"), selected = 1),
                      selectInput("strm_mve", h3("Streaming Movies"), 
                                  choices = c("Yes","No","No Internet Service"), selected = 1),
                      
                      mainPanel(span(htmlOutput("predict"), style="font-size:50px;text-align:center"))
                      
               )
             ) ),
    tabPanel("Prediction for Multiple Customers",
  sidebarLayout(
 
    sidebarPanel
    (
      #Upload Button
      fileInput('file1', 'Choose DataSet for Prediction',accept = c(".csv")),
      radioButtons("choice", h3("Analysis Plot by"),
                   choices = list("Demographics" = 1, "Service Information" = 2, "Account Information" = 3),
                   selected = 1),
      checkboxInput(inputId = "show_plot",
                    label = strong("Analyse Based on Category"),
                    value = FALSE)
    ),    
    
  mainPanel(plotlyOutput("distPlot"),
            plotOutput("ana_plot")) 
    )
    )
  )
  )
)