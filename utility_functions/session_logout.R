session_logout_button_event = function( input, session_information, login_page_name = "PROTECTED_login_page/" ){
    observeEvent( input[["session_logout"]], {
        session_information$current_page <- login_page_name
        session_information$username = NULL
    } )
}

session_logout_button = function(){
    actionButton( inputId = "session_logout", label = "Logout" )
}