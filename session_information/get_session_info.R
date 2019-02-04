get_session_info = function( session, print = T ){
    hostname = isolate( session$clientData$url_hostname )
    port = isolate( session$clientData$url_port )
    
    if ( print ){
        cat( "Hostname:", hostname, "\n" )
        cat( "Port:", port, "\n" )
    }
    
    reactiveValues( hostname = hostname, port = port )
}

