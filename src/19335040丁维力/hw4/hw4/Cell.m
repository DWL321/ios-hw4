//
//  Cell.m
//  hw4
//
//  Created by student14 on 2021/11/25.
//  Copyright © 2021 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "../Pods/Masonry/Masonry/Masonry.h"

@interface Cell()

@end

@implementation Cell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        _image = [[UIImageView alloc] init];
        [_image setContentMode:UIViewContentModeRedraw];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(500, 180));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

@end
