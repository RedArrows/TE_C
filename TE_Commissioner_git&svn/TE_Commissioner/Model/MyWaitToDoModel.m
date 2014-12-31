//
//  MyWaitToDoModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/30.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "MyWaitToDoModel.h"

@implementation MyWaitToDoModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.orderRatepayingNum = [[dic objectForKey:@"bookTaxNum"] integerValue];
        self.checkRatepayingNum = [[dic objectForKey:@"registerTaxNum"] integerValue];
        self.checkTransferNum = [[dic objectForKey:@"registerTransferNum"]integerValue];
        self.checkTransferLandNum = [[dic objectForKey:@"registerTransferLandNum"]integerValue];

    }
    return self;
}

@end
