##### login page #####

# This page is for logging into the application

login_page = function( input, output, session, page_name, session_information, page_links ){
    input_id = function( input_id ){
        paste0( page_name, "/" ,input_id )
    }
    page_link_id = function( input_id ){
        paste0( page_name, input_id )
    }

    login_page = renderUI({
        load( "user_table.RData" ) # load user_table
        login_errors = list( username_error = FALSE, password_error = FALSE )
        
        username_text = "Username:"
        password_text = "Password:"

        observeEvent( input[[input_id("login")]], {
            password_entry = md5_hash( isolate( input[[ input_id("password") ]] ) )
            username_entry = isolate( input[[ input_id("username") ]] )
            
            cat( "User login:", username_entry, "\n" )
            
            tag_list = list()
            if ( ! username_entry %in% user_table$username ){
                login_errors$username_error = TRUE
                cat( "Username error\n" )
                tag_list[[length(tag_list)+1]] = tags$p( "Errors:", class = "red_highlight" )
                tag_list[[length(tag_list)+1]] = tags$p( "Username is incorrect.", class = "red_highlight" )
            } else{
                user_index = which( username_entry == user_table$username )
                if (! password_entry == user_table$password[ user_index ] ){
                    login_errors$password_error
                    cat( "Password error\n" )
                    tag_list[[length(tag_list)+1]] = tags$p( "Errors:", class = "red_highlight" )
                    tag_list[[length(tag_list)+1]] = tags$p( "Password is incorrect", class = "red_highlight" )
                } else{
                    cat( "Login successful\n" )
                    session_information$username = username_entry
                    session_information$access_level = user_table$access_level[ user_index ]
                    isolate( cat( "Welcome", session_information$username, "\nAccess level:", session_information$access_level, "\n" ) )
                    session_information$current_page = page_links[[ isolate(page_link_id("login")) ]]
                    cat( page_name , "->", session_information$current_page, "\n" )
                    print_header("")
                }
            }
            
            output$login_error_text = renderUI({
                do.call( tagList, tag_list )
            })
            
        } )

        wellPanel(
            textInput( inputId = input_id( "username" ), label = username_text, value = "" ),
            passwordInput( inputId = input_id( "password" ), label = password_text, value = "" ),
            hr(),
            actionButton( inputId = input_id( "login" ), label = "Log in" ),
            session_quit_button(),
            br(),
            actionLink( inputId = input_id( "make_new_account"), label = "Make new account" ),
            br(),
            actionLink( inputId = input_id( "forgot_password" ), label = "Forgot password" ),
            uiOutput("login_error_text"),
            hr()
        )
    })
    
    output[[page_name]] = login_page
}



