//
//  OptionDetailModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/18.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "OptionDetailModel.h"



@implementation OptionDetailModel


-(void)setOptionTypeWithString:(NSString *)title{
    if ([title isEqualToString:@"搜索经纪人/主办"]) {
        _optionType = OptionAgentName;
        _keyText = @"agentName";
    }else if ([title isEqualToString:@"搜索买方/卖方"]) {
        _optionType = OptionClientName;
        _keyText = @"ClientName";
    }else if ([title isEqualToString:@"搜索交易编号"]) {
        _optionType = OptionDocumentNO;
        _keyText = @"DocumentNO";
    }
}


@end
