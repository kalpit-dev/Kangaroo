//
//  AdViewController.m
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 23/06/15.
//  Copyright (c) 2015 MastermindConsulting. All rights reserved.
//

#import "AdViewController.h"
#import "SSKeychain.h"
#define add_Key_LeadBolt @"SRUaMugzUr8cUaa7EWePOcGtR3yT49mZ"
#import "AdModel.h"
#import "AppDelegate.h"
@interface AdViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tblViewOffers;

@property (strong, nonatomic) NSArray *arrayOffers;
@property (strong,nonatomic) NSMutableDictionary *arrayOfImages;
@property (retain, nonatomic) IBOutlet UIWebView *webViewOfferDetails;
@property (retain, nonatomic) IBOutlet UIView *viewWebContainer;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorCommon;
@property (retain,nonatomic) IBOutlet UIScrollView *scrView;

@end

@implementation AdViewController
@synthesize lblHeader,txtViewInfo,strInfo,strHeader,btnClose,btnRedeem;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfImages = [[NSMutableDictionary alloc] init];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        btnClose.frame = CGRectMake(btnClose.frame.origin.x-10, btnClose.frame.origin.y, 50, 50);

    }
    else
    {
        btnClose.frame = CGRectMake(btnClose.frame.origin.x, btnClose.frame.origin.y, 40, 40);

    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        lblHeader.font = [UIFont fontWithName:@"Segoe UI" size:20];
        txtViewInfo.font=[UIFont fontWithName:@"Segoe UI" size:15];
        btnRedeem.frame = CGRectMake(btnRedeem.frame.origin.x, btnRedeem.frame.origin.y-10, 558, 67);
        btnRedeem.center = CGPointMake(self.view.center.x, btnRedeem.center.y);
    }
    else
    {
        lblHeader.font = [UIFont fontWithName:@"Segoe UI" size:15];
        txtViewInfo.font=[UIFont fontWithName:@"Segoe UI" size:10];
        btnRedeem.frame = CGRectMake(btnRedeem.frame.origin.x, btnRedeem.frame.origin.y-10, 329, 44);
        btnRedeem.center = CGPointMake(self.view.center.x, btnRedeem.center.y);
    }
    self.txtViewInfo.text = strInfo;
    self.lblHeader.text = strHeader;
    self.arrayOffers = [[NSArray alloc] init];
    ad = [[AdModel alloc] initAdProfile];
    // intialising the add object
    [self initializeEventListeners];
   
    //[self loadingAdinBackgroundwithURL:[NSString stringWithFormat:urlAdsend,kPublisherID,kAdWallID] andParameters:nil];
    NSString *uniqueIdentifier = [self getUniqueDeviceIdentifierAsString];
    [self loadingAdinBackgroundwithURL:[NSString stringWithFormat:urlListOfOffers,kPublisherID,kAdWallID,uniqueIdentifier] andParameters:nil];
    
}

-(void)loadingAdinBackgroundwithURL:(NSString *)urlstr andParameters:(NSDictionary *)parameters
{
    managerObject = [AFHTTPRequestOperationManager manager];
    
    [managerObject GET:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.activityIndicatorCommon stopAnimating];
         NSDictionary *responce = responseObject;
         
         self.arrayOffers = [responce objectForKey:@"offers"];
         AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         app.arrayData = [self.arrayOffers copy];
         //[self.tblViewOffers reloadData];
         
         //successResponce(json);
         [self scrollViewConfiguring:self.arrayOffers];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.activityIndicatorCommon stopAnimating];
         //failureResponce(error);
     }];

}

-(NSString *)getUniqueDeviceIdentifierAsString
{
    
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    
    return strApplicationUUID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewConfiguring:(NSArray *)array
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    int counter=0;
    for (NSDictionary *dict in array)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, counter*50+2, self.scrView.frame.size.width, 50)];
        view.tag = counter;
        view.backgroundColor = [UIColor clearColor];
        [self.scrView addSubview:view];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        imageView.tag = 1;
        imageView.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:150.0/255.0 blue:210.0/255.0 alpha:1.0];
        [view addSubview:imageView];
        
        dispatch_queue_t queue = dispatch_queue_create("imageDownload", 0);
        dispatch_async(queue, ^{
            
            UIImage *imageData = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",[dict objectForKey:@"image_url"] ]]]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // assign cell image on main thread
                //imageView.image = imageData;
                NSArray *array = view.subviews;
                for (id subView in array) {
                    if ([subView isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *img = (UIImageView *)subView;
                        img.image = imageData;
                    }
                }
                
            });
            
        });
        
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(40 + 10, 5, view.frame.size.width-imageView.frame.size.width+5, 40)];
        lbl.tag = 2;
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = [dict objectForKey:@"name"];
        [view addSubview:lbl];
        [lbl release];lbl=nil;
        
        
        UILabel *lblPoints = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-60, 5, 100, 40)];
        lblPoints.tag = 3;
        lblPoints.font = [UIFont fontWithName:@"Segoe UI" size:15];
        lblPoints.text = [NSString stringWithFormat:@"%@ hops",[dict objectForKey:@"currency_count"]];
        [view addSubview:lblPoints];
        [lblPoints release];lbl=nil;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 48, view.frame.size.width, 1)];
        viewLine.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:150.0/255.0 blue:210.0/255.0 alpha:1.0];
        [view addSubview:viewLine];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        btn.tag = counter;
        [btn addTarget:app action:@selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        //[btn release]; btn = nil;
        //[imageView release];imageView=nil;
        counter ++;
    }
    
    self.scrView.contentSize = CGSizeMake(self.scrView.frame.size.width, counter*50);
}

