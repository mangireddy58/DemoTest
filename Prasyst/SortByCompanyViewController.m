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
    
    self.sortingResponseArray = self.objUniversalDataModel.soryByBranchDataArray;
    NSLog(@"sort response %@", self.sortingResponseArray);
    self.sortTblView.dataSource = self;
    self.sortTblView.delegate = self;
    [self.sortTblView reloadData];
    [self loadInputViews];
}
- (void)loadInputViews {
    [self addProgressIndicator];
    
    switch ((VIEWHEIGHT == 568)?1:((VIEWHEIGHT == 667)?2:3)) {
        case 1:{
            self.sortingNameLbl.font = LFONT_13;
            self.allLbl.font = LFONT_13;
        }
            break;
        case 2:{
            self.sortingNameLbl.font = LFONT_15;
            self.allLbl.font = LFONT_15;
        }
            break;
        default:{
            self.sortingNameLbl.font = LFONT_17;
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
    return [self.sortingResponseArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        return 80;
    }
    else
        return 120;
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
    NSDictionary *dic = [self.sortingResponseArray objectAtIndex:indexPath.row];
    NSArray *array1Res = [self.sortingResponseArray objectAtIndex:0];
    NSArray *array2Res = [self.sortingResponseArray objectAtIndex:1];
    NSLog(@"response %@%@", array1Res,array2Res);
    if (array1Res.count > 0) {
        cell.typeNameLbl.text = [[array1Res valueForKey:@"branch"]objectAtIndex:indexPath.row];
        cell.amountQtyLbl.text = [NSString stringWithFormat:@"Qty= %@",[array1Res valueForKey:@"qty"]];
    }
    else {
        cell.typeNameLbl.text = @"Data not found";
    }
    
    [self hideProgressIndicator];
    return cell;
    
}


- (IBAction)dismissBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
