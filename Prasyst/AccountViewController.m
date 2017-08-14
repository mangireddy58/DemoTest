//
//  AccountViewController.m
//  Prasyst
//
//  Created by Sai on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.responseArray = self.objUniversalDataModel.accountsDataArray;
    self.accountTblView.dataSource = self;
    self.accountTblView.delegate = self;
    [self.accountTblView reloadData];
}

#pragma mark - Tableview Datasource & Delegate Methods.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.responseArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        return 120;
    }
    else
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    AccountCustomCell *cell = (AccountCustomCell *)[self.accountTblView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray * myNib;
        myNib =[[NSBundle mainBundle]loadNibNamed:@"AccountCustomCell" owner:self options:nil];
        cell = (AccountCustomCell *)[myNib lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewBtn.tag = indexPath.row;
    [cell.viewBtn addTarget:self action:@selector(viewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *dict = [self.responseArray objectAtIndex:indexPath.row];
    
    if([dict valueForKey:@"type"] != NULL)
        if([[dict valueForKey:@"type"] length] > 0)
            cell.dataNameLabel.text =  [dict valueForKey:@"type"];
    
    cell.amountTxtFld.text = @"0";
    if([dict valueForKey:@"amt"] != NULL)
        if([[dict valueForKey:@"amt"] integerValue] > 0)
            cell.amountTxtFld.text = [dict valueForKey:@"amt"];
    
    return cell;
}
- (void)viewButtonPressed:(UIButton *)sender {
    UIButton *viewButton = (UIButton *)sender;
   self.objUniversalDataModel.accountDictionary = [self.responseArray objectAtIndex:viewButton.tag];
    [self fnForAccountDetailViewController];
}
- (IBAction)backAction:(id)sender {
    [self fnForMainDashAsRootViewController];
}
@end
