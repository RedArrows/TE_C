//
//  ListModel.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/22.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic,copy)NSString *documentNO;
@property (nonatomic,strong)NSArray *mark;
@property (nonatomic,assign)NSInteger toDoNum;
@property (nonatomic,copy)NSString *agentName;
@property (nonatomic,copy)NSString *buyer;
@property (nonatomic,copy)NSString *seller;
@property (nonatomic,copy)NSString *director;
@property (nonatomic,assign)CGFloat price;
@property (nonatomic,copy)NSString *date;


@end
