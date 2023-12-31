*** Settings ***
Documentation     A test suite for searching GIFs.
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       https://api.giphy.com
${API_KEY}        // Insert your API key here
${SEARCH_TERM}    cheeseburger

*** Test Cases ***
Search for GIFs
    [Documentation]  Search for GIFs using the GIPHY API
    Create Session   giphy   ${BASE_URL}
    ${params}=       Create Dictionary   q=${SEARCH_TERM}    api_key=${API_KEY}
    ${response}=     GET On Session        giphy   /v1/gifs/search    params=${params}
    Should Be Equal As Strings   ${response.status_code}   200
    ${json}=         Set Variable       ${response.json()}
    FOR    ${index}    IN RANGE    10
        Log To Console    Link ${index}: ${json['data'][${index}]['url']}
    END