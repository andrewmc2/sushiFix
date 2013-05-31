//
//  NSString+StripHTMLTags.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-30.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "NSString+StripHTMLTags.h"

@implementation NSString (StripHTMLTags)

-(NSString*)stripStringOfHTMLTags
{
    NSRange r;
    NSString *s;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
