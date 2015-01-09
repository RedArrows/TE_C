//
//  DatePickerView.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/6.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView{
    UIDatePicker *_datePicker;
    UIView *_showView;
}



- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, ScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3;
        
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, 320, 246)];
        _showView.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(250, 0, 50, 30)];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(hideDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [_showView addSubview:btn];
        
        
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30, 320, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_showView addSubview:_datePicker];
    }
    return self;
}

-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [window addSubview:_showView];
    [UIView animateWithDuration:0.3 animations:^{
        _showView.frame = CGRectMake(0, self.frame.size.height-_showView.frame.size.height, 320, _showView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
        _showView.frame = CGRectMake(0, self.frame.size.height, 320, _showView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_showView removeFromSuperview];
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy年MM月dd日"];
        
        if (_callback) {
            _callback(_datePicker.date,[format stringFromDate:_datePicker.date]);
        }
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end