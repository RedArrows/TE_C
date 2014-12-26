//
//  ListModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/22.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.documentNO = [dic objectForKey:@"documentNo"];
        self.toDoNum = [[dic objectForKey:@"toDoNum"] integerValue];
        self.mark = [dic objectForKey:@"mark"];
        self.agentName = [dic objectForKey:@"agentName"];
        self.buyer = [dic objectForKey:@"buyer"];
        self.seller = [dic objectForKey:@"seller"];
        self.director = [dic objectForKey:@"director"];
        self.price = [[dic objectForKey:@"price"] integerValue];
        self.date = [dic objectForKey:@"date"];
    }
    return self;
}
@end
