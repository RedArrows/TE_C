//
//  CheckBoxSelectedView.h
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/14.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SelectedType) {
    SelectedType_CheckBox,
    SelectedType_TwoSelectOne
};

@interface CheckBoxSelectedView : UIView

@property (copy,nonatomic)void(^callBack)(NSInteger index);//返回选中项，无选中则返回10086

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewType:(SelectedType)type;

-(void)setSelectedView:(NSInteger)tag;

@end
