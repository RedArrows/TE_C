//
//  YDListMenuView.h
//  YDMenu
//
//  Created by liuyunda on 14/12/9.
//  Copyright (c) 2014年 liuyunda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListViewChooseDelegate <NSObject>

@optional
-(void) chooseAtTitle:(NSString *)title index:(NSInteger)index;

@end


@interface YDListMenuView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) id<ListViewChooseDelegate> listDelegate;

- (id)initBackViewFrame:(CGRect)frame withListViewPoint:(CGPoint)point withDelegate:(id)delegate;



@end
