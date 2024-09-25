*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Suite Setup    Open Browser    ${URL}    ${BROWSER}
Suite Teardown    Close All Browsers

*** Variables ***
${URL}    http://jimms.fi
${BROWSER}    chrome
${SEARCH_KEYWORD}    ps5
${TIMEOUT}    20s
${RETRY_TIMEOUT}    2s
${RETRY_COUNT}    3

*** Keywords ***
Wait For And Click Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Wait Until Element Is Enabled    ${locator}    ${TIMEOUT}
    ${status}    ${message}    Run Keyword And Ignore Error    Click Element    ${locator}
    Run Keyword If    '${status}' == 'FAIL'    Scroll Element Into View    ${locator}
    Run Keyword If    '${status}' == 'FAIL'    Click Element    ${locator}

Input Text With Retry
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Wait Until Element Is Enabled    ${locator}    ${TIMEOUT}
    ${status}    ${message}    Run Keyword And Ignore Error    Input Text    ${locator}    ${text}
    Run Keyword If    '${status}' == 'FAIL'    Scroll Element Into View    ${locator}
    Run Keyword If    '${status}' == 'FAIL'    Input Text    ${locator}    ${text}

Wait For Page Load
    Wait For Condition    return document.readyState == "complete"    ${TIMEOUT}

Retry Keyword
    [Arguments]    ${keyword}    @{arguments}
    Wait For Page Load
    FOR    ${i}    IN RANGE    ${RETRY_COUNT}
        ${status}    ${message}    Run Keyword And Ignore Error    ${keyword}    @{arguments}
        Return From Keyword If    '${status}' == 'PASS'
        Sleep    ${RETRY_TIMEOUT}
    END
    Fail    Keyword '${keyword}' failed after ${RETRY_COUNT} retries. Last error: ${message}

*** Test Cases ***
TC_UI_1_Verify_Homepage_Loads
    [Documentation]    Verify that the homepage loads all components correctly.
    [Tags]    UI
    Retry Keyword    Wait Until Page Contains Element    id=jim-header
    Retry Keyword    Wait Until Page Contains Element    class=footer
    Retry Keyword    Wait Until Page Contains Element    xpath=//nav

TC_UI_2_Verify_Search_Functionality
    [Documentation]    Verify that the search box works correctly.
    [Tags]    UI
    Retry Keyword    Input Text With Retry    id=searchinput    ${SEARCH_KEYWORD}
    Retry Keyword    Wait For And Click Element    css=button[type="Button"]
    Retry Keyword    Wait Until Page Contains    ${SEARCH_KEYWORD}

TC_UI_3_Verify_Product_Filters
    [Documentation]    Verify that product filters show relevant products.
    [Tags]    UI
    Retry Keyword    Go To    ${URL}/category_page
    Retry Keyword    Wait For And Click Element    xpath://*[@id="productsearchpage"]/div[2]/div[3]/div/div/div[2]/button
    Retry Keyword    Wait Until Page Contains    filtered_product
    

TC_UI_4_Verify_Navigation_Bar
    [Documentation]    Verify that the navigation bar links work correctly.
    [Tags]    UI
    Retry Keyword    Wait For And Click Element    xpath=//a[contains(text(), 'Category')]
    Retry Keyword    Wait Until Page Contains    Category Page
    Retry Keyword    Go Back
    Retry Keyword    Wait For And Click Element    xpath=//a[contains(text(), 'Another Category')]
    Retry Keyword    Wait Until Page Contains    Another Category Page

TC_FUNC_1_Verify_Add_To_Cart
    [Documentation]    Verify that the user can add a product to the cart.
    [Tags]    Functional
    Retry Keyword    Wait For And Click Element    xpath=//*[@id="productsearchpage"]/div[2]/div[5]/div/div[1]/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
    Retry Keyword    Wait For And Click Element    id=add_to_cart_button
    Retry Keyword    Wait Until Page Contains Element    id=cart_counter

TC_FUNC_2_Verify_Cart_Details
    [Documentation]    Verify that the product details in the cart are correct.
    [Tags]    Functional
    Retry Keyword    Go To    ${URL}/cart
    Retry Keyword    Wait Until Page Contains    game chair
    Retry Keyword    Wait Until Page Contains    product_price

TC_FUNC_3_Verify_Checkout_Process
    [Documentation]    Verify that the user can complete the checkout process.
    [Tags]    Functional
    Retry Keyword    Go To    ${URL}/checkout
    Retry Keyword    Input Text With Retry    id=shipping_address    some_address
    Retry Keyword    Input Text With Retry    id=payment_details    some_payment_info
    Retry Keyword    Wait For And Click Element    id=proceed_to_payment_button
    Retry Keyword    Wait Until Page Contains    Order Confirmation

TC_FUNC_4_Verify_Review_Submission
    [Documentation]    Verify that the user can submit a product review.
    [Tags]    Functional
    Retry Keyword    Go To    ${URL}/product_page
    Retry Keyword    Scroll Element Into View    id=review_section
    Retry Keyword    Input Text With Retry    id=review_input    This is a test review.
    Retry Keyword    Wait For And Click Element    id=submit_review_button
    Retry Keyword    Wait Until Page Contains    Review Submitted

TC_SEC_1_Verify_Login_Valid_Credentials
    [Documentation]    Verify login with valid credentials.
    [Tags]    Security
    Retry Keyword    Go To    ${URL}/login
    Retry Keyword    Input Text With Retry    id=l-UserName    valid_username
    Retry Keyword    Input Text With Retry    id=l-Password    valid_password
    Retry Keyword    Wait For And Click Element    id=loginbtn
    Retry Keyword    Wait Until Page Contains    Welcome

TC_SEC_2_Verify_Login_Invalid_Credentials
    [Documentation]    Verify login with invalid credentials.
    [Tags]    Security
    Retry Keyword    Go To    ${URL}/login
    Retry Keyword    Input Text With Retry    id=l-UserName    invalid_username
    Retry Keyword    Input Text With Retry    id=l-Password    invalid_password
    Retry Keyword    Wait For And Click Element    id=loginbtn
    Retry Keyword    Wait Until Page Contains    Invalid Credentials

TC_FUNC_5_Verify_Search_And_Product_Page
    [Documentation]    Verify search functionality, take screenshot, and check product page
    [Tags]    Functional
    Retry Keyword    Go To    ${URL}
    Retry Keyword    Input Text With Retry    id=searchinput    ${SEARCH_KEYWORD}
    Retry Keyword    Wait For And Click Element    css=button[type="Button"]
    Retry Keyword    Wait Until Page Contains Element    css=.product-item
    ${first_product}    Retry Keyword    Get WebElement    css=.product-item:first-child
    Retry Keyword    Capture Element Screenshot    ${first_product}    first_product.png
    ${product_link}    Retry Keyword    Get Element Attribute    css=.product-item:first-child a    href
    Retry Keyword    Go To    ${product_link}
    Retry Keyword    Page Should Contain    ${SEARCH_KEYWORD}    ignore_case=True