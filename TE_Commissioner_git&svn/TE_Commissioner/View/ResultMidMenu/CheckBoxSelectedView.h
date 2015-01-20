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

@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (copy,nonatomic)void(^callBack)(NSInteger index,NSArray* indexArray);//返回当前选中项 数组返回选中项数组

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewType:(SelectedType)type;

-(void)setSelectedView:(NSInteger)tag;

///[@"1",@"2"]
-(void)setSelectedViewWithArray:(NSArray *)array offset:(NSInteger)offset;

@end
