//
//  LocalVenueObject.h
//  Sushi2
//
//  Created by Craig on 6/2/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalVenueObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *streetAddress;
@property (nonatomic, nonatomic) NSNumber *distance;
@property (strong, nonatomic) NSString *fourSquareWebPage;

+ (LocalVenueObject *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress Distance:(NSNumber *)distance andFourSquareWebPage:(NSString *)fourSquareWebPage;


@end
