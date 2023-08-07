#' @name create_new
#' @title Create programs and projects
#' @author Nicolas Mangin
#' @description Gadget facilitating the creation of scholR programs or projects.
#' @importFrom dplyr bind_rows
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom miniUI gadgetTitleBar
#' @importFrom miniUI miniContentPanel
#' @importFrom miniUI miniPage
#' @importFrom readr read_csv
#' @importFrom shiny actionButton
#' @importFrom shiny icon
#' @importFrom shiny observeEvent
#' @importFrom shiny radioButtons
#' @importFrom shiny reactive
#' @importFrom shiny renderText
#' @importFrom shiny req
#' @importFrom shiny runGadget
#' @importFrom shiny stopApp
#' @importFrom shiny textInput
#' @importFrom shiny textOutput
#' @importFrom shinyFiles getVolumes
#' @importFrom shinyFiles shinyDirButton
#' @importFrom shinyFiles shinyDirChoose
#' @importFrom shinyalert shinyalert
#' @importFrom tibble tibble
#' @export


create_new <- function() {
  
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Create a new program and/or a new project"),
    miniUI::miniContentPanel(
      shinyFiles::shinyDirButton(
        "directory",
        label = "Select the root folder",
        title = "Select the folder in which the project folder is or should be created.",
        style = "width:100%; background-color:#900; color:#FFF;"
      ),
      shiny::textOutput("rootfolder"),
      shiny::tags$hr(),
      shiny::textInput("defprogramname", "Program name:", width = "100%"),
      shiny::tags$hr(),
      shiny::textInput("defprojectname", "Project name:", width = "100%"),
      shiny::radioButtons("slcttype", "Project type:", choices = c("Course","Investigation")),
      shiny::actionButton(
        "create", "Create", icon = shiny::icon("wand-magic-sparkles"),
        style = "width:100%; background-color:#009; color:#FFF; margin-top:25px;"
      )
    )
  )
  
  server <- function(input, output, session) {
    
    references <- NULL
    
    volumes <- shinyFiles::getVolumes()()
    shinyFiles::shinyDirChoose(
      input, "directory",
      roots = volumes,
      session = session,
      allowDirCreate = FALSE
    )
    
    root_folder <- shiny::reactive({
      shiny::req(!base::is.null(input$directory))
      path <- base::unlist(input$directory)
      path <- path[-base::length(path)]
      base::paste(path, collapse = "/")
    })
    
    output$rootfolder <- shiny::renderText({
      shiny::req(!base::is.null(root_folder()))
      if (base::dir.exists(root_folder())){
        root_folder()
      } else {
        "Please select a valid folder."
      }
    })
    
    program_folder <- shiny::reactive({
      shiny::req(!base::is.null(root_folder()))
      shiny::req(!base::is.null(input$defprogramname))
      base::paste0(root_folder(), "/", input$defprogramname)
    })
    
    project_folder <- shiny::reactive({
      shiny::req(!base::is.null(program_folder()))
      base::paste0(program_folder(), "/", input$defprojectname)
    })
    
    add_to_project_folders <- shiny::reactive({
      shiny::req(!base::is.null(input$defprojectname))
      shiny::req(!base::is.null(input$slcttype))
      shiny::req(!base::is.null(project_folder()))
      if (input$slcttype == "Course"){
        tibble::tibble(
          course = input$defprojectname,
          path = project_folder()
        )
      } else {
        tibble::tibble(
          investigation = input$defprojectname,
          path = project_folder()
        )
      }
    })
    
    
    shiny::observeEvent(input$create, {
      
      utils::data("references", package = "scholR")
      
      scholR_path <- base::path.package("scholR")
      
      if (!base::dir.exists(root_folder())){
        shinyalert::shinyalert(
          title = "Non-existing root folder",
          text = "Please select a valid root folder.",
          type = "error"
        )
      }
      shiny::req(dir.exists(root_folder()))
      
      if (!base::dir.exists(program_folder())) base::dir.create(program_folder())
      
      references_path <- base::paste0(program_folder(), "/references.RData")
      if (!base::file.exists(references_path)) base::save(references, file = references_path)
      
      if (input$slcttype == "Course"){
        
        manage_course_file <- base::paste0(program_folder(), "/manage_course.R")
        course_folder <- base::paste0(project_folder())
        
        if (!base::file.exists(manage_course_file)){
          manage_course_origin <- base::paste0(scholR_path, "/manage_course.R.zip")
          manage_course_destination <- base::paste0(program_folder(), "/manage_course.R.zip")
          base::file.copy(
            from = manage_course_origin,
            to = manage_course_destination
          )
          utils::unzip(manage_course_destination, exdir = program_folder())
          base::file.remove(manage_course_destination)

        }
        
        if (!base::dir.exists(course_folder)){
          course_origin <- base::paste0(scholR_path, "/course.zip")
          course_destination <- base::paste0(program_folder(), "/course.zip")
          base::file.copy(
            from = course_origin,
            to = course_destination
          )
          utils::unzip(course_destination, exdir = program_folder())
          base::file.remove(course_destination)
          base::file.rename(base::paste0(program_folder(), "/course"), course_folder)
          
          course_path_file <- base::paste0(program_folder(), "/course_folders.csv")
          if (!base::file.exists(course_path_file)) {
            utils::write.csv(add_to_project_folders(), file = course_path_file, row.names = FALSE)
          } else {
            readr::read_csv(course_path_file, col_types = "cc") |>
              dplyr::bind_rows(add_to_project_folders()) |>
              utils::write.csv(file = course_path_file, row.names = FALSE)
          }
          
          shinyalert::shinyalert(
            title = "New project created",
            text = "Go to the program folder, open and launch the appropriate application to work on it.",
            type = "success"
          )
          
        } else {
          shinyalert::shinyalert(
            title = "Already existing project folder",
            text = "Please define another project name or remove the existing one.",
            type = "error"
          )
        }
        
      }
      
    })
    
    shiny::observeEvent(input$done, {
      shiny::stopApp()
    })
  }
  
  shiny::runGadget(ui, server)
}

# scholR::list_used_packages_and_functions() |> dplyr::filter(file == "R/create_new.R") |> dplyr::select(import) |> base::unlist() |> base::as.character() |> writeLines()

