//
//  ListDetailModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListDetailModel.h"

@implementation ContactPeople

-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"name"];
        self.position = [dic objectForKey:@"position"];
        self.phone = [dic objectForKey:@"phone"];
        self.imageUrl = [dic objectForKey:@"imageUrl"];
        
        if ([_position isEqualToString:@"买方"]) {
            self.headerType = HEADER_buyer;
        }else if([_position isEqualToString:@"卖方"]){
            self.headerType = HEADER_seller;
        }else{
            self.headerType = HEADER_photo;
        }
    }
    return self;
}

@end

@implementation ListDetailModel

-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.title = [dic objectForKey:@"title"];
        id data = [dic objectForKey:@"section"];
        if ([data isKindOfClass:[NSArray class]]) {
            self.sectionArray = data;
        }else if([data isKindOfClass:[NSDictionary class]]){
            self.sectionArray = [NSArray arrayWithObject:data];
        }else{
            NSLog(@"解析section失败");
        }
        
        id data2 = [dic objectForKey:@"contactList"];
        if ([data2 isKindOfClass:[NSDictionary class]]) {
            self.contactArray = [NSArray arrayWithObject:[[ContactPeople alloc] initWithDic:data2]];
        }else if([data2 isKindOfClass:[NSArray class]]){
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (NSDictionary *idic in data2) {
                [arr addObject:[[ContactPeople alloc]initWithDic:idic]];
            }
            self.contactArray = arr;
        }else{
        }
    }
    return self;
}

@end
