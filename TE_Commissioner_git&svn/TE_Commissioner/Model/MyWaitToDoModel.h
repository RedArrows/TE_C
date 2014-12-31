//
//  MyWaitToDoModel.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/30.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWaitToDoModel : NSObject

@property (nonatomic,assign)NSInteger orderRatepayingNum;
@property (nonatomic,assign)NSInteger checkRatepayingNum;
@property (nonatomic,assign)NSInteger checkTransferNum;
@property (nonatomic,assign)NSInteger checkTransferLandNum;


-(id)initWithDic:(NSDictionary *)dic;

@end
