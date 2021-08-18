# This is the server logic of a Shiny web application.

library(shiny)
library(caret)
library(rattle)
library(e1071)
set.seed(123)

# Define server logic required to select the user specified predictors in the data & create a Machine Learning model
# that uses those predictors to predict the Species of flowers.

shinyServer(function(input, output) {
    
    # Calculate the IRIS data subset and create Machine Learning Model
    ml_out <- reactive({
        
        if(input$SepalLen+input$Sepalwid+input$PetalLen+input$Petalwid == 0) {
            return(NULL)
        }
        
        iris <- iris[,c(1*input$SepalLen,2*input$Sepalwid,3*input$PetalLen,4*input$Petalwid,5)]
        
        ml_inTrain <- createDataPartition(iris$Species, p = 0.6)[[1]]
        ml_train <- iris[ml_inTrain,]
        ml_test <- iris[-ml_inTrain,]
        
        ml_mdl <- train(Species ~ ., data = ml_train, method = "rpart")
        
        list(ml_train = ml_train, ml_test = ml_test, ml_mdl = ml_mdl)
    })
    
    # Calculate In sample error rate
    output$InErrRate <- renderText({
        if(is.null(ml_out()$ml_mdl)) {"Error: Select at least one predictor"}
        else
        paste(round((1-confusionMatrix(ml_out()$ml_train$Species,
                                       predict(ml_out()$ml_mdl,ml_out()$ml_train))$overall[1])*100,2), "%", sep="")
    })
    
    # Calculate out of sample error rate
    output$OutErrRate <- renderText({
        if(is.null(ml_out()$ml_mdl)) {"Error: Select at least one predictor"}
        else
        paste(round((1-confusionMatrix(ml_out()$ml_test$Species,
                                       predict(ml_out()$ml_mdl,ml_out()$ml_test))$overall[1])*100,2), "%", sep="")
    })
    
    # Plot the RPART plot
    output$mdl <- renderPlot({
        
        validate(
            need(ml_out()$ml_mdl, "Error: Select at least one predictor"
            )
        )
        fancyRpartPlot(ml_out()$ml_mdl$finalModel)
    })
})
