//
//  SushiTypeTableCell.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SushiTypeTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sushiImage;
@property (weak, nonatomic) IBOutlet UILabel *sushiName;
@property (weak, nonatomic) IBOutlet UILabel *japaneseSushiName;
@property (weak, nonatomic) IBOutlet UIImageView *rotatedImage;

@end
