//
//  SortByCompanyViewController.m
//  Prasyst
//
//  Created by Sai on 31/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "SortByCompanyViewController.h"

@interface SortByCompanyViewController ()

@end

@implementation SortByCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.objUniversalDataModel.sortingString isEqualToString:INVENTORY_SORT_BY_BRANCH]) {
        self.sortingNameLbl.text = @"Sort by branch";
        NSLog(@"INVENTORY_SORT_BY_BRANCH %@",self.objUniversalDataModel.soryByBranchDataArray);
        self.sortingResponseArray = self.objUniversalDataModel.soryByBranchDataArray;
        self.branchArray = [[NSMutableArray alloc]init];
        NSArray *array1Res = [self.sortingResponseArray objectAtIndex:0];
//        NSArray *array2Res = [self.sortingResponseArray objectAtIndex:1];
        self.amtArray = [[NSMutableArray alloc]init];
        self.qtyArray = [[NSMutableArray alloc]init];
        for(NSDictionary *dic in array1Res) {
            [dic valueForKey:@"amt"]?[self.amtArray addObject:[dic valueForKey:@"amt"]]:[self.amtArray addObject:@"0"];
            [dic valueForKey:@"qty"]?[self.qtyArray addObject:[dic valueForKey:@"qty"]]:[self.qtyArray addObject:@"0"];
            [dic valueForKey:@"branch"]?[self.branchArray addObject:[dic valueForKey:@"branch"]]:[self.branchArray addObject:@"0"];
        }
    }
    else if ([self.objUniversalDataModel.sortingString isEqualToString:INVENTORY_SORT_BY_COMPANY]) {
        self.sortingNameLbl.text = @"Sort by company";
        NSLog(@"INVENTORY_SORT_BY_COMPANY %@",self.objUniversalDataModel.soryByCompanyDataArray);
        self.sortingResponseArray = self.objUniversalDataModel.soryByCompanyDataArray;
        self.branchArray = [[NSMutableArray alloc]init];
        NSArray *array1Res = [self.sortingResponseArray objectAtIndex:0];
//        NSArray *array2Res = [self.sortingResponseArray objectAtIndex:1];
        self.amtArray = [[NSMutableArray alloc]init];
        self.qtyArray = [[NSMutableArray alloc]init];
        for(NSDictionary *dic in array1Res) {
            [dic valueForKey:@"amt"]?[self.amtArray addObject:[dic valueForKey:@"amt"]]:[self.amtArray addObject:@"0"];
            [dic valueForKey:@"qty"]?[self.qtyArray addObject:[dic valueForKey:@"qty"]]:[self.qtyArray addObject:@"0"];
            [dic valueForKey:@"company"]?[self.branchArray addObject:[dic valueForKey:@"company"]]:[self.branchArray addObject:@"0"];
            
        }
    }
    else if ([self.objUniversalDataModel.sortingString isEqualToString:ACCOUNT_SORT_BY_BRANCH]) {
        NSLog(@"ACCOUNT_SORT_BY_BRANCH %@",self.objUniversalDataModel.soryByBranchDataArray);
        self.sortingNameLbl.text = @"Sort by branch";
        self.sortingNameLbl.text = @"Sort by branch";
        self.sortingResponseArray = self.objUniversalDataModel.soryByBranchDataArray;
        self.branchArray = [[NSMutableArray alloc]init];
        NSArray *array1Res = [self.sortingResponseArray objectAtIndex:0];
//        NSArray *array2Res = [self.sortingResponseArray objectAtIndex:1];
        self.amtArray = [[NSMutableArray alloc]init];
        self.qtyArray = [[NSMutableArray alloc]init];
        for(NSDictionary *dic in array1Res) {
            [dic valueForKey:@"amt"]?[self.amtArray addObject:[dic valueForKey:@"amt"]]:[self.amtArray addObject:@"0"];
            [dic valueForKey:@"qty"]?[self.qtyArray addObject:[dic valueForKey:@"qty"]]:[self.qtyArray addObject:@"0"];
            [dic valueForKey:@"branch"]?[self.branchArray addObject:[dic valueForKey:@"branch"]]:[self.branchArray addObject:@"0"];
        }
    }
    else if ([self.objUniversalDataModel.sortingString isEqualToString:ACCOUNT_SORT_BY_COMPANY]) {
        NSLog(@"ACCOUNT_SORT_BY_COMAPNY  %@",self.objUniversalDataModel.soryByCompanyDataArray);
        self.sortingResponseArray = self.objUniversalDataModel.soryByCompanyDataArray;
        self.branchArray = [[NSMutableArray alloc]init];
        NSArray *array1Res = [self.sortingResponseArray objectAtIndex:0];
//        NSArray *array2Res = [self.sortingResponseArray objectAtIndex:1];
        self.amtArray = [[NSMutableArray alloc]init];
        self.qtyArray = [[NSMutableArray alloc]init];
        for(NSDictionary *dic in array1Res) {
            [dic valueForKey:@"amt"]?[self.amtArray addObject:[dic valueForKey:@"amt"]]:[self.amtArray addObject:@"0"];
            [dic valueForKey:@"qty"]?[self.qtyArray addObject:[dic valueForKey:@"qty"]]:[self.qtyArray addObject:@"0"];
            [dic valueForKey:@"company"]?[self.branchArray addObject:[dic valueForKey:@"company"]]:[self.branchArray addObject:@"0"];
            
        }
    }
    self.sortTblView.dataSource = self;
    self.sortTblView.delegate = self;
    [self.sortTblView reloadData];
    [self loadInputViews];
}
- (void)loadInputViews {
    [self addProgressIndicator];
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.sortingNameLbl.font = BFONT_13;
            self.allLbl.font = LFONT_13;
        }
            break;
        case 2:{
            self.sortingNameLbl.font = BFONT_15;
            self.allLbl.font = LFONT_15;
        }
            break;
        default:{
            self.sortingNameLbl.font = BFONT_17;
            self.allLbl.font = LFONT_17;
            break;
        }
    }
    
}
#pragma mark - Tableview Datasource & Delegate Methods.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.branchArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        return 80;
    }
    else
        return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    SortByTableViewCell *cell = (SortByTableViewCell *)[self.sortTblView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray * myNib;
        myNib =[[NSBundle mainBundle]loadNibNamed:@"SortByTableViewCell" owner:self options:nil];
        cell = (SortByTableViewCell *)[myNib lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    cell.typeNameLbl.text = [self.branchArray objectAtIndex:indexPath.row];
    cell.amountQtyLbl.text = [[@"Qty: " stringByAppendingString:[self.qtyArray objectAtIndex:indexPath.row]] stringByAppendingString:[@", Amt:" stringByAppendingString:[self.amtArray objectAtIndex:indexPath.row]]];
    /* for (NSDictionary *dic2 in array2Res) {
     NSLog(@"dic is %@",dic2);
     [dic2 valueForKey:@"amt"]?[amtArray addObject:[dic2 valueForKey:@"amt"]]:[amtArray addObject:@"0"];
     [dic2 valueForKey:@"qty"]?[qtyArray addObject:[dic2 valueForKey:@"qty"]]:[qtyArray addObject:@"0"];
     // array2 = [[NSMutableArray alloc] initWithArray:[array2 arrayByAddingObject:[dic valueForKey:@"branch"]]];
     //[array2 addObject:[dic valueForKey:@"branch"]];
     }
     [amtArray addObjectsFromArray:qtyArray];
     NSLog(@"Array 1 is %@",amtArray);
    
    cell.typeNameLbl.text = [dict valueForKey:@"branch"];
        cell.amountQtyLbl.text = [NSString stringWithFormat:@"Qty=%@,Amt=%@",[dict objectForKey:@"qty"],[dict objectForKey:@"amt"]];;
    
        if([dict objectForKey:@"branch"] != NULL)
            if([[dict objectForKey:@"branch"] length] > 0)
                cell.typeNameLbl.text = [dict objectForKey:@"branch"];*/
    
    
    [self hideProgressIndicator];
    return cell;
    
}


- (IBAction)dismissBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
