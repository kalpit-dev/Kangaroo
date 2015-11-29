//
//  AdModel.h
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 10/10/15.
//  Copyright © 2015 MastermindConsulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdMap.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLResponseSerialization.h"
#define kbaseurl @"http://kangaroosuperheroes.com"
#define kgettingScore @"/ws/get_score.php"
#define kcreatingUser @"/ws/set_player.php"
#define ksettingScore @"/ws/set_score.php"
#define kredeemGift @"/ws/redeem_score.php"
#define kPublisherID @"15451"
#define kAdWallID @"3161"
#define kKey @"LxC153Y7ynp7gDjDjf84e3pfVtKwWnXboxX8Cl6drII9FtR4uyAiSzf4CFJX"
#define urlListOfOffers @"http://adscendmedia.com/adwall/api/publisher/%@/profile/%@/offers.json?subid1=%@"
#define urlAdsend @"http://adscendmedia.com/adwall/api/publisher/%@/profile/%@/details.json"
#define urlTransactions @"http://adscendmedia.com/adwall/api/publisher/%@/profile/%@/user/%@/transactions.json"
#define kgiftCardAPI @"https://www.giftrocket.com/gifts"
#import "SSKeychain.h"


@interface AdModel : NSObject
@property(nonatomic,strong)AdMap *adObject;
@property(nonatomic,strong) AFHTTPRequestOperationManager *managerObject;

-(id)initAdProfile;
-(void)synchronize;
-(void)deleteUserInformation;
-(void)gettingAdProfileDetails;
-(void)settingScore;
-(void)gettingScore;
-(NSString *)getUniqueDeviceIdentifierAsString;
-(void)redeemPoints:(NSDictionary *)dictParameters;
-(void)creatingUser;
@end
