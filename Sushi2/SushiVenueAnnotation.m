//
//  SushiVenueAnnotation.m
//  Sushi2
//
//  Created by MasterRyuX on 6/1/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "SushiVenueAnnotation.h"

@implementation SushiVenueAnnotation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage imageNamed:@"mobilemakers.png"];
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
