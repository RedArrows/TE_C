//
//  ListDetailMidMenu.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailModel.h"

@protocol ListDetailMenuDelegate <NSObject>

-(void)listDetailMenuDidSelected:(NSInteger)idx model:(ListDetailModel*)model;

@end

@interface ListDetailMidMenu : UIView

@property (nonatomic,weak)id<ListDetailMenuDelegate> menuDelegate;

-(void)updateWithTabArray:(NSArray *)tabArray;

-(void)setSelected:(NSInteger)index;

@end
