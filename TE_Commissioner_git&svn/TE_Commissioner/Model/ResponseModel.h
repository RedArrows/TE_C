//
//  ResponseModel.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/23.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseModel : NSObject

@property (nonatomic,assign)BOOL isSuccessed;//是否成功
@property (nonatomic,assign)NSInteger state;//状态
@property (nonatomic,copy)NSString *message;//状态信息
@property (nonatomic,strong)id data;//主数据
@property (nonatomic,strong)NSArray *todoArray;//专为待办事项

-(id)initWithJson:(id)json type:(URLTYPE)type;


@end
