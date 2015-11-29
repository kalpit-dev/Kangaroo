//
//  AdMap.m
//  Kangaroo.Superheroes
//
//  Created by Bipul Dev on 10/10/15.
//  Copyright © 2015 MastermindConsulting. All rights reserved.
//

#import "AdMap.h"

@implementation AdMap
-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.strPlayerName forKey:@"strPlayerName"];
    [encoder encodeObject:self.strPlayerID forKey:@"strPlayerID"];
    [encoder encodeObject:self.strPlayerAddress forKey:@"strPlayerAddress"];
    [encoder encodeObject:self.strPlayerContactNumber forKey:@"strPlayerContactNumber"];
    [encoder encodeObject:self.strPlayerEmailID forKey:@"strPlayerEmailID"];
    [encoder encodeObject:self.strPlayerCountry forKey:@"strPlayerCountry"];
    [encoder encodeObject:self.strPlayScore forKey:@"strPlayScore"];
    [encoder encodeObject:self.strPlayRedeemAmount forKey:@"strPlayRedeemAmount"];
    
    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        self.strPlayerName = [decoder decodeObjectForKey:@"strPlayerName"];
        self.strPlayerID = [decoder decodeObjectForKey:@"strPlayerID"];
        self.strPlayerAddress = [decoder decodeObjectForKey:@"strPlayerAddress"];
        self.strPlayerContactNumber = [decoder decodeObjectForKey:@"strPlayerContactNumber"];
        self.strPlayerEmailID = [decoder decodeObjectForKey:@"strPlayerEmailID"];
        self.strPlayerCountry = [decoder decodeObjectForKey:@"strPlayerCountry"];
        self.strPlayScore = [decoder decodeObjectForKey:@"strPlayScore"];
        self.strPlayRedeemAmount = [decoder decodeObjectForKey:@"strPlayRedeemAmount"];
        //decode the properties
        
    }
    return self;
}

@end
