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
    NSArray *array = @[@"再次预约办理完税",@"不预约直接办理",@"再次预约办理过户",@"客户已自行办理完税",@"再次办理土地过户",@"客户已自行办理过户",@"挂起",@"连环单",@"时效单"];
    if ([title isEqualToString:@"搜索经纪人/主办"]) {
        _optionType = OptionAgentName;
        _keyText = @"agentName";
    }else if ([title isEqualToString:@"搜索买方/卖方"]) {
        _optionType = OptionClientName;
        _keyText = @"clientName";
    }else if ([title isEqualToString:@"搜索交易编号"]) {
        _optionType = OptionDocumentNO;
        _keyText = @"documentNo";
    }else if ([array containsObject:title]){
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
