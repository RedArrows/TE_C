//
//  ListItemTableViewCell.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/22.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface ListItemTableViewCell : UITableViewCell

-(void)fillDataWithModel:(ListModel *)model isShowToDo:(BOOL)isShow;

-(void)uiConfig;

@end