-(void)addClicked:(UIButton *)sender
{
    NSLog(@"yoyoyoyoyo");
    UIButton *btn = sender;
    NSLog(@"%ld",(long)btn.tag);
    int index = btn.tag;
    [self showWebViewForAd:index];
}

-(void)showWebViewForAd:(int )index
{
    [self loadingWebViewWithURLString:[[self.arrayOffers objectAtIndex:index] objectForKey:@"click_url"]];
}

-(IBAction)buttonClose:(id)sender
{
    //[self performSelector:@selector(dismissingWithDelay) withObject:nil afterDelay:1.0];
    [self dismissingWithDelay];
    
}
- (IBAction)buttonWebViewClose:(id)sender {
    [self.activityIndicatorCommon stopAnimating];
    self.viewWebContainer.hidden = TRUE;
    [ad gettingAdProfileDetails];
}

-(void)loadingWebViewWithURLString:(NSString *)strURL {
    
    self.viewWebContainer.hidden = false;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    [self.webViewOfferDetails loadRequest:request];
}

-(void)dismissingWithDelay
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view removeFromSuperview];
}

-(void)initializeEventListeners {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSString *str = @"AppFireworksNotification";
//    [nc addObserver:self selector:@selector(handleLBEvent:) name:@"onModuleLoaded" object:str];
//    [nc addObserver:self selector:@selector(handleLBEvent:) name:@"onModuleFailed" object:str];
//    [nc addObserver:self selector:@selector(handleLBEvent:) name:@"onModuleCached" object:str];
//    [nc addObserver:self selector:@selector(handleLBEvent:) name:@"onModuleClosed" object:str];
//    [nc addObserver:self selector:@selector(handleLBEvent:) name:@"onModuleClicked" object:str];
//    [nc addObserver:self selector:@selector(handleLBEvent:) name:@"onMediaFinished" object:str];
}

-(void)handleLBEvent:(NSNotification *)notif {
    NSString *location = [notif.userInfo objectForKey:@"placement"];
    NSString *event = notif.name;
    
    if([event isEqualToString:@"onModuleLoaded"]) {
        NSLog(@
              "Ad loaded successfully - %@", location);
        // Add code here to pause game and/or all media including audio
    } else if([event isEqualToString:@"onModuleFailed"])
    {
        NSString *isCache = [notif.userInfo objectForKey:@"cached"];
        if([isCache isEqualToString:@"yes"])
        {
            NSLog(@"Ad failed to cache - %@", location);
        } else {
            NSLog(@"Ad failed to display - %@", location);
            [self buttonClose:nil];
        }
    } else if([event isEqualToString:@"onModuleClosed"])
    {
        NSLog(@"Ad closed by user - %@", location);
        [self buttonClose:nil];
        // Add code here to resume game and/or all media including audio
    } else if([event isEqualToString:@"onModuleClicked"])
    {
        NSLog(@"Ad clicked by user - %@", location);
        [self buttonClose:nil];
    } else if([event isEqualToString:@"onModuleCached"])
    {
        NSLog(@"Ad cached successfully - %@", location);
        
    } else if([event isEqualToString:@"onMediaFinished"])
    {
        NSString *viewCompleted = [notif.userInfo objectForKey:@"viewCompleted"];
        if([viewCompleted isEqualToString:@"yes"])
        {
            NSLog(@"User finished watching rewarded video");
            [self buttonClose:nil];
        } else {
            NSLog(@"User skipped watching rewarded video");
            [self buttonClose:nil];
        }
    }
}

//#pragma mark table view delegate
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSLog(@"%lu",(unsigned long)self.arrayOffers.count);
//    if (self.arrayOffers.count > 0)
//    {
//        return 8;
//    }
//    else
//    {
//        return 0;
//    }
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOffers"];
//    if ([self.arrayOfImages objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] == nil) {
//        
//        dispatch_queue_t queue = dispatch_queue_create("imageDownload", 0);
//        dispatch_async(queue, ^{
//           
//            UIImage *imageData = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",[[self.arrayOffers objectAtIndex:indexPath.row] objectForKey:@"image_url"] ]]]] autorelease];
//            
//            [self.arrayOfImages setObject:imageData forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // assign cell image on main thread
//                [self.tblViewOffers reloadData];
//            });
//            
//        });
//    }
//    else
//    {
//        [cell.imageView setImage:[self.arrayOfImages objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]];
//    }
//    [cell.textLabel setText:[[self.arrayOffers objectAtIndex:indexPath.row] objectForKey:@"name"]];
//    return cell;
//    
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self loadingWebViewWithURLString:[[self.arrayOffers objectAtIndex:indexPath.row] objectForKey:@"click_url"]];
//}

#pragma mark webview delegates
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Started Loading");
    [self.activityIndicatorCommon startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
            NSLog(@"Ended Loading");
    [self.activityIndicatorCommon stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
        NSLog(@"Failed Loading");
    [self.activityIndicatorCommon stopAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tblViewOffers release];
    [_arrayOfImages release];
    [lblHeader release];
    [_webViewOfferDetails release];
    [_viewWebContainer release];
    [_activityIndicatorCommon release];
    _tblViewOffers = nil;
    _arrayOfImages = nil;
    lblHeader = nil;
    _webViewOfferDetails = nil;
    _viewWebContainer = nil;
    _activityIndicatorCommon = nil;
    [super dealloc];
}
@end
