session_quit_button_event = function( input, session ){
    observeEvent( input[["session_quit"]], {
        print_header( "SESSION CLOSE" )
            session$close()
        } )
}

session_quit_button = function(){
    actionButton( inputId = "session_quit", label = "Quit" )
}