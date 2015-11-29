//
//  DemoViewController.m
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 17/10/15.
//  Copyright © 2015 MastermindConsulting. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property (nonatomic,retain) IBOutlet UIWebView *webView;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *actView;
@end

@implementation DemoViewController
@synthesize strURLToLoad,btnCross;
- (void)viewDidLoad {
    [super viewDidLoad];
    btnCross.frame = CGRectMake(btnCross.frame.origin.x, 40, btnCross.frame.size.width, btnCross.frame.size.height);
    [self loadingWebViewWithURLString:strURLToLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(btnCross.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    [self.view removeFromSuperview];
}

-(void)loadingWebViewWithURLString:(NSString *)strURL {
    
    self.webView.hidden = false;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    [self.webView loadRequest:request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
