//
//  ListContactTableViewCell.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailModel.h"


@interface ListContactTableViewCell : UITableViewCell

-(void)fillDataWithModel:(ContactPeople *)model;

@end
