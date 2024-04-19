library(shiny)
library(tidyverse)
library(dataRetrieval)
library(ggplot2)

source('funcs.R')

ui <- fluidPage(
  titlePanel("Flow Data"),
  sidebarLayout(
    sidebarPanel(
      textInput("siteNumber", "Enter a USGS site number: ", value = "01184000"),
      dateInput("startDate", "Enter a start date: ", value = "2020-01-01"),
      dateInput("endDate", "Ender an end date: ", value = Sys.Date()),
      actionButton("goButton", "Go")
    ),
    mainPanel = (
      plotOutput("hydrograph")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$goButton, {
    siteNumber <- isolate(input$siteNumber)
    startDate <- input$startDate
    endDate <- input$endDate
    data <- readNWISdv(siteNumber, "00060", startDate, endDate)
    colnames(data)[4] <- "Flow"
    output$hydrograph <- renderPlot({
      ggplot(data, aes(Date, Flow)) +
        geom_line() +
        labs(x = "Date", y = "Flow (cfs)", title = paste("Hydrograph for site", siteNumber))
    })
  })
}

shinyApp(ui = ui, server = server)
