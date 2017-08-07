//
//  GlobalConstant.h
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#ifndef GlobalConstant_h
#define GlobalConstant_h




#define IS_IPHONE  [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
#define IS_IPAD    [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad

#define VIEWHEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define VIEWWIDTH        ([[UIScreen mainScreen] bounds].size.width)


#pragma mark - Service timeout interval
#define SERVICE_TIMEOUT 60.0

#define STATUS_BAR_HEIGHT 0//20
//Menu Cell Height
#define SM_IPHONE5ABOVE 58
#define SM_IPHONE5BELOW 52

#define SM_USER_IPHONE5ABOVE 240
#define SM_USER_IPHONE5BELOW 180


#define kMobileNumberLimit 10
#define ALLOWED_CHARACTERS [[NSCharacterSet letterCharacterSet] invertedSet]
#define ALLOWED_NUMBERS [[NSCharacterSet decimalDigitCharacterSet] invertedSet]

#pragma mark - Base URL's
//Development
#define BASE_URL @""

#pragma mark - DB
#define DB_NAME @"mexictfp_cloud"
#define SQL_NAME @"sql"

#pragma mark - ServiceNames

#define LOGIN_URL         @"GetValues.php"
#define GET_DATA_URL      @"GetValues.php"
#define INVENTORY_URL     @"GetValues.php"
#define INVENTORY_DETAILS_URL @"GetWeb.php"
#define ACCOUNT_DETAILS_URL @"GetWeb.php"

#define SORT_BY_BRANCH_URL @"GetValues.php"
#define SORT_BY_COMPANY_URL @"GetValues.php"
#define SORT_BY_CATEGORY_URL @"GetWeb.php"
#define SORT_BY_DATE_ASC_URL @"GetWeb.php"
#define SORT_BY_DATE_DESC_URL @"GetWeb.php"
#define SORT_BY_PARTY_NAME_URL @"GetWeb.php"

#pragma mark - Parameters
#define SERVICE_PARAMS     @"{\"sql\": \"%@\",\"db\": \"%@\"}"

#pragma mark - Queries
#define LOGIN_QUERY    @"select id, name, password, status, imei from customer where mobile=%@"

#define GET_DATA_QUERY @"SELECT count(*) as count FROM datasync where client_key=%lu and doc_date between date('%@') and date('%@')"

#define INVENTORY_QUERY @"SELECT TRANSACTION_TYPE as 'type', SUM(QTY) as 'qty', SUM(AMOUNT) as 'amt' FROM datasync WHERE client_key=%lu and DOC_DATE BETWEEN date('%@') AND date('%@') group by TRANSACTION_TYPE"

#define INVENTORY_DETAILS_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')"

#define ACCOUNT_DETAILS_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')"

#define SORT_BY_BRANCH_INVENTORY_QUERY @"SELECT sum(QTY) as 'qty', sum(AMOUNT) as 'amt', cobr_name as 'branch' FROM datasync where transaction_type='%@' and client_key=%lu and DOC_DATE BETWEEN date('%@') AND date('%@') group by cobr_name\\nselect distinct cobr_name as 'branch' from datasync where client_key=%lu"

#define SORT_BY_BRANCH_ACCOUNT_QUERY @"SELECT sum(QTY) as 'qty', sum(AMOUNT) as 'amt', cobr_name as 'branch' FROM datasync where transaction_type='%@' and client_key=%lu and DOC_DATE BETWEEN date('%@') AND date('%@') group by cobr_name\\nselect distinct cobr_name as 'branch' from datasync where client_key=%lu"

#define SORT_BY_COMPANY_IVENTORY_QUERY @"SELECT sum(QTY) as 'qty', sum(AMOUNT) as 'amt', co_name as 'company' FROM datasync where transaction_type='%@' and client_key=%lu and DOC_DATE BETWEEN date('%@') AND date('%@') group by co_name\\nselect distinct co_name as 'company' from datasync where client_key=%lu"

