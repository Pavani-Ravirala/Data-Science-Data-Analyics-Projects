# CUSTOMER CHURN ANALYSIS AND PREDICTION

<img src="https://kranthi.me/wp-content/uploads/2020/04/Telecom_Churn_Prediction-e1587281300645.jpg">
 

## Objective:
Customer Churn can be defined as Customers leaving the organization or discontinue taking services of an organization due to 
various reasons.Individualized customer retention is hard because most firms have an oversized number of clients and can't 
afford to devote much time to every of them. the prices would be too great, outweighing the extra revenue. 

However, if an organization could predict which customers are likely to go away prior to time, it could focus customer retention efforts 
only on these "high risk" clients. the final goal is to expand its coverage area and retrieve more customers loyalty. The core to achieve 
this market lies within the customer itself.
The Main Objective is to

•	Find the % of Churn Clients and clients that keep in with the dynamic services. 

•	Analyze the information in terms of different highlights to understand reasons for customer Churn 

•	Find a most suited machine learning model to predict Churn and non-churn customers.

# Clone the Project :

To clone the project the easy way is to install GIT DESKTOP <a href="https://desktop.github.com/" target="_blank">here</a> 
(download the installation file based on the OS) 

Once the Installation file is downloaded Double click on the file and Follow the instructions.
(i.e, either set up repository based on GitHub account or skip the step and provide name and email.)

<img src="https://user-images.githubusercontent.com/107501631/209439765-2bb450f1-fe4d-4107-a2a8-e73069b94f3e.png">

Once the above screen is reached, Click "Clone a repository from the internet"

<img src="https://user-images.githubusercontent.com/107501631/209439868-27ae39a9-82a5-4d32-867e-f9a48dc08fde.png">

In the next screen, select the URL Tab and enter URL and choose local file for repository to be cloned into as shown in image.

Finally click `clone` and the Repository would be cloned into local machine.

# Software and Library requirements to run the Project:

_**Software used to build models is R and IDE used is R studio.**_

As the Project is developed in R one must need R and R studio to run the project and below are the instructions to install the same.

•	Install R (Version 4.1.2 or above) <a href="https://cran.r-project.org/bin/windows/base/" target="_blank">from here</a>
(Above is the URL for Windows OS and for other OS please <a href="https://data-flair.training/blogs/how-to-install-r/" target="_blank">reach here</a>  for step-by-step process).

•	Once the file is downloaded double click the installation file and follow the instructions to complete the installation.

•	R studio – Install R Studio an IDE to code in R <a href="https://www.rstudio.com/products/rstudio/download/" target="_blank">from here</a> 
(choose based on Operating System).

•	Once the file is downloaded double click  the installation file and follow the instructions to complete the installation.
(For step-by-step process please visit  <a href="https://data-flair.training/blogs/how-to-install-r/" target="_blank">here</a>)

•	install.packages(`"_Package name_”`) is the command used to install the required libraries required for the project and below are the mentioned libraries needed for model to run successfully. Below are the packages required to run the project successfully

•	To install packages use above mentioned command with required package name in Console window of R Studio.

_`“ggplot2”` – This Package helps in creating beautiful plots and visualize the data in graphical format._

_`“cowplot”` – This is an addon to ggplot which provides different themes, functions to align and annotate plots._

_`“stringr”` – This package has functions that ease working with strings and helps in string manipulations._

_`“rpart”` – This Package helps in building classification and regression trees._

_`“partykit”` - This Package helps in visualizing and summarizing the classification models._

_`“pROC” `– This Package helps in producing the ROC curves which would help in analyze models._

_`“caret”` – This Package provides functionalities in train and test over 230 models. It also streamlines the process of creating models._

_`“glmnet”` - This Package enables us to perform regularization of models that are being fit for the betterment of Models._

_`"plotly"` - This Package helps user to create interactive plots._

_`"shiny"` - This Package enables us to create intercative apps using which visual analysis and predicting using models can be performed._

## Data set:

