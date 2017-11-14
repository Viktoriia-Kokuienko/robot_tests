*** Settings ***
Resource        base_keywords.robot
Resource        resource.robot
Suite Setup     Test Suite Setup
Suite Teardown  Test Suite Teardown
Library         Selenium2Library

*** Variables ***
@{USED_ROLES}  tender_owner  viewer  provider  provider1  provider2
${dutch_amount}  xpath=(//div[@id='stage-sealedbid-dutch-winner']//span[@class='label-price ng-binding'])
${sealedbid_amount}  xpath=(//div[contains(concat(' ', normalize-space(@class), ' '), ' sealedbid-winner ')]//span[@class='label-price ng-binding'])


*** Test Cases ***
Possibility to find a tender by identificator
  [Tags]   ${USERS.users['${viewer}'].broker}: Пошук тендера
  ...      tender_owner  viewer  provider  provider1  provider2
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      ${USERS.users['${provider2}'].broker}
  ...      ${USERS.users['${tender_owner}'].broker}
  ...      find_tender
  Завантажити дані про тендер
  Possibility to find a tender by identificator for all users


Viewing of initial lot value
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view
  [Setup]  Wait for platform synchronization  ${viewer}
  Retrieve data from tender field value.amount for all users


Viewing of lot type
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view
  Retrieve data from tender field procurementMethodType for all users


Viewing of tender period end date of the lot
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних лоту
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view_tenderPeriod  level2
  Retrieve data from tender field tenderPeriod.endDate for all users

##############################################################################################
#             AUCTION
##############################################################################################

Viewing of auction start date
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view
  [Teardown]  Update LAST_MODIFICATION_DATE
  Wait until auction period start date  ${viewer}  ${TENDER['TENDER_UAID']}
  Retrieve tender data  ${viewer}  ${TENDER['TENDER_UAID']}  auctionPeriod.startDate  ${TENDER['LOT_ID']}


Possibility to wait until auction starts
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      auction
  [Setup]  Wait for platform synchronization  ${viewer}
  Wait until auction period start date  ${viewer}  ${TENDER['TENDER_UAID']}


Possibility to wait until dutch auction starts
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      auction
  Дочекатись завершення паузи перед першим раундом


Possibility to register a bid by provider1
  [Tags]   ${USERS.users['${provider1}'].broker}: Подання пропозиції
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_before_dutch  level1
  [Teardown]  Update LAST_MODIFICATION_DATE
  Можливість подати цінову пропозицію користувачем ${provider1}


Possibility to upload financial license to the bid by provider1
  [Tags]   ${USERS.users['${provider1}'].broker}: Подання пропозиції
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_before_dutch
  [Setup]  Wait for platform synchronization  ${provider1}
  [Teardown]  Update LAST_MODIFICATION_DATE
  Можливість завантажити фінансову ліцензію в пропозицію користувачем ${provider1}


Possibility to participate in the auction by provider1
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_before_dutch
  Possibility to retrieve auction link for ${provider1}
  Відкрити сторінку аукціону для ${provider1}


Possibility to register a bid by provider
  [Tags]   ${USERS.users['${provider}'].broker}: Процес аукціону
  ...      provider
  ...      ${USERS.users['${provider}'].broker}
  ...      auction
  Переключитись на учасника  ${provider}
  Зробити заявку


Possibility to register a bid by provider1 after dutch auction winner is defined
  [Tags]   ${USERS.users['${provider1}'].broker}: Подання пропозиції
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_after_dutch  level1
  [Teardown]  Update LAST_MODIFICATION_DATE
  Можливість подати цінову пропозицію користувачем ${provider1}


Possibility to upload financial license to the bid by provider1
  [Tags]   ${USERS.users['${provider1}'].broker}: Подання пропозиції
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_after_dutch
  [Setup]  Wait for platform synchronization  ${provider1}
  [Teardown]  Update LAST_MODIFICATION_DATE
  Можливість завантажити фінансову ліцензію в пропозицію користувачем ${provider1}


Possibility to participate in the auction by provider1 after dutch auction winner is defined
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_after_dutch
  Possibility to retrieve auction link for ${provider1}
  Відкрити сторінку аукціону для ${provider1}


Possibility to wait until Sealed Bid part starts
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      auction
  [Teardown]  Update LAST_MODIFICATION_DATE
  Дочекатись дати закінчення прийому пропозицій  ${provider1}  ${TENDER['TENDER_UAID']}
  Дочекатись завершення паузи перед Sealed Bid етапом


Possibility to register a bid by provider1
  [Tags]   ${USERS.users['${provider1}'].broker}: Процес аукціону
  ...      provider1
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_provider1_during_sealedbid
  Переключитись на учасника  ${provider1}
  Подати більшу ставку, ніж переможець голландської частини


possibility to wait until Best Bid part starts
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer  provider  provider1
  ...      ${USERS.users['${viewer}'].broker}
  ...      ${USERS.users['${provider}'].broker}
  ...      ${USERS.users['${provider1}'].broker}
  ...      make_bid_by_dutch_winner
  Дочекатись паузи перед Best Bid етапом
  Дочекатись завершення паузи перед Best Bid етапом


Possibility to increase a bid by dutch auction winner
  [Tags]   ${USERS.users['${provider}'].broker}: Процес аукціону
  ...      provider
  ...      ${USERS.users['${provider}'].broker}
  ...      make_bid_by_dutch_winner
  Переключитись на учасника   ${provider}
  Підвищити ставку переможцем голландської частини


Possibility to wait until auction end
  [Tags]   ${USERS.users['${viewer}'].broker}: Процес аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      auction
  [Teardown]  Update LAST_MODIFICATION_DATE
  Дочекатись дати закінчення аукціону


Viewing of auction period end date
  [Tags]   ${USERS.users['${viewer}'].broker}: Відображення основних даних аукціону
  ...      viewer
  ...      ${USERS.users['${viewer}'].broker}
  ...      tender_view
  [Setup]  Wait for platform synchronization  ${viewer}
  Retrieve tender data  ${viewer}  ${TENDER['TENDER_UAID']}  auctionPeriod.endDate  ${TENDER['LOT_ID']}


*** Keywords ***
Дочекатись дати початку аукціону
  [Arguments]  ${username}
  ${auctionStart}=  Retrieve tender data   ${username}  ${TENDER['TENDER_UAID']}   auctionPeriod.startDate  ${TENDER['LOT_ID']}
  wait_and_write_to_console  ${auctionStart}
  Update LAST_MODIFICATION_DATE
  Wait for platform synchronization  ${username}


Можливість вичитати посилання на аукціон для ${username}
  ${url}=  Run Keyword If  '${username}' == '${viewer}'  Run As  ${viewer}  Retrieve auction link for viewer  ${TENDER['TENDER_UAID']}  ${TENDER['LOT_ID']}
  ...      ELSE  Run As  ${username}  Retrieve auction link for provider  ${TENDER['TENDER_UAID']}  ${TENDER['LOT_ID']}
  Should Be True  '${url}'
  Should Match Regexp  ${url}  ^https?:\/\/auction(?:-sandbox)?\.ea\.openprocurement\.org\/insider-auctions\/([0-9A-Fa-f]{32})
  Log  URL: ${url}
  [return]  ${url}


Відкрити сторінку аукціону для ${username}
  ${url}=  Possibility to retrieve auction link for ${username}
  Open browser  ${url}  ${USERS.users['${username}'].browser}  ${username}
  Set Window Position  @{USERS['${username}']['position']}
  Set Window Size      @{USERS['${username}']['size']}
  Capture Page Screenshot
  Run Keyword Unless  '${username}' == '${viewer}'
  ...      Run Keywords
  ...      Wait Until Page Contains       Дякуємо за використання
  ...      AND
  ...      Click Element                  confirm
  Capture Page Screenshot


Дочекатись завершення паузи перед першим раундом
  Відкрити сторінку аукціону для ${viewer}
  Дочекатись завершення паузи перед першим раундом для користувачів


Дочекатись дати закінчення аукціону
  Переключитись на учасника  ${viewer}
  Wait Until Keyword Succeeds  61 times  30 s  Page should contain  Аукціон завершився


Дочекатись паузи перед ${stage_name} етапом
  Переключитись на учасника  ${viewer}
  Wait Until Page Contains  → ${stage_name}  15 min
  :FOR    ${username}    IN    ${provider}  ${provider1}
  \   Переключитись на учасника   ${username}
  \   Wait Until Page Contains  → ${stage_name}  30 s


Дочекатись завершення паузи перед ${stage_name} етапом
  Переключитись на учасника  ${viewer}
  Wait Until Page Does Not Contain  → ${stage_name}  15 min
  :FOR    ${username}    IN    ${provider}  ${provider1}
  \   Переключитись на учасника   ${username}
  \   Wait Until Page Does Not Contain  → ${stage_name}  30 s


Дочекатись завершення паузи перед першим раундом для користувачів
  Відкрити сторінку аукціону для ${provider}
  Переключитись на учасника  ${viewer}
  Wait Until Page Does Not Contain  → Голландського  2 min
  Переключитись на учасника  ${provider}
  Wait Until Page Does Not Contain  → Голландського  30 s


Переключитись на учасника
  [Arguments]  ${username}
  Switch Browser  ${username}


Зробити заявку
  Wait Until Element Is Visible  id=place-bid-button  2 min
  Click Element  id=place-bid-button
  Wait Until Page Contains  Ви


Подати більшу ставку, ніж переможець голландської частини
  Поставити ставку  1  Заявку прийнято  ${dutch_amount}


Підвищити ставку переможцем голландської частини
  Поставити ставку  1  Заявку прийнято  ${sealedbid_amount}


Поставити ставку
  [Arguments]  ${step}  ${msg}  ${locator}
  Wait Until Page Contains Element  ${locator}
  ${last_amount}=  Get Text  ${locator}
  ${last_amount}=  convert_amount_string_to_float  ${last_amount}
  ${amount}=  Evaluate  ${last_amount}+${step}
  ${input_amount}=  Convert To String  ${amount}
  Input Text  id=bid-amount-input  ${input_amount}
  Capture Page Screenshot
  Click Element  id=place-bid-button
  Wait Until Page Contains  ${msg}  10s
  Capture Page Screenshot
