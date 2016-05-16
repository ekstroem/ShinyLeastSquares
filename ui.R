library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Least squares example"),
  
  sidebarPanel(
    sliderInput("alpha", 
                "Intercept", 
                value = 1,
                min = -1, 
                max = 3,
                step = 0.05),
    
    sliderInput("beta", 
                "Slope", 
                value = 1,
                min = -1, 
                max = 3,
                step = 0.05),
    
    br(),
  
    radioButtons("outputtype", "Output type:",
                 list("Points" = "points",
                      "Residuals" = "residuals",
                      "Squared residuals" = "sqresiduals")),
    
    checkboxInput(inputId = "sse",
                  label = strong("Show sum of squared residuals"),
                  value = FALSE)
  ),
  
  mainPanel(
      plotOutput(outputId = "main_plot", height="600px", width="800px")
  
))
)