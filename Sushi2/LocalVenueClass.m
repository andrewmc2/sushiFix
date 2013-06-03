//
//  LocalVenueClass.m
//  Sushi2
//
//  Created by Craig on 6/2/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "LocalVenueClass.h"

@implementation LocalVenueClass


+ (LocalVenueClass *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress andDistance:(NSString *)distance
{
    
    LocalVenueClass *localVenueClass = [[LocalVenueClass alloc]init];
    localVenueClass.name = name;
    localVenueClass.streetAddress = streetAddress;
    localVenueClass.distance = distance;
    
    return localVenueClass;

}

@end
