//
//  OptionDetailModel.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/18.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OptionType){
    OptionBrokerName,
    OptionTraderName,
    OptionListNO,//交易编号
    OptionDeclarationDate//报单日期
};

@interface OptionDetailModel : NSObject

@property(nonatomic,copy) NSString* mainText;
@property(nonatomic,assign) OptionType optionType;

-(void)setOptionTypeWithString:(NSString *)title;

@end
