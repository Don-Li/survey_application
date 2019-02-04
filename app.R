library( shiny )
library( data.table )

##### Shared information #####
source( "log_functions/log_print.R", local = T )
source( "usage_statistics/usage_statistics.R", local = T )

print_header( "APPLICATION START UP" )


print_header( "", newlines = 1 )

##############################


##### Source functions #####
source( "session_information/get_session_info.R", local = T )
source( "utility_functions/md5_hash.R", local = T )
source( "utility_functions/session_quit.R", local = T )
source( "utility_functions/css_functions.R", local = T )
source( "utility_functions/session_logout.R", local = T )
############################

##### Source pages #####
source( "user_management/login_page.R", local = T )
source( "user_management/account_page.R", local = T )

########################


##### Page links #####
page_links = list(
    "PROTECTED_login_page/login" = "PROTECTED_account_page/"
)
#######################

ui = fluidPage( uiOutput("ui") )

server = function( input, output, session ){
    print_header( "START INSTANCE" )
    session_information = get_session_info( session )
    session_information$current_page = "PROTECTED_login_page/"
    print_header( "SOURCING PAGES" )
    
    user_data = reactiveValues()
    
    page_list = list(
        "PROTECTED_login_page/" = login_page( input, output, session, "PROTECTED_login_page/", session_information, page_links ),
        "PROTECTED_account_page/" = account_page( input, output, session, "PROTECTED_account_page/", session_information, page_links )
    )
    
    
    session_quit_button_event( input, session )
    session_logout_button_event( input, session_information )
    
    output[["ui"]] = renderUI({
        print_header("")
        cat( "Current page:", session_information$current_page, "\n" )
        
        fluidPage(
            tags$head( tags$link( rel = "stylesheet", type = "text/css", href = "survey_app.css" ) ),
            uiOutput( session_information$current_page )
        )
    })

    
    
    
    
    
}

# shinyApp( ui = ui, server = server, options = list(host = "192.168.1.3", port = 1234 ) )
shinyApp( ui = ui, server = server )