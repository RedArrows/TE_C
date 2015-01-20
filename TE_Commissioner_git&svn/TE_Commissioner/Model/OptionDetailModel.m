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
        _keyText = @"clientName";
    }else if ([title isEqualToString:@"搜索交易编号"]) {
        _optionType = OptionDocumentNO;
        _keyText = @"documentNo";
    }else if ([title isEqualToString:@"挂起"]||[title isEqualToString:@"连环单"]||[title isEqualToString:@"时效单"]){
        _optionType = OptionDocType;
        _keyText = @"docType";
        _valueText = title;
    }else{
        _optionType = OptionProductType;
        _keyText = @"productType";
        _valueText = [[Tool instance].productTypeDic objectForKey:title];
    }
}


@end