#define SORT_BY_COMPANY_ACCOUNT_QUERY @"SELECT sum(QTY) as 'qty', sum(AMOUNT) as 'amt', co_name as 'company' FROM datasync where transaction_type='%@' and client_key=%lu and DOC_DATE BETWEEN date('%@') AND date('%@') group by co_name\\nselect distinct co_name as 'company' from datasync where client_key=%lu"

#define SORT_BY_CATEGORY_INVENTORY_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@') order by category"


#define SORT_BY_CATEGORY_ACCOUNT_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by category"

#define SORT_BY_DATE_ASC_INVENTORY_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by doc_date asc"

#define SORT_BY_DATE_ASC_ACCOUNT_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by doc_date asc"

#define SORT_BY_DATE_DESC_INVENTORY_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by doc_date desc"

#define SORT_BY_DATE_DESC_ACCOUNT_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by doc_date desc"

#define SORT_BY_PARTY_NAME_INVENTORY_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by party_name"

#define SORT_BY_PARTY_NAME_ACCOUNT_QUERY @"select doc_no as 'Doc No', date_format(doc_date,'%@') as 'Doc Date', Category, party_name as 'Party Name', qty as 'Quantity', Amount FROM datasync where TRANSACTION_TYPE='%@' and client_key=%lu AND DOC_DATE BETWEEN date('%@') AND date('%@')order by party_name"


#pragma mark - Service Names and its Tags
typedef NS_ENUM(NSInteger, serviceURLTags) {
    login_url_tag = 501,
    get_data_url_tag,
    inventory_url_tag,
    account_url_tag,
    inventory_details_tag,
    account_details_tag,
    sort_by_branch_url_tag,
    sort_by_company_url_tag,
    sort_by_category_url_tag,
    sort_by_date_asc_url_tag,
    sort_by_date_desc_url_tag,
    sort_by_party_name_url_tag
};
#pragma mark - Menu
typedef enum
{
    Unregister=0,
    LogOut
}menu;

#pragma mark - Font

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define FONTNAME_LIGHT @"AppleSDGothicNeo-Regular"
#define FONTNAME_BOLD @"AppleSDGothicNeo-Bold"


#define LFONT_40     [UIFont fontWithName:FONTNAME_LIGHT size:40]
#define LFONT_39     [UIFont fontWithName:FONTNAME_LIGHT size:39]
#define LFONT_38     [UIFont fontWithName:FONTNAME_LIGHT size:38]
#define LFONT_37     [UIFont fontWithName:FONTNAME_LIGHT size:37]
#define LFONT_36     [UIFont fontWithName:FONTNAME_LIGHT size:36]
#define LFONT_35     [UIFont fontWithName:FONTNAME_LIGHT size:35]
#define LFONT_34     [UIFont fontWithName:FONTNAME_LIGHT size:34]
#define LFONT_33     [UIFont fontWithName:FONTNAME_LIGHT size:33]
#define LFONT_32     [UIFont fontWithName:FONTNAME_LIGHT size:32]
#define LFONT_31     [UIFont fontWithName:FONTNAME_LIGHT size:31]
#define LFONT_30     [UIFont fontWithName:FONTNAME_LIGHT size:30]
#define LFONT_29     [UIFont fontWithName:FONTNAME_LIGHT size:29]
#define LFONT_28     [UIFont fontWithName:FONTNAME_LIGHT size:28]
#define LFONT_27     [UIFont fontWithName:FONTNAME_LIGHT size:27]
#define LFONT_26     [UIFont fontWithName:FONTNAME_LIGHT size:26]
#define LFONT_25     [UIFont fontWithName:FONTNAME_LIGHT size:25]
#define LFONT_24     [UIFont fontWithName:FONTNAME_LIGHT size:24]
#define LFONT_23     [UIFont fontWithName:FONTNAME_LIGHT size:23]
#define LFONT_22     [UIFont fontWithName:FONTNAME_LIGHT size:22]
#define LFONT_21     [UIFont fontWithName:FONTNAME_LIGHT size:21]
#define LFONT_20     [UIFont fontWithName:FONTNAME_LIGHT size:20]
#define LFONT_19     [UIFont fontWithName:FONTNAME_LIGHT size:19]
#define LFONT_18     [UIFont fontWithName:FONTNAME_LIGHT size:18]
#define LFONT_17     [UIFont fontWithName:FONTNAME_LIGHT size:17]
#define LFONT_16     [UIFont fontWithName:FONTNAME_LIGHT size:16]
#define LFONT_15     [UIFont fontWithName:FONTNAME_LIGHT size:15]
#define LFONT_14     [UIFont fontWithName:FONTNAME_LIGHT size:14]
#define LFONT_13     [UIFont fontWithName:FONTNAME_LIGHT size:13]
#define LFONT_12     [UIFont fontWithName:FONTNAME_LIGHT size:12]
#define LFONT_11     [UIFont fontWithName:FONTNAME_LIGHT size:11]
#define LFONT_10     [UIFont fontWithName:FONTNAME_LIGHT size:10]
#define LFONT_9     [UIFont fontWithName:FONTNAME_LIGHT size:9]
#define LFONT_8     [UIFont fontWithName:FONTNAME_LIGHT size:8]

