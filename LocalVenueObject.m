//
//  LocalVenueObject.m
//  Sushi2
//
//  Created by Craig on 6/2/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "LocalVenueObject.h"

@implementation LocalVenueObject

+ (LocalVenueObject *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress Distance:(NSNumber *)distance andFourSquareWebPage:(NSString *)fourSquareWebPage;


{
    
    LocalVenueObject *localVenueObject = [[LocalVenueObject alloc]init];
    localVenueObject.name = name;
    localVenueObject.streetAddress = streetAddress;
    localVenueObject.distance = distance;
    localVenueObject.fourSquareWebPage = fourSquareWebPage;
    
    
    return localVenueObject;
    
}

@end
