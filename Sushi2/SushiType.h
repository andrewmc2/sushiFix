//
//  SushiType.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SushiType : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *japaneseName;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) UIImage *sushiLogo;
@property (nonatomic) BOOL isNotUserCreated;

@end
