*** Settings ***
Documentation     Login tests for SauceDemo using reusable resource keywords.
...               Demonstrates importing resources, data-driven testing with
...               [Template], and both positive and negative test cases.
Library           Browser
Resource          ../../resources/common.resource
Resource          ../../resources/login_page.resource

Suite Setup       Open SauceDemo
Suite Teardown    Close SauceDemo

*** Test Cases ***
Valid Login With Standard User
    [Documentation]    Verify that standard_user can log in successfully.
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Login Should Succeed
    # Navigate back to login for next tests
    Go To    ${BASE_URL}

Login With Invalid Password Should Fail
    [Documentation]    Verify that wrong password shows an error message.
    Login With Credentials    ${VALID_USER}    wrong_password
    Login Should Fail With Message    Username and password do not match

Login With Empty Username Should Fail
    [Documentation]    Verify that empty username shows an error message.
    Login With Credentials    ${EMPTY}    ${VALID_PASSWORD}
    Login Should Fail With Message    Username is required

Login With Empty Password Should Fail
    [Documentation]    Verify that empty password shows an error message.
    Login With Credentials    ${VALID_USER}    ${EMPTY}
    Login Should Fail With Message    Password is required

Locked Out User Should See Error
    [Documentation]    Verify that locked_out_user cannot log in.
    Login With Credentials    locked_out_user    ${VALID_PASSWORD}
    Login Should Fail With Message    this user has been locked out

*** Keywords ***
# This section is empty here because we import keywords from resources.
# You could define test-specific keywords here if needed.
