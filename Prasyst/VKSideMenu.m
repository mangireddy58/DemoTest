//
//  VKSideMenu.m
//  Version: 1.1
//
//  Created by Vladislav Kovalyov on 2/7/16.
//  Copyright © 2016 WOOPSS.com (http://woopss.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VKSideMenu.h"
#import "sideMenuCell.h"
#import "HeaderView.h"
#import "GlobalConstant.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define ROOTVC [[[[UIApplication sharedApplication] delegate] window] rootViewController]

@implementation VKSideMenuItem

@synthesize icon;
@synthesize title;
@synthesize tag;

@end

@interface VKSideMenu() <UITableViewDelegate, UITableViewDataSource>
{
    UITapGestureRecognizer *tapGesture;
    BOOL smiPhone5Below;
    BOOL smiPhone5Above;
}

@property (nonatomic, strong) UIView *overlay;

@end

@implementation VKSideMenu

#pragma mark - Initialization

-(instancetype)init
{
    if (self = [super init])
    {
        [self baseInit];
    }
    
    return self;
}

-(instancetype)initWithDirection:(VKSideMenuDirection)direction
{
    if (self = [super init])
    {
        [self baseInit];
        
        self.direction  = direction;
    }
    
    return self;
}

-(instancetype)initWithSize:(CGFloat)size andDirection:(VKSideMenuDirection)direction
{
    if (self = [super init])
    {
        [self baseInit];
        
        self.size       = size;
        self.direction  = direction;
    }
    
    return self;
}

-(void)baseInit
{
    self.size                       = 220;
    self.direction                  = VKSideMenuDirectionFromLeft;
    self.rowHeight                  = 44;
    self.enableOverlay              = YES;
    self.automaticallyDeselectRow   = YES;
    self.hideOnSelection            = YES;
    self.enableGestures             = YES;
    
    self.sectionTitleFont   = [UIFont systemFontOfSize:15.];
//    self.selectionColor     = [UIColor colorWithWhite:1. alpha:.5];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//    self.backgroundColor    = [UIColor colorWithWhite:1. alpha:.8];
#pragma clang diagnostic pop
    self.textColor          = UIColorFromRGB(0x252525);
    self.iconsColor         = UIColorFromRGB(0x8f8f8f);
    self.sectionTitleColor  = UIColorFromRGB(0x8f8f8f);
    self.menuBGColor        = [UIColor whiteColor];//UIColorFromRGB(0x232323);
    
    if(!SYSTEM_VERSION_LESS_THAN(@"8.0"))
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
    
    smiPhone5Below     = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height <= 568.0;
    smiPhone5Above     = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && (([UIScreen mainScreen].bounds.size.height == 667.0) || ([UIScreen mainScreen].bounds.size.height == 736.0));
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)initViews
{
    // Setup overlay
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - STATUS_BAR_HEIGHT)];
    self.overlay.alpha = 0;
    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.enableOverlay)
        self.overlay.backgroundColor = [UIColor colorWithWhite:0. alpha:.4];
    
    // Setup gestures
    if (self.enableGestures)
    {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self.overlay addGestureRecognizer:tapGesture];
    }
    
    CGRect frame = [self frameHidden];
    
    if(SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        self.view = [[UIView alloc] initWithFrame:frame];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //self.view.backgroundColor = self.backgroundColor;
        self.view.backgroundColor = [UIColor whiteColor];

#pragma clang diagnostic pop
    }
    else
    {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        self.view = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.view.frame = frame;
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width+30, self.view.frame.size.height)];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    
    // Setup content table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //[self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x,self.view.frame.origin.y, self.tableView.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.separatorColor   = [UIColor grayColor];
    self.tableView.backgroundColor  = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView setBounces:NO];
    [self.tableView setBackgroundColor:self.menuBGColor];
//    [self.view addSubview:self.tableView];
    self.tableView.frame = frame;
}

#pragma mark - Appearance

-(void)show
{
    [self initViews];
    
    [ROOTVC.view addSubview:self.overlay];
    [ROOTVC.view addSubview:self.view];
    
    [ROOTVC.view addSubview:self.tableView];
    
    CGRect frame = [self frameShowed];
    
    [UIView animateWithDuration:0.275 animations:^
     {
         self.view.frame = frame;
         self.overlay.alpha = 1.0;
         self.tableView.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         if (_delegate && [_delegate respondsToSelector:@selector(sideMenuDidShow:)])
             [_delegate sideMenuDidShow:self];
     }];
}

-(void)showWithSize:(CGFloat)size
{
    self.size = size;
    [self show];
}

