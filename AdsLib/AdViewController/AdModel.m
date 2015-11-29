//
//  AdModel.m
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 10/10/15.
//  Copyright © 2015 MastermindConsulting. All rights reserved.
//

#import "AdModel.h"
#define kAdProfileKey @"adProfileKey"
@implementation AdModel
@synthesize adObject,managerObject;

-(id)initAdProfile
{
    if (self = [super init])
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSData *myEncodedObject = [prefs objectForKey:kAdProfileKey];
        if (!myEncodedObject)
        {
            self.adObject = [[AdMap alloc] init];
            [self synchronize];
            
        }
        else
        {
            self.adObject = [NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
            [self synchronize];
        }
        
    }
    return self;
}

-(void)synchronize
{
    if (self.adObject == nil)
    {
        NSLog(@"it nil");
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:kAdProfileKey];
    
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.adObject];
    [prefs setObject:myEncodedObject forKey:kAdProfileKey];
    [prefs synchronize];
    if (self.adObject == nil)
    {
        NSLog(@"it nil");
    }
}

-(void)deleteUserInformation
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAdProfileKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)getUniqueDeviceIdentifierAsString
{
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    
    return strApplicationUUID;
    //return @"EA2C772F-8C97-4D47-8E4D-ODB1E8C40A3E";
}

-(void)gettingAdProfileDetails
{
    NSString *strID = [self getUniqueDeviceIdentifierAsString];
    NSString *urlstr = [NSString stringWithFormat:urlTransactions,kPublisherID,kAdWallID,strID];
    managerObject = [AFHTTPRequestOperationManager manager];
    
    [managerObject GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@",responseObject);
         if(responseObject!=nil) {
             NSDictionary *responce = responseObject;
             self.adObject.strPlayScore = [responce objectForKey:@"currency_count"];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your score from adsend" message:[NSString stringWithFormat:@"%@ hops",[responce objectForKey:@"currency_count"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             [alert show];
             [self synchronize];
             [self settingScore];
         }
         else{
             
             self.adObject.strPlayScore = @"25";
             [self synchronize];
         }
         //successResponce(json);
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //failureResponce(error);
     }];
    
}

-(void)creatingUser
{
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",kbaseurl,kcreatingUser];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[self getUniqueDeviceIdentifierAsString],@"player_id", nil];
    managerObject = [AFHTTPRequestOperationManager manager];
    managerObject.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"] ;
    [managerObject POST:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        NSLog(@"%@",json);
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        adObject.strPlayScore = [[json objectForKey:@"player_data"] objectForKey:@"score"];
//        adObject.strPlayerID = [[json objectForKey:@"player_data"] objectForKey:@"player_id"];
//        adObject.strPlayerName = [[json objectForKey:@"player_data"] objectForKey:@"player_name"];
      //  [self synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        
    }];
}

-(void)giftCardAPI:(NSDictionary *)dictParameters completionBlock:(void(^)(BOOL successful))completion
{
    NSString *urlstr = [NSString stringWithFormat:@"%@",kgiftCardAPI];
    managerObject = [AFHTTPRequestOperationManager manager];
    managerObject.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"] ;
    [managerObject POST:urlstr parameters:dictParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        NSDictionary *dictResponse = json;
        
        if ([[dictResponse objectForKey:@"success"] intValue] == 1)
        {
            completion(TRUE);
        }
        else
        {
            completion(FALSE);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

-(void)redeemPoints:(NSDictionary *)dictParameters
{
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",kbaseurl,kredeemGift];
    managerObject = [AFHTTPRequestOperationManager manager];
    managerObject.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"] ;
    [managerObject POST:urlstr parameters:dictParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",dictParameters);
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        NSLog(@"%@",json);
        NSDictionary *dict = json;
        if ([[dict objectForKey:@"response_status"] intValue] == 1)
        {
            NSMutableDictionary *dictMutable = [NSMutableDictionary dictionaryWithDictionary:dictParameters];
            [dictMutable setObject:@"U5vRvm0stGkA6vBSpg" forKey:@"api_key"];
            [dictMutable setObject:@"card" forKey:@"payment_source"];
            [dictMutable setObject:[dictParameters objectForKey:@"redeem_amount"] forKey:@"gift[amount]"];
            [dictMutable setObject:[dictParameters objectForKey:@"email_id"] forKey:@"gift[recipient_email]"];
            [dictMutable setObject:[dictParameters objectForKey:@"player_name"] forKey:@"gift[recipient_name]"];
            [dictMutable setObject:@"Kangaroo Super Heros" forKey:@"gift[sender_name]"];
            [dictMutable setObject:@"Gift card from kangaroo" forKey:@"message_announce"];
            [dictMutable setObject:@"true" forKey:@"test_gift"];
            
            [self giftCardAPI:dictMutable completionBlock:^(BOOL successful) {
                if (successful)
                {
                    NSLog(@"%@",dictMutable);
                    NSLog(@"%@",dictParameters);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your redemption process was successful." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else
                {
                    NSString *str = [NSString stringWithFormat:@"Your redemption process via our automated redemption system was unsuccessful. Please contact us at redeem@kangaroosuperheroes.com and also quote your Redeem ID :%@ for assistance.",[dict objectForKey:@"redeem_id"]];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opps! Something went wrong!" message:str delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                    NSMutableDictionary *dictMut = [NSMutableDictionary dictionaryWithDictionary:dictParameters];
                    [dictMut setObject:@"0" forKey:@"redeem_mode"];
                    [self stopRedeeming:dictMut];
                }
            }];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[dict objectForKey:@"response_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)stopRedeeming:(NSDictionary *)dictParameters
{
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",kbaseurl,kredeemGift];
    managerObject = [AFHTTPRequestOperationManager manager];
    managerObject.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"] ;
    [managerObject POST:urlstr parameters:dictParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        NSLog(@"%@",json);
        NSDictionary *dict = json;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}



-(void)settingScore
{
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",kbaseurl,ksettingScore];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[self getUniqueDeviceIdentifierAsString],@"player_id",adObject.strPlayScore,@"score", nil];
    managerObject = [AFHTTPRequestOperationManager manager];
    managerObject.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"] ;
    [managerObject POST:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        NSLog(@"%@",json);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)gettingScore
{
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",kbaseurl,kgettingScore];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[self getUniqueDeviceIdentifierAsString],@"player_id", nil];
    managerObject = [AFHTTPRequestOperationManager manager];
    managerObject.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerObject.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"] ;
    [managerObject POST:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        NSLog(@"%@",json);
        adObject.strPlayScore = [[json objectForKey:@"player_data"] objectForKey:@"score"];
        adObject.strPlayerID = [[json objectForKey:@"player_data"] objectForKey:@"player_id"];
        adObject.strPlayerName = [[json objectForKey:@"player_data"] objectForKey:@"player_name"];
        [self synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);

    }];
}

@end
