//
//  OptionsTableViewCell.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/18.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionDetailModel.h"


@protocol OptionDeleteDelegate <NSObject>

-(void)deleteOptionForType:(OptionType)type;

@end

@interface OptionsTableViewCell : UITableViewCell

@property (nonatomic,weak)id<OptionDeleteDelegate> delDelegate;
@property (nonatomic,assign)OptionType myType;


-(void)uiConfig;
-(void)fillDataWithModel:(OptionDetailModel *)model;

@end
