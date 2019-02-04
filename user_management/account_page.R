##### Account page #####

make_header = function( session_information ){
    welcome_txt = paste0( "Welcome, ", session_information$username, "." )
    tags$h1( welcome_txt )
}

account_page = function( input, output, session, page_name, session_information, page_links ){
    input_id = function( input_id ){
        paste0( page_name, "/" ,input_id )
    }
    

    account_page = renderUI({
        
        if ( !is.null( session_information$username ) ){
            source( "utility_functions/session_quit.R", local = T )
            load( "server_side/available_surveys.RData" )
            user_available_surveys = available_surveys[[ session_information$username ]]
        
            for ( survey in user_available_surveys ){
                id = input_id( survey )
                insertUI( selector = "#survey_menu_placeholder", where = "beforeBegin", ui = {
                    actionLink( inputId = id, label = survey )
                } )
            }
        }
        

        
        fluidPage(
            make_header( isolate( session_information ) ),
            wellPanel(
                tags$p( "Available surveys:" ),
                tags$div( id = "survey_menu_placeholder" )
            ),
            wellPanel(
                tags$p( "Options:" ),
                actionButton( inputId = input_id( "make_new_survey" ), label = "Make a new survey" ),
                session_logout_button(),
                session_quit_button()
            )
            
        )
    })
    
    output[[page_name]] = account_page
}













