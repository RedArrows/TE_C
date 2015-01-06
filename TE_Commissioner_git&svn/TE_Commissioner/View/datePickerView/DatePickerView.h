//
//  DatePickerView.h
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/6.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView

@property (nonatomic,copy)void(^callback)(NSDate *date,NSString *str);

-(void)show;

@end
