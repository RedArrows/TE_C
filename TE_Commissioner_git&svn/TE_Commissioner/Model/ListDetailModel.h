//
//  ListDetailModel.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HEADERTYPE){
    HEADER_photo,
    HEADER_buyer,
    HEADER_seller
    
};

@interface ContactPeople : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *position;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,assign)HEADERTYPE headerType;

-(id)initWithDic:(NSDictionary *)dic;

@end

@interface ListDetailModel : NSObject

@property (nonatomic,copy)NSString *title;//标签页标题
@property (nonatomic,strong)NSArray *sectionArray;//内容数组
@property (nonatomic,strong)NSArray *contactArray;//联系人数组，没有这个就空

-(id)initWithDic:(NSDictionary *)dic;

@end
