ad_page_contract {
    
    Posting History for a User

    @author Ben Adida (ben@openforce)
    @creation-date 2002-05-29
    @version $Id$

} {
    user_id:integer,notnull
    {view "date"}
}

# choosing the view
set dimensional_list {
    {
        view "View:" date {
            {date "by Date" {}}
            {forum "by Forum" {}}
        }
    }
}

db_multirow surveys select_surveys {}

# Get user information
oacs::user::get -user_id $user_id -array user

set dimensional_chunk [ad_dimensional $dimensional_list]

set context_bar {{Respose History}}

ad_return_template
