*** Comments ***
Nguyen Le Khang
Ilyas Oubousken

*** Settings ***
Library     SeleniumLibrary
Library     String
Library     XML


*** Variables ***
${website}    http://jimms.fi
${browser}    Chrome
${path}    C:\\Users\\dv213\\Desktop\\Software testing\\project
${searchElement}=       PS5


${email}    admintester123@gmail.com
${password}    StrongPass123!

*** Keywords ***
Add to Cart
    [Arguments]    ${cartAdd}
    Sleep    1s
    Run Keyword and Ignore Error    Scroll Element Into View    ${cartAdd}
    Sleep    1s
    Click Element    ${cartAdd}

*** Test Cases ***
TC1_product_categories
    Open Browser    ${website}    ${browser}
    Maximize Browser Window
    # Wait for the product categories to load
    Wait Until Page Contains Element    xpath:/html/body/header/div/div[1]/jim-drilldown-mega-menu/nav/ul/li/a    timeout=10s
    
    # Get the count of elements in the vertical path
    ${count}=    SeleniumLibrary.Get Element Count    xpath:/html/body/header/div/div[1]/jim-drilldown-mega-menu/nav/ul/li/a
    Log    Found ${count} categories.

    # Convert count to integer for comparison
    ${count_int}=    Convert To Integer    ${count}

    # Set the maximum categories to test
    ${max_categories}=    Set Variable    10

    FOR    ${index}    IN RANGE    1    ${max_categories}+1
        ${testElement}=    Set Variable    xpath:/html/body/header/div/div[1]/jim-drilldown-mega-menu/nav/ul/li[${index}]/a
        Log    Accessing category element: ${testElement}

        # Check if the element exists before getting the text
        ${text}=    SeleniumLibrary.Get Text    ${testElement}
        Log    Category text: ${text}

        # Check to make sure that each element has an 'href'
        ${testAttributes}=    SeleniumLibrary.Get Element Attribute    ${testElement}    href
        Should Not Be Empty    ${testAttributes}
        
        # Click the link to confirm
        Click Element    ${testElement}
        Sleep    1s  # Adjust sleep if necessary to allow for loading
    END
    
    Close Browser


*** Test Cases ***
TC2_Test_search_feature_in_Homepage
    Open Browser    ${website}    ${browser}
    Maximize Browser Window
    Click Element    xpath://*[@id="searchinput"] 
    Sleep    1s
    Input Text    name:q    ${searchElement}
    Sleep    2s
    Press Keys    name:q    ENTER
    Sleep    2s
    Click Element    //*[@id="productsearchpage"]/div[2]/div[5]/div/div[1]/product-box/div[2]/div[1]/a/div/img
    Sleep     2s
# take a screenshot from first product
    Set Screenshot Directory    ${path}
    Capture Element Screenshot    //*[@id="jim-product-gallery"]    
    Sleep    2s
# drill down to product page
    Click Element    //*[@id="jim-main"]/div[1]/div[1]/div/nav/ol/li[5]/a
    Sleep    2s
# check if product page what matches to keyword what was used in search
    Page Should Contain    ${searchElement}
    Sleep    2s

    Close Browser


*** Test Cases ***
TC3&4_Check_for_Link_AND_Icon_of_'Lisää koriin'
    Open Browser    https://www.jimms.fi/fi/Product/Show/150625/980-000814/logitech-z150-stereokaiuttimet-musta    ${browser}    
    Maximize Browser Window
    Sleep    2s
    Page Should Contain Link    //*[@id="product-cta-box"]/div/div[3]/div[2]/addto-cart-wrapper/div/a
    Sleep    1s

    Set Screenshot Directory    ${path}
    Capture Element Screenshot    //*[@id="product-cta-box"]/div/div[3]    
    Sleep    1s

    Close Browser