#define BFONT_40     [UIFont fontWithName:FONTNAME_BOLD size:40]
#define BFONT_39     [UIFont fontWithName:FONTNAME_BOLD size:39]
#define BFONT_38     [UIFont fontWithName:FONTNAME_BOLD size:38]
#define BFONT_37     [UIFont fontWithName:FONTNAME_BOLD size:37]
#define BFONT_36     [UIFont fontWithName:FONTNAME_BOLD size:36]
#define BFONT_35     [UIFont fontWithName:FONTNAME_BOLD size:35]
#define BFONT_34     [UIFont fontWithName:FONTNAME_BOLD size:34]
#define BFONT_33     [UIFont fontWithName:FONTNAME_BOLD size:33]
#define BFONT_32     [UIFont fontWithName:FONTNAME_BOLD size:32]
#define BFONT_31     [UIFont fontWithName:FONTNAME_BOLD size:31]
#define BFONT_30     [UIFont fontWithName:FONTNAME_BOLD size:30]
#define BFONT_29     [UIFont fontWithName:FONTNAME_BOLD size:29]
#define BFONT_28     [UIFont fontWithName:FONTNAME_BOLD size:28]
#define BFONT_27     [UIFont fontWithName:FONTNAME_BOLD size:27]
#define BFONT_26     [UIFont fontWithName:FONTNAME_BOLD size:26]
#define BFONT_25     [UIFont fontWithName:FONTNAME_BOLD size:25]
#define BFONT_24     [UIFont fontWithName:FONTNAME_BOLD size:24]
#define BFONT_23     [UIFont fontWithName:FONTNAME_BOLD size:23]
#define BFONT_22     [UIFont fontWithName:FONTNAME_BOLD size:22]
#define BFONT_21     [UIFont fontWithName:FONTNAME_BOLD size:21]
#define BFONT_20     [UIFont fontWithName:FONTNAME_BOLD size:20]
#define BFONT_19     [UIFont fontWithName:FONTNAME_BOLD size:19]
#define BFONT_18     [UIFont fontWithName:FONTNAME_BOLD size:18]
#define BFONT_17     [UIFont fontWithName:FONTNAME_BOLD size:17]
#define BFONT_16     [UIFont fontWithName:FONTNAME_BOLD size:16]
#define BFONT_15     [UIFont fontWithName:FONTNAME_BOLD size:15]
#define BFONT_14     [UIFont fontWithName:FONTNAME_BOLD size:14]
#define BFONT_13     [UIFont fontWithName:FONTNAME_BOLD size:13]
#define BFONT_12     [UIFont fontWithName:FONTNAME_BOLD size:12]
#define BFONT_11     [UIFont fontWithName:FONTNAME_BOLD size:11]
#define BFONT_10     [UIFont fontWithName:FONTNAME_BOLD size:10]
#define BFONT_9     [UIFont fontWithName:FONTNAME_BOLD size:9]
#define BFONT_8     [UIFont fontWithName:FONTNAME_BOLD size:8]


#endif /* GlobalConstant_h */
