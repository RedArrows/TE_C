//
//  UserModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/30.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel{
}
-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"name"];
        self.position = [dic objectForKey:@"position"];
        self.imageUrl = [dic objectForKey:@"imageUrl"];
        self.phone = [dic objectForKey:@"phone"];
        self.imagePath = [dic objectForKey:@"imagePath"];
        self.userID = [dic objectForKey:@"userID"];
        self.isShowRemember = [[dic objectForKey:@"isShowRemember"] boolValue];
    }
    return self;
}

+(id)getRememberUser{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]dictionaryRepresentation];
    UserModel *model = [[UserModel alloc]initWithDic:dic];
    
    return model;
}
-(void)saveUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.name) {
        [defaults setValue:self.name forKey:@"name"];
    }
    if (self.position) {
        [defaults setValue:self.position forKey:@"position"];
    }
    if (self.imageUrl) {
        [defaults setValue:self.imageUrl forKey:@"imageUrl"];
    }
    if (self.imagePath) {
        [defaults setValue:self.imagePath forKey:@"imagePath"];
    }
    if (self.userID) {
        [defaults setValue:self.userID forKey:@"userID"];
    }
    if (self.isShowRemember) {
        [defaults setValue:[NSNumber numberWithBool:_isShowRemember] forKey:@"isShowRemember"];
    }
    [defaults synchronize];

}

@end