*** Test Cases ***
TC5_Add_Product_Into_Cart
    Open Browser    ${website}    ${browser}    
    Maximize Browser Window

    # Hover over the cart to show that the cart is empty.
    Sleep    1s
    Mouse Over    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    2s
    Mouse Out    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    1s
    
    Add to Cart    //*[@id="fp-suggestions-carousel2-slide06"]/div/product-box/div[2]/div[3]/addto-cart-wrapper
    Sleep    2s   
    # Hover mouse over the cart to check if the items have been added
    Mouse Over    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    2s
    Mouse Out     xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    1s  

    Close Browser


*** Test Cases ***
TC6_Add_Quantity_Function
    Open Browser    ${website}    ${browser}    
    Maximize Browser Window
    # Hover over the cart to show that the cart is empty.
    Sleep    1s
    Mouse Over    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    1s
    Mouse Out    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    1s
    
    Add to Cart    //*[@id="fp-suggestions-carousel2-slide06"]/div/product-box/div[2]/div[3]/addto-cart-wrapper
    Sleep    1s
    # Hover mouse over the cart to check if the items have been added
    Mouse Over    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    2s
    Click Element    //*[@id="jim-cart-dropdown"]
    Sleep    2s
    Click Element    //*[@id="jim-main"]/div/div/div/div[1]/article/div/div[2]/div/div[3]/div[1]/div/i[2]
    Sleep    1s
    Set Screenshot Directory    ${path}
    Capture Element Screenshot    //*[@id="jim-main"]/div/div/div/div[1]/article/div/div[2]
    Sleep    2s

    Close Browser


## TC6 Complete

*** Test Cases ***
TC7_Remove_Cart_Function
    Open Browser    ${website}    ${browser}    
    Maximize Browser Window
    Sleep    1s
    Add to Cart    //*[@id="fp-suggestions-carousel2-slide06"]/div/product-box/div[2]/div[3]/addto-cart-wrapper
    Sleep    1s
    Mouse Over    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    2s
    Click Element    //*[@id="headercartwarper"]/div/div[1]/article/div[2]/div[2]/div/span[1]
    Sleep    2s 
    Mouse Over    xpath:/html/body/header/div/div[3]/jim-cart-dropdown/div
    Sleep    2s
    Set Screenshot Directory    ${path}
    Capture Element Screenshot    //*[@id="jim-header"]/div/div[3]
    Sleep    1s

    Close Browser


*** Test Cases ***
TC8_Sorting_Function
    Open Browser    ${website}    ${browser}
    Maximize Browser Window
    Click Element    xpath://*[@id="searchinput"] 
    Sleep    1s
    Input Text    name:q    ${searchElement}
    Sleep    2s
    Press Keys    name:q    ENTER
    Sleep    2s
    Click Element    //*[@id="productlist-sorting"]/div
    Sleep     2s
    
    ## Check for name sorting order (A-Z)
    Click Element    //*[@id="productlist-sorting"]/div/ul/li[1]
    Sleep    3s
    
    Close Browser


*** Test Cases ***
TC9_Filter_Games
    Open Browser    ${website}    ${browser}
    Maximize Browser Window
    Click Element    xpath://*[@id="searchinput"] 
    Sleep    1s
    Input Text    name:q    ${searchElement}
    Sleep    2s
    Press Keys    name:q    ENTER
    Sleep    2s
    
    ## Filter Game results only
    Click Element    //*[@id="cFilterGroup"]/div/ul/li[3]/div/div/span[1]
    Sleep   4s
    
    Close Browser


*** Test Cases ***
TC10_Login_Function
    Open Browser    ${website}    ${browser}
    Maximize Browser Window
    Click Element    //*[@id="navcustomerwrapper"]/div/a
    Sleep    2s
    Click Element    //*[@id="l-UserName"] 
    Input Text    //*[@id="l-UserName"]    ${email}    # Input email into the username field
    Sleep    1s    
    Click Element    //*[@id="l-Password"]
    Input Text    //*[@id="l-Password"]    ${password}    # Input password into the password field
    Sleep    1s
    Click Element    //*[@id="loginbtn"]
    Sleep    4s

    Close Browser
