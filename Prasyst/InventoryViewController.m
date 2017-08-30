//
//  InventoryViewController.m
//  Prasyst
//
//  Created by Rushikesh Kulkarni on 17/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "InventoryViewController.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInputViews];
    
    self.responseArray = self.objUniversalDataModel.inventoryDataArray;
    
    NSLog(@"Inventory data %@", self.responseArray);
    
    self.inventoryTblView.dataSource = self;
    self.inventoryTblView.delegate = self;
    [self.inventoryTblView reloadData];
}
- (void) loadInputViews {
    [self addProgressIndicator];
    [self hideProgressIndicator];
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.headerNameLbl.font = BFONT_13;
        }
            break;
        case 2:{
            self.headerNameLbl.font = LFONT_15;
        }
            break;
        default:{
            self.headerNameLbl.font = LFONT_17;
        }
            break;
    }
}
#pragma mark - Tableview Datasource & Delegate Methods.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return inventoryArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        return 116;
    }
    else
        return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    InventoryCustomCell *cell = (InventoryCustomCell *)[self.inventoryTblView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray * myNib;
        myNib =[[NSBundle mainBundle]loadNibNamed:@"InventoryCustomCell" owner:self options:nil];
        cell = (InventoryCustomCell *)[myNib lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewBtn.tag = indexPath.row;
    [cell.viewBtn addTarget:self action:@selector(viewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.inventoryNameLabel.text = [inventoryArray objectAtIndex:indexPath.row];
    cell.amountTxtFld.text = @"0";
    cell.quantityTxtFld.text = @"0";
    
    NSString *stringName = [[[inventoryArray objectAtIndex:indexPath.row] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    for (NSDictionary *dict in self.responseArray) {
        if([dict valueForKey:@"type"] != NULL)
            if([[dict valueForKey:@"type"] length] > 0){
                if([[[dict valueForKey:@"type"] lowercaseString] isEqualToString:stringName]){
                    if([dict valueForKey:@"amt"] != NULL)
                        if([[dict valueForKey:@"amt"] integerValue] > 0)
                            cell.amountTxtFld.text = [dict valueForKey:@"amt"];
                    
                    if([dict valueForKey:@"qty"] != NULL)
                        if([[dict valueForKey:@"qty"] integerValue] > 0)
                            cell.quantityTxtFld.text = [dict valueForKey:@"qty"];
                }
            }
    }
    
    return cell;
}

- (void) viewButtonPressed:(UIButton *)sender {
    UIButton *viewButton = (UIButton *)sender;
    bool isValFound = false;
    int i=-1;
    NSString *stringName = [inventoryArray objectAtIndex:viewButton.tag];
    for(NSDictionary *dic in self.responseArray){
        i++;
        if([[[dic valueForKey:@"type"] lowercaseString] isEqualToString:[[stringName lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""]]){
            NSLog(@"Succes value there");
            isValFound = true;
            self.objUniversalDataModel.inventoryDictionary = [self.responseArray objectAtIndex:i];
            
        }else{
            NSLog(@"Succes value not there");
            NSDictionary *dic = [[NSDictionary alloc] init];
            if(!isValFound){
                dic = @{@"type":stringName,@"amt":@"0",@"qty":@"0"};
                self.objUniversalDataModel.inventoryDictionary = dic;
            }else{
                
            }
        }
    }
    [self fnForinventoryDetailViewController];
    
}



- (IBAction)backBtnAction:(id)sender {
    [self fnForMainDashAsRootViewController];
}
@end
