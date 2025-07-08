##On load les librairies
library(shiny)
library(shinythemes)

##On choisit notre apparence de thème
ui <- fluidPage(
  theme = shinytheme("united"),
  titlePanel("Formulaire Patient"),
  
  tags$style(HTML("
    .row-custom {
      display: flex;
      gap: 20px;
      height: 580px; /* légèrement réduit pour laisser de l'espace */
      margin: 10px;
    }

    .box {
      border: 2px solid black;
      padding: 15px;
      background-color: #ffffff;
      overflow: auto;
      border-radius: 8px;
    }

    .box1 {
      flex: 0.95;  /* légèrement rétréci */
    }

    .box2-3 {
      flex: 0.95;
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .box2 {
      flex: 2;
    }

    .box3 {
      flex: 1;
    }
  ")),
  
  # Disposition principale
  div(class = "row-custom",
      div(class = "box box1",
          h4("Informations principales"),
          textInput("nom", "Nom du patient"),
          numericInput("age", "Âge", value = NA),
          selectInput("sexe", "Sexe", choices = c("Homme", "Femme")),
          numericInput("poids", "Poids (kg)", value = NA)
      ),
      
      div(class = "box2-3",
          div(class = "box box2",
              h4("Informations médicales"),
              numericInput("creat", "Créatinine (mg/L)", value = NA),
              numericInput("dose", "Dose administrée (mg)", value = NA),
              actionButton("soumettre", "Générer le résumé")
          ),
          div(class = "box box3",
              h4("Résumé"),
              verbatimTextOutput("resume")
          )
      )
  )
)

server <- function(input, output) {
  observeEvent(input$soumettre, {
    output$resume <- renderText({
      paste0("Résumé patient :\n",
             "Nom : ", input$nom, "\n",
             "Âge : ", input$age, " ans\n",
             "Sexe : ", input$sexe, "\n",
             "Poids : ", input$poids, " kg\n",
             "Créatinine : ", input$creat, " mg/L\n",
             "Dose : ", input$dose, " mg")
    })
  })
}

shinyApp(ui = ui, server = server)