-(void)hide
{
    [UIView animateWithDuration:0.275 animations:^
     {
         self.view.frame = [self frameHidden];
         self.tableView.frame = [self frameHidden];
         self.overlay.alpha = 0.;
     }
                     completion:^(BOOL finished)
     {
         if (_delegate && [_delegate respondsToSelector:@selector(sideMenuDidHide:)])
             [_delegate sideMenuDidHide:self];
         [self.tableView removeFromSuperview];
         [self.view removeFromSuperview];
         [self.overlay removeFromSuperview];
         [self.overlay removeGestureRecognizer:tapGesture];
         
         self.overlay = nil;
         self.tableView = nil;
         self.view = nil;
     }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource numberOfSectionsInSideMenu:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource sideMenu:self numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sideMenuCellIdentifier = @"sideMenuCell";
    sideMenuCell *sideMenuCellObj;
    sideMenuCellObj = [tableView dequeueReusableCellWithIdentifier:sideMenuCellIdentifier];
    if (sideMenuCellObj == nil) {
        sideMenuCellObj= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([sideMenuCell class]) owner:self options:0] objectAtIndex:0];
    }
    
    VKSideMenuItem *item = [self.dataSource sideMenu:self itemForRowAtIndexPath:indexPath];
    sideMenuCellObj.sideMenuListContentImageView.image = item.icon;
    //if(indexPath.row == 1){
                    //NSString *htmlString = @"<html><body><font color=#ffffff>Pitstop</font><sup><font color=#ffd409><small> New</small></font></sup></body></html>";
                    //NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        //sideMenuCellObj.sideMenuListContentLabel.attributedText = attrStr;
    //}else{
        sideMenuCellObj.sideMenuListContentLabel.text = item.title;
    //}
    if (smiPhone5Above)
        sideMenuCellObj.sideMenuListContentLabel.font = LFONT_18;
    else
        sideMenuCellObj.sideMenuListContentLabel.font = LFONT_15;
    
    sideMenuCellObj.backgroundColor = self.menuBGColor;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [tableView setSeparatorColor:[UIColor grayColor]];
    sideMenuCellObj.selectionStyle = UITableViewCellSelectionStyleNone;
    return sideMenuCellObj;

}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(sideMenu:didSelectRowAtIndexPath:)])
        [_delegate sideMenu:self didSelectRowAtIndexPath:indexPath];
    
    if (self.automaticallyDeselectRow)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.hideOnSelection)
        [self hide];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (smiPhone5Above)
        return SM_IPHONE5ABOVE;
    else
        return SM_IPHONE5BELOW;
    return SM_IPHONE5BELOW;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(sideMenu:titleForHeaderInSection:)])
//        return [self.delegate sideMenu:self titleForHeaderInSection:section].uppercaseString;
//    
//    return nil;
//}

/*- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    HeaderView *header = (HeaderView *)view;
    [header.headerNamelabel setTextColor:self.sectionTitleColor];
    [header.headerNamelabel setFont:self.sectionTitleFont];
}*/


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [self.dataSource sideMenu:self viewForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (smiPhone5Above)
//        return SM_USER_IPHONE5ABOVE;
//    else
//        return SM_USER_IPHONE5BELOW;
    return 200;
}


#pragma mark - GestureRecognition

-(void)addSwipeGestureRecognition:(UIView *)view
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwap:)];
    
    switch (self.direction)
    {
        case VKSideMenuDirectionFromTop:
            swipe.direction = UISwipeGestureRecognizerDirectionDown;
            break;
            
        case VKSideMenuDirectionFromLeft:
            swipe.direction = UISwipeGestureRecognizerDirectionRight;
            break;

            
        case VKSideMenuDirectionFromBottom:
            swipe.direction = UISwipeGestureRecognizerDirectionUp;
            break;

            
        case VKSideMenuDirectionFromRight:
            swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            break;
    }
    
    [view addGestureRecognizer:swipe];
}

-(void)didTap:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
        [self hide];
}

-(void)didSwap:(UISwipeGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded && self.enableGestures)
        [self showWithSize:self.size];
}

#pragma mark - Helpers

-(CGRect)frameHidden
{
    CGRect frame = CGRectZero;
    
    switch (self.direction)
    {
        case VKSideMenuDirectionFromTop:
            frame = CGRectMake(0, -self.size, [UIScreen mainScreen].bounds.size.width, self.size);
            break;
            
        case VKSideMenuDirectionFromLeft:
            frame = CGRectMake(-self.size, STATUS_BAR_HEIGHT, self.size, [UIScreen mainScreen].bounds.size.height);
            break;
            
        case VKSideMenuDirectionFromBottom:
            frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.size);
            break;
            
        case VKSideMenuDirectionFromRight:
            frame = CGRectMake([UIScreen mainScreen].bounds.size.width + self.size, STATUS_BAR_HEIGHT, self.size, [UIScreen mainScreen].bounds.size.height);
            break;
    }
    
    return frame;
}

-(CGRect)frameShowed
{
    CGRect frame = self.view.frame;
    
    switch (self.direction)
    {
        case VKSideMenuDirectionFromTop:
            frame.origin.y = 0;
            break;
            
        case VKSideMenuDirectionFromLeft:
            frame.origin.x = 0;
            break;
            
        case VKSideMenuDirectionFromBottom:
            frame.origin.y = [UIScreen mainScreen].bounds.size.height - self.size;
            break;
            
        case VKSideMenuDirectionFromRight:
            frame.origin.x = [UIScreen mainScreen].bounds.size.width - self.size;
            break;
    }
    
    return frame;
}

@end
