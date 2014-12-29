//
//  BottomToDoBar.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomToDoBar : UIView

@property (nonatomic,copy)void(^callback)(NSInteger index);
@property (nonatomic,assign,readonly)NSInteger barHeight;
@property (nonatomic,assign)BOOL isShow;

-(id)initWithTitleArray:(NSArray*)array;

@end
