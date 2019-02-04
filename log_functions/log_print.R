# Log printing functions

print_header = function( text, newlines = 1, width = 100 ){
    
    if ( text == "" ){
        hashes = paste0( rep( "#", width ), collapse = "" )
        new_lines = paste0( rep( "\n", newlines ), collapse = "" )
        cat( paste0( hashes, new_lines ), sep = "" )
    } else {
        nchar_text = nchar( text )
        n_hashes = ( width - nchar_text - 2)/2
        hashes = paste0( rep( "#", n_hashes ), collapse = "" )
        new_lines = rep( "\n", newlines )
        cat( hashes, text, paste0( hashes, new_lines ) )
    }
}
