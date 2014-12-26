//
//  ResponseModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/23.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ResponseModel.h"
#import "ListModel.h"
#import "ListDetailModel.h"

@implementation ResponseModel

-(id)initWithJson:(id)json type:(URLTYPE)type;
{
    self = [super init];
    if (self) {
        NSDictionary *mainDic = nil;
        if ([json isKindOfClass:[NSDictionary class]]) {
            mainDic = json;
        }else{
            mainDic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        }
        
        self.state = [[mainDic objectForKey:@"state"] integerValue];
        if (self.state == 1) {
            self.isSuccessed = YES;
        }
        self.message = [mainDic objectForKey:@"message"];
        
        switch (type) {
            case URLTYPE_myOnThewayList:
            {
                NSArray *array = [mainDic objectForKey:@"list"];
                NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                for (NSDictionary *dic in array) {
                    ListModel *model = [[ListModel alloc]initWithDic:dic];
                    [dataArray addObject:model];
                }
                self.data = dataArray;
            }
                break;
            case URLTYPE_listDetail:{
                _todoArray = [mainDic objectForKey:@"todo"];
                NSArray *array = [mainDic objectForKey:@"tab"];
                NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                for (NSDictionary *dic in array) {
                    ListDetailModel *model = [[ListDetailModel alloc]initWithDic:dic];
                    [dataArray addObject:model];
                }
                self.data = dataArray;
            }
                break;
            default:
                break;
        }
    }
    return self;
}

@end
