
library(shiny)
library(shinydashboard)
library(shinythemes)
library(plotly)
library(dashboardthemes)
library(flexdashboard)

ad_event <- read.csv("admissions_event.csv")
sim <- read.csv("similarity.csv")

# Header
header <- dashboardHeader(title = "Medical Dashboard")



sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Home", tabName = "home", icon = icon("hospital")),
        menuItem("Patient Tracking", tabName="patient", icon = icon("id-card-alt")),
        menuItem("Retrieving & Prediction", tabName = "pred", icon = icon("file-alt"))
    )
)

body <- dashboardBody(
    ### changing theme
    shinyDashboardThemes(
        theme = "grey_light"
    ),
    tabItems(
        
        tabItem(tabName = "home",
                h2("MIMIC-III Critical Care Database: Beth Israel Deaconess Medical Center"),
                fluidRow(
                    infoBox(width = 4, "Total Patient Number", length(unique(ad_event$SUBJECT_ID)),icon = icon("clinic-medical"), color = "blue", fill = TRUE),
                    infoBox(width = 4, "Total Admission Number", length(unique(ad_event$HADM_ID)), icon = icon("laptop-medical"), color = "purple", fill = TRUE),
                    infoBox(width = 4, "Total Death Number", sum(unique(ad_event$DEATHTIME)!=""), icon = icon("hospital-user"), color = "black", fill = TRUE)
                ),
                fluidRow(
                    box(plotOutput("plot1"), height = 220, width = 4, status = "success" ),
                    box(plotOutput("plot2"), height = 220, width = 4, status = "primary"),
                    box(plotOutput("plot3"), height = 220, width = 4, status = "warning")
                ),
                fluidRow(
                    box(plotOutput("plot4"), height = 220, width = 4, status = "warning"),
                    box(plotOutput("plot5"), height = 220, width = 4, status = "success"),
                    box(plotOutput("plot6"), height = 220, width = 4, status = "primary")
                ),
                fluidRow(
                    box(plotOutput("plot7"), height = 220, width = 6),
                    box(plotOutput("plot8"), height = 220, width = 6)
                )
                
                
        ),
        
        
        tabItem(tabName = "patient",
                h2("Patient Information"),
                fluidRow(box(title = "Select Patient", status = "primary",
                             selectizeInput(
                                 's', 'Search or Select Patient ID',
                                 choices = unique(ad_event$SUBJECT_ID)), width = 3
                             )
                         ),
                fluidRow(box(title="Personal Information" ,tableOutput('table1'), width = 12, solidHeader = TRUE)),
                fluidRow(box(title = "Conditions", dataTableOutput("table2"), width = 6, status="warning",solidHeader = TRUE,collapsible=TRUE),
                         box(title = "Treatments", dataTableOutput("table3"), width = 6, status="success",solidHeader = TRUE,collapsible=TRUE)),
                fluidRow(box(title = "Medical Records", dataTableOutput("table4"),width = 12, solidHeader = TRUE,status = "primary"))
        ),
        tabItem(tabName = "pred",
                h2("Similar Patient Retrieval and Diseases Prediction"),
                fluidRow(box(title = "Select Patient", status = "success",
                             selectizeInput(
                                 'p', 'Search or Select Patient ID',
                                 choices = unique(sim$SUBJECT_ID)), width = 3)),
                fluidRow(box(title = "Top 3 Most Similar Patients", dataTableOutput("table5"), solidHeader = T, status = "primary", width = 12)))
    )
)

# Put them together into a dashboardPage
dashboardPage(
    header,
    sidebar,
    body
)
