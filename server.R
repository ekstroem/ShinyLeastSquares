library(shiny)

shinyServer(function(input, output) {

  x <- c(1, 2, 3, 4)
  y <- c(2, 4, 3, 5)
    
  output$main_plot <- renderPlot({

    res <- lm(y ~ x)
    
    layout(matrix(c(1,1, 2, 2), ncol=2), widths=c(3,1))
    
    par(cex=1.3)
    plot(x, y, xlim=c(-1, 6), ylim=c(-1, 6), pch=20, cex=1.3)
    
    abline(a=input$alpha, b=input$beta, lwd=3, col="blue")
    
    if (input$outputtype=="residuals") {
      segments(x, input$alpha+input$beta*x, x, y)
    } else if (input$outputtype=="sqresiduals") {
      for (i in 1:length(x)) {
        preds <- input$alpha + input$beta*x[i]
        ress <- y[i] - preds
        polygon(x=c(x[i], x[i], x[i]-ress, x[i]-ress), y=c(preds, y[i], y[i], preds),
                col="#0000BB66")
      }
      segments(x, input$alpha+input$beta*x, x, y)
    }
    
    if (input$sse) {        
        sse <- sum((y - (input$alpha+input$beta*x))**2)
        bp <- barplot(sse, col="#0000BB66", ylim=c(0, 15), main="Sum of squared residuals")
        text(bp, 1, sse)
    }
    
#    if (input$density) {
#      dens <- density(faithful$eruptions,
#                      adjust = input$bw_adjust)
#      lines(dens, col = "blue")
#    }
    
  })
})
