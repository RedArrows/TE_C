//
//  UserModel.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/30.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *position;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *phone;

@property (nonatomic,copy)NSString *userID;
@property (nonatomic,copy)NSString *imagePath;
@property (nonatomic,assign)BOOL isShowRemember;


-(id)initWithDic:(NSDictionary *)dic;



+(id)getRememberUser;

//记录账号信息
-(void)saveUser;


@end
