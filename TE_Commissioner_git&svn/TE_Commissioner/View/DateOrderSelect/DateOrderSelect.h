//
//  DateOrderSelect.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/24.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DATEORDERMETHOD){
    DATEORDER_new_old = 0,
    DATEORDER_old_new
};

@interface DateOrderSelect : UIView

@property (copy,nonatomic)void(^callBackMethod)(DATEORDERMETHOD method);

@end
