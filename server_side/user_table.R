source( "../utility_functions/md5_hash.R", local = T )

user_table = data.table(
    username = character(),
    password = character(),
    access_level = numeric(0)
)

admin_table = data.table( username = "admin", password = md5_hash("admin123"), access_level = 1 )

user_table = rbind( user_table, admin_table )

available_surveys = list(
    "admin" = c("test_survey")
)

save( user_table, file = "user_table.RData" )
save( available_surveys, file = "available_surveys.RData" )
