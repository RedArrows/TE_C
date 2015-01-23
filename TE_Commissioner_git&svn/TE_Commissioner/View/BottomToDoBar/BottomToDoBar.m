//
//  BottomToDoBar.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "BottomToDoBar.h"

@implementation BottomToDoBar{
    NSArray *btnArray;
}

- (instancetype)initWithTitleArray:(NSArray*)array
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = UICOLOR_RGB_Alpha(0xf5f5f5, 1);
//        self.alpha = 0.8;
        self.isShow = YES;
        [self updateWithToDoArray:array];
        
    }
    return self;
}

-(void)updateWithToDoArray:(NSArray *)array{
    CGFloat btnHeight = 33;
    CGFloat btnWidth = 120;
    CGFloat btnHeightGas = 10;
    
    CGFloat heightSpace = 10;
    CGFloat widthSpace = (320.0-2*btnWidth)/3;
    
    CGFloat curHeight = heightSpace;
    
    if (array.count == 1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(40, 10, 240, 30);
        btn.tag = 0;
        [btn setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        curHeight = 50;
    }else{
        for (int i = 0; i<array.count; i++) {
            if (i%2==0) {
                curHeight += btnHeight +btnHeightGas;
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(widthSpace+(i%2)*(widthSpace+btnWidth), heightSpace+(i/2)*(heightSpace+btnHeight), btnWidth, btnHeight);
            btn.tag = i;
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
    }
    self.frame = CGRectMake(0, ScreenHeight-curHeight, 320, curHeight);
    _barHeight = curHeight;
    
    //204 204 204
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = UICOLOR_RGB_Alpha(0xcccccc, 1);
    [self addSubview:lineView];

}

-(void)click:(UIButton *)btn{
    if (_callback) {
        _callback(btn.tag);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