The Dataset used is Telco Churn Dataset by IBM which is Publically available and can be downloaded from <a href="https://community.ibm.com/accelerators/catalog/content/Customer-churn" target="_blank">here</a> 

Complete Description of Dataset is available <a href="https://community.ibm.com/community/user/businessanalytics/blogs/steven-macko/2019/07/11/telco-customer-churn-1113" target="_blank">here</a>

_Note: One can use the Dataset from the repository available_

## Prediction Using R Shiny App:

Post the Data Wrangling and EDA the models were trained and fit over the dataset. The 2 models trained are Logistic Regression and Decision Trees. Among both Models  built for the Current Data Logistic Regression is proven to be better and using the same the R Shiny App was built with which one can predict if an individual customer would churn or not based on given inputs.

On other hand it is also possible to determine the churn Percentage of the given dataset by uploading the .csv file.

### The Process to Run the application is as below:

Once the clone of whole repository is completed and Upon completion of installation of R, R studio and all the mentioned packages

•	from the MODEL folder open the Ui.R and Server.R files in R Studio.

<img src="https://user-images.githubusercontent.com/107501631/209439885-ec77f5de-2d1a-4eb6-b9b6-969b1d0a2206.png">

•	Click “Run App” at the top mid of the screen (which is marked in above image).

•	The First Tab is helpful to predict if the individual customer would churn or not.

•	To get result as `Churn`, please provide the inputs as suggested in `“Sample Input for Churn Result.Txt”` from Model folder and click Predict Button for Result.
(One can use any values the above is just to save time).

•	To get result as  `Retain`, please provide the inputs as suggested in `“Sample Input for Retain.txt”` from Model folder and click Predict Button for Result.
(One can use any values the above is just to save time).

•	The Second Tab `“Prediction for Multiple Customers"` is helpful to predict the Total Churn Percentage of given set of customers.

•	To Load the Multiple Customers data, please click `Browse` button and choose “Churn Data” from Model folder.

•	Also, it would provide analysis results based on different categories like Demographics, Account Information, Service Information of Customers.

•	One can wish to Visualize or not to visualize the Analysis plots by simply `check or uncheck` the check box provided.

<img src="https://user-images.githubusercontent.com/107501631/209439897-bf478141-5b8e-48ed-9a23-5a1ac4df92d6.png">
 
•	To Check above Improper text scenario, please load the `“Improper Dataset.csv”` from the Model folder by using browse option
 
•	If the dataset provided is of improper format, an user friendly message would be displayed asking the user to provide a valid Dataset.

 <img src="https://user-images.githubusercontent.com/107501631/209439882-6b2d85f2-3a7d-45cd-9cf9-a57e1d843d29.png"> 

## Model Building and Model Summary:

In the Current context two of the many available models have been tried to fit i.e., logistic Regression and Decision Tree where below is the Summary of both models. 

<img src="https://user-images.githubusercontent.com/107501631/209439875-4865055d-00a2-4fe9-80f6-7e60223cae68.png">

We can see that the Accuracy and Sensitivity of the Logistic Regression is High compared to Decision Tree even Specificity is reasonal among the both. We can also infer that from the summary tables Logistic Regession perfroms slightly better than the Decision tree and can be used for the future predictions.
Also From the ROC AUC curve we an assess that Logistic regression is better performing one than the Decision Tree.

## Conclusion:
From the above analysis and modelling, one can assess the per cent of customers' churn and the losses due to Churn. At the same time, they can come up with a better structure to reduce the churn rate of the organisation. The above methodologies are not the only ones which can help in predicting the churn rate rather there are multiple and even better models available.

Having said the above, there are still limitations in predicting the churn rate exactly, as there may be a sudden change in the market due to which the mentioned internal and external factors may vary with which the data which is used for the model might be not much useful. So, it would be always better to have real-time updated data for performing analysis for better and more accurate outcomes.

Also, the telecom domain is not the only domain where churn analysis is helpful rather it can be applied in multiple domains like Education, Financial, Transport Sector etc. to understand a few factors like why students are leaving schools, why the customers are shifting among the banks, why the public is avoiding using public transport and many others.
