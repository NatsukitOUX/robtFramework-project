
# E-commerce Website Testing Automation

## Project Overview

This project automates the testing of the e-commerce website [Jimms.fi](http://jimms.fi) using Robot Framework and SeleniumLibrary. It focuses on several key functionalities of the website, including searching for products, adding items to the cart, and validating specific features like product categories, sorting, and filtering.

## Authors
- Nguyen Le Khang
- Ilyas Oubousken

## Prerequisites

Before you begin, ensure you have the following installed:

- **Python 3.x**: Ensure you have Python installed. You can download it from [here](https://www.python.org/).
- **Robot Framework**: Install Robot Framework by running:
  ```bash
  pip install robotframework
  ```
- **SeleniumLibrary**: Install the Selenium Library:
  ```bash
  pip install robotframework-seleniumlibrary
  ```
- **WebDriver**: Download the appropriate WebDriver for your browser (Chrome, Firefox, etc.), and ensure it is added to your system's PATH.

## Project Structure

- **Test Scripts**: The test cases are written in the Robot Framework and stored in the project file.
- **Keywords**: Reusable keywords for different actions like adding items to the cart.
- **Variables**: Parameters such as the website URL, browser type, search keywords, and user credentials are defined as variables for easy updates.

## Test Cases

The project contains the following test cases:

1. **TC1_Product_Categories**
   - Verifies that the product categories are loaded correctly.
   - Clicks through a set number of categories to ensure each has a valid link.

2. **TC2_Test_Search_Feature_in_Homepage**
   - Tests the search functionality on the homepage.
   - Verifies that the search results contain the correct product.

3. **TC3&4_Check_for_Link_AND_Icon_of_'Lisää_koriin'**
   - Validates that the 'Add to Cart' link and icon are displayed correctly on a specific product page.

4. **TC5_Add_Product_Into_Cart**
   - Adds a product to the cart and verifies that the product is successfully added.

5. **TC6_Add_Quantity_Function**
   - Tests the quantity update function in the shopping cart.

6. **TC7_Remove_Cart_Function**
   - Removes an item from the cart and verifies that the cart is empty.

7. **TC8_Sorting_Function**
   - Tests the sorting functionality of the product search results (A-Z).

8. **TC9_Filter_Games**
   - Filters search results to show only gaming products.

9. **TC10_Login_Function**
   - Automates the login process by entering valid credentials.

## Usage

### Running the Test Suite

To run the tests, follow these steps:

1. Open your terminal.
2. Navigate to the project directory where your `.robot` files are stored.
3. Run the following command to execute all test cases:
   ```bash
   robot <your-test-file.robot>
   ```

Example:
```bash
robot ecom_website_tests.robot
```

### Screenshots

The test cases capture screenshots at various points in the process. These screenshots are saved in the directory specified by the `${path}` variable.

### Test Variables

Variables used in the tests:
- **${website}**: The URL of the e-commerce website to be tested.
- **${browser}**: The browser to be used for testing (default is Chrome).
- **${searchElement}**: The search keyword (e.g., "PS5").
- **${email}**: User email for login functionality.
- **${password}**: Password for login functionality.

You can modify the variables to suit your needs.

## Keywords

### Add to Cart
Custom keyword to add products to the shopping cart.
```robot
Add to Cart
    [Arguments]    ${cartAdd}
    Run Keyword and Ignore Error    Scroll Element Into View    ${cartAdd}
    Click Element    ${cartAdd}
```

## Test Reports

After running the tests, Robot Framework will automatically generate a report and log file. These can be found in the current working directory:
- **report.html**: Contains a summary of the test results.
- **log.html**: Provides detailed logs for each test case execution.

## Contributing

Feel free to submit issues, feature requests, or contribute to the project by creating pull requests.

## License

This project is licensed under the MIT License.
