#' Aplikacja Shiny
#'
#' @description Funkcja pobiera pliki .xlsx i .csv z wynikami wyborów
#' dla podanego przez użytkownika roku, a także z danymi o okręgach wyborczych
#'
#' @param rok rok, w którym odbyły się wybory parlamentarne (do wyboru: 2007, 2011, 2015, 2019)
#'
#' @return aplikacja shiny
#' @export
#'
#' @examples
#' pobierz_wyniki(2019)

wybory_app = function(){
ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {

  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

shinyApp(ui = ui, server = server)
}
