//
//  CouponCell.m
//  Explore
//
//  Created by Varun on 7/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell () {
    
    __weak IBOutlet UILabel *lblCoupon;
}

@end

@implementation CouponCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCouponText:(NSString *)text {
    [lblCoupon setText:text];
}

@end
