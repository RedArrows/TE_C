//
//  ResultBottomMenu.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ResultBottomMenu.h"

@implementation ResultBottomMenu

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 568-50, 320, 50)];
    if (self) {
        CGFloat btnGap = 20.0;
        CGFloat btnWidth = (320-20*3)/2;
        CGFloat btnHeight = 30;
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
        submit.frame = CGRectMake(btnGap, 10, btnWidth, btnHeight);
        [submit setTitle:@"提交" forState:UIControlStateNormal];
        [submit setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submit];
        
        UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
        save.frame = CGRectMake(btnGap*2+btnWidth, 10, btnWidth, btnHeight);
        [save setTitle:@"保存" forState:UIControlStateNormal];
        [save setBackgroundImage:[UIImage imageNamed:@"btn_green"] forState:UIControlStateNormal];
        [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:save];
        
        self.layer.shadowOffset = CGSizeMake(1, -1);
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOpacity = 0.9;
    }
    return self;
}
-(void)submit{
    if (_submitCallback) {
        _submitCallback();
    }
}
-(void)save{
    if (_saveCallback) {
        _saveCallback();
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
