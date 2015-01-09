//
//  UserModel.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/30.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "UserModel.h"

#define positionKey @"currentPositionName"
#define phoneKey @"mobile"
#define nameKey @"userName"
#define imageUrlKey @"image"

@implementation UserModel{
}
-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:nameKey];
        self.position = [dic objectForKey:positionKey];
        self.imageUrl = [dic objectForKey:imageUrlKey];
        self.phone = [dic objectForKey:phoneKey];
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
        [defaults setValue:self.name forKey:nameKey];
    }
    if (self.position) {
        [defaults setValue:self.position forKey:positionKey];
    }
    if (self.imageUrl) {
        [defaults setValue:self.imageUrl forKey:imageUrlKey];
    }
    if (self.imagePath) {
        [defaults setValue:self.imagePath forKey:@"imagePath"];
    }
    if (self.phone) {
        [defaults setValue:self.imagePath forKey:phoneKey];
    }
    if (self.userID) {
        [defaults setValue:self.userID forKey:@"userID"];
    }
    [defaults setValue:[NSNumber numberWithBool:_isShowRemember] forKey:@"isShowRemember"];
    [defaults synchronize];

}

@end
