//
//  EXTextField.m
//  Explore
//
//  Created by Varun on 20/05/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "EXTextField.h"

@interface EXTextField () {
    UIImageView *imgVwLeft;
}

@end

@implementation EXTextField

- (void)drawRect:(CGRect)rect {
    
//    [self setFont:[UIFont fontWithName:_TS_FontHelveticaNeue_Light size:16]];
    [self setTintColor:[UIColor whiteColor]];
    [self setBorderStyle:UITextBorderStyleNone];
    [self setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self setTextColor:[UIColor whiteColor]];
    
    [self setBackground:[UIImage imageNamed:@"textFieldBack"]];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 33, bounds.origin.y, bounds.size.width - 10, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
