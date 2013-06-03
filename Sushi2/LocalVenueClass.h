//
//  LocalVenueClass.h
//  Sushi2
//
//  Created by Craig on 6/2/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalVenueClass : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSString *distance;



+ (LocalVenueClass *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress andDistance:(NSString *)distance;

@end
