*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Suite Setup    Open Browser    ${URL}    ${BROWSER}
Suite Teardown    Close All Browsers

*** Variables ***
${URL}               http://jimms.fi
${BROWSER}           chrome
${SEARCH_KEYWORD}    ps5
${TIMEOUT}           5s
${PRODUCT_LINK}      xpath=//*[@id="productsearchpage"]/div[2]/div[5]/div/div[1]/product-box/div[2]
${ADD_TO_CART_LINK}  xpath=//*[@id="productsearchpage"]/div[2]/div[5]/div/div[1]/product-box/div[2]/div[3]/addto-cart-wrapper/div/a
${ADD_TO_CART_ICON}  xpath=//a[@class='btn btn-success btn-icon js-cart-btn']


*** Test Cases ***

TC_01_Check_Category_Landing_Pages
    [Documentation]    Verify all product categories have a landing page.
    [Tags]    Category
    ${categories}    Get WebElements    xpath=//ul[@id='category-list']//a
    FOR    ${category}    IN    @{categories}
        Click Element    ${category}
        Wait Until Page Contains Element    xpath=//div[contains(@class, 'category-title')]
        Go Back
    END

TC_02_Search_For_PS5_And_Verify_Product_Page
    [Documentation]    Search for PS5 and verify first product page.
    [Tags]    Search
    Input Text With Retry    xpath=//*[@id="searchinput"]    ${SEARCH_KEYWORD}
    Press Keys    xpath=//*[@id="searchinput"]   ENTER
    Wait For Page Load
    Wait Until Page Contains Element    ${PRODUCT_LINK}
    Capture Element Screenshot    ${PRODUCT_LINK}    ps5_product.png
    Click Element    ${PRODUCT_LINK}
   

TC_03_Check_Add_To_Cart_Link_And_Icon
    [Documentation]    Check if 'Lisää koriin' link and icon exist on the product page.
    [Tags]    AddToCart
    Go To    https://www.jimms.fi/fi/Product/Search?q=ps5
    Wait Until Page Contains Element    ${ADD_TO_CART_LINK}
    Capture Element Screenshot    ${ADD_TO_CART_ICON}    add_to_cart_icon.png
    Click Element    ${ADD_TO_CART_LINK}
   

*** Keywords ***

Input Text With Retry
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Wait Until Element Is Enabled    ${locator}    ${TIMEOUT}
    Input Text    ${locator}    ${text}

Wait For Page Load
    Wait For Condition    return document.readyState == "complete"    ${TIMEOUT}
