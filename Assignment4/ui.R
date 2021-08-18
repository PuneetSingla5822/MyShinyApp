# This is the user-interface definition of a Shiny web application.

library(shiny)

# Define UI for application that create a Machine Learning model based on user's choice of predictors
shinyUI(fluidPage(
    # Application title
    fluidRow(
        column(style = "color:#FF7F50;",12,h3(strong("My Shiny App for Machine Learning"),align = 'middle')),
        column(style = "color:black;",12,h4(em("Author: Puneet Singla"),align = 'middle'))
    ),
    
    # Application Purpose
    fluidRow(style = "color:black;background:#E5E7E9;",
             column(12, strong(("How to use this application?"))),
             column(12, ("My Shiny app allows its users to pick the predictors from the IRIS dataset, 
                         build a Machine Learning model, and evaluate its accuracy in three simple steps:")),
             column(12, (" + Step 1: Select the predictors of your choice")),
             column(12, (" + Step 2: Click Submit")),
             column(12, (" + Step 3: Sit back, relax and see the Magic!!"))
    ),
    
    # User Inputs
    fluidRow(
        style = "border: 1px solid black;",
        column(style = "color:Navy;",12,h4(strong("Select the Predictors for the Model"))),
        column(2,checkboxInput("SepalLen","Select Sepal Length", value = TRUE)),
        column(2,checkboxInput("Sepalwid","Select Sepal Width", value = TRUE)),
        column(2,checkboxInput("PetalLen","Select Petal Length", value = TRUE)),
        column(2,checkboxInput("Petalwid","Select Petal Width", value = TRUE)),
        column(4,submitButton("Submit"))
    ),
    
    # Output Model
    fluidRow(
        style = "border: 1px solid black;",
        column(style = "color:Navy;",12,h4(strong("Outcome: Prediction Model"))),
        column(12,plotOutput("mdl", width = "800px"),align = 'middle')
        ),
        
    fluidRow(
        style = "border: 1px solid black;",
        fluidRow(
            column(3,h4(" ")),
            column(style = "color:Navy;",3,h4(strong("In Sample Error Rate")), align = 'middle'),
            column(style = "color:Navy;",3,h4(strong("Out of Sample Error Rate")), align = 'middle'),
            column(3,h4(" "))
            ),
        fluidRow(
            column(3,h4(" ")),
            column(3,h4(textOutput("InErrRate"), align = 'middle')),
            column(3,h4(textOutput("OutErrRate")), align = 'middle'),
            column(3,h4(" "))
            )
        ),
    
    fluidRow(
        style = "color:black;background:#E5E7E9;",
        column(12, strong(("How does this application work?"))),
        column(12, ("My Shiny app uses the IRIS dataset and RPART Machine Learning algorithm from the CARET package 
                    to build classification and regression trees. The following steps are involved")),
        column(12, (" + Step 1: Based on user selection of predictors, first create a subset of the IRIS dataset 
                    limited to selected predictors")),
        column(12, (" + Step 2: Divide the IRIS data into Training (60%) & Test datasets (40%)")),
        column(12, (" + Step 3: Train the Machine Learning model using the training dataset & plot the results")),
        column(12, (" + Step 4: Calculate the in-sample & out-of-sample error rate")),
        column(12, (" + Step 5: Pass the calculated values from Server.R to UI.R to display on the UI"))
        ),
    )
)