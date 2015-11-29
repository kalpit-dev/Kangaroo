//
//  DemoViewController.h
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 17/10/15.
//  Copyright © 2015 MastermindConsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController<UIWebViewDelegate>

@property (retain,nonatomic) IBOutlet UIButton *btnCross;
@property(nonatomic,retain)NSString *strURLToLoad;
@end
