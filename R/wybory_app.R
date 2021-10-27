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
ui <- shiny::fluidPage(
  shiny::titlePanel("Old Faithful Geyser Data"),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    shiny::mainPanel(
      shiny::plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {

  output$distPlot <- shiny::renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

shiny::shinyApp(ui = ui, server = server)
}
