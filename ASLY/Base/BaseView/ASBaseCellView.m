//
//  ASBaseCellView.m
//  ASLY
//
//  Created by 张志超 on 2020/11/4.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASBaseCellView.h"

@implementation ASBaseCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor] ;
        [self jk_shadowWithColor:kColorHex(0x515151) offset:CGSizeMake(2, 2) opacity:0.1 radius:5] ;
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
