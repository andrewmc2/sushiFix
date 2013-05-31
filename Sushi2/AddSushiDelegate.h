//
//  AddSushiDelegate.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-31.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddSushiDelegate <NSObject>

-(void) addName: (NSString*) name
 addDescription: (NSString*) description
       addImage: (UIImage*) image;

@end
