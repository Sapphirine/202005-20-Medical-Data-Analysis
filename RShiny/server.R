
library(flexdashboard)
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(gridExtra)
library(tibbletime)



source("ui.R")
server <- function(input, output, session) {
    
    ad_event <- read.csv("admissions_event.csv")
    sim <- read.csv("similarity.csv")
    
    selectID <- reactive({
        data.frame(
            Name = c("ID"),
            Value = input$s
        )
    })
    
    
    # barplot admission_type
    output$plot1 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=ADMISSION_TYPE))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    # barplot insurance
    output$plot2 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=INSURANCE))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    # barplot LANGUAGE
    output$plot3 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=LANGUAGE))+
            theme(panel.background = element_blank())
    }, height = 200)

    # barplot RELIGION
    output$plot4 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=RELIGION))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    # barplot MARITAL STATUS
    output$plot5 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=MARITAL_STATUS))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    # barplot ETHNICITY
    output$plot6 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=ETHNICITY))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    # barplot admission_location
    output$plot7 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=ADMISSION_LOCATION))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    # barplot discharge_location
    output$plot8 <- renderPlot({
        ggplot(data=ad_event)+
            geom_bar(aes(x=DISCHARGE_LOCATION))+
            theme(panel.background = element_blank())
    }, height = 200)
    
    
    
    #table1
    output$table1 <- renderTable({
        ad_event %>%
            filter(SUBJECT_ID==input$s) %>%
            select(SUBJECT_ID,INSURANCE, LANGUAGE,RELIGION, MARITAL_STATUS, ETHNICITY) %>%
            slice(1)
    })
    
    output$table2 <- renderDataTable({
        ad_event %>%
            filter(SUBJECT_ID==input$s) %>%
            select(DIAGNOSIS, ADMITTIME) %>%
            distinct() %>%
            arrange(ADMITTIME)
    })
    
    output$table3 <- renderDataTable({
        ad_event %>%
            filter(SUBJECT_ID==input$s) %>%
            select(SHORT_TITLE, ADMITTIME) %>%
            distinct() %>%
            arrange(ADMITTIME)
    })
    
    output$table4 <- renderDataTable({
        ad_event %>%
            filter(SUBJECT_ID==input$s) %>%
            select(HADM_ID,ICD9_CODE,ADMISSION_TYPE,ADMITTIME,DISCHTIME,SHORT_TITLE,LONG_TITLE,EDREGTIME,EDOUTTIME,DEATHTIME) %>%
            distinct() %>%
            arrange(ADMITTIME)
    })
    
    output$table5 <- renderDataTable({
        sim %>%
            filter(SUBJECT_ID==input$p) %>%
            select(-SUBJECT_ID)
        
    })
    
    
    
}