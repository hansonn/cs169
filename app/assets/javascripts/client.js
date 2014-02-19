ERR_BAD_CREDENTIALS = -1;
ERR_USER_EXISTS = -2;
ERR_BAD_USERNAME = -3;
ERR_BAD_PASSWORD  = -4;

/* Takes a dictionary to be JSON encoded, calls the success
   function with the diction decoded from the JSON response.*/
function json_request(URL, dictionary, s, f) {
    $.ajax({
        type: 'POST',
        url: URL,
        data: JSON.stringify(dictionary),
        contentType: "application/json",
        dataType: "json",
        success: s,
        error: f
    });
}

function errCode_message(code) {
    if( code == ERR_BAD_CREDENTIALS) {
        return ("Erroe: Invalid username and password combination. ");
    } else if( code == ERR_BAD_USERNAME) {
        return ("Error: The user name should not be empty or have more than 128 characters.");
    } else if( code == ERR_USER_EXISTS) {
        return ("Error: This user name already exists.");
    } else if( code == ERR_BAD_PASSWORD) {
        return ("Error: The password cannot be longer than 128 characters.");
    } else {
        return ("There is an unknown error with error code: " + code);
   }
}
