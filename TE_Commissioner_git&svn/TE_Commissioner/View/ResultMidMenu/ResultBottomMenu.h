//
//  ResultBottomMenu.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultBottomMenu : UIView

@property (nonatomic,copy)void(^submitCallback)(void);
@property (nonatomic,copy)void(^saveCallback)(void);


@end
