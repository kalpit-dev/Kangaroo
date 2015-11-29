//
//  AdViewController.h
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 23/06/15.
//  Copyright (c) 2015 MastermindConsulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "AdModel.h"
@interface AdViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    AFHTTPRequestOperationManager *managerObject;
    AdModel *ad;

}
@property (retain, nonatomic) IBOutlet UILabel *lblHeader;
@property (retain, nonatomic) IBOutlet UITextView *txtViewInfo;
@property (retain, nonatomic) NSString *strInfo,*strHeader;
@property (retain,nonatomic) IBOutlet UIButton *btnClose;
@property (retain, nonatomic) IBOutlet UIButton *btnRedeem;
-(void)showWebViewForAd:(int )index;
@end
