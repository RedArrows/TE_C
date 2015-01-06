//
//  Tool.h
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/16.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import"TEMenuViewController.h"
#import "UserModel.h"


typedef NS_ENUM(NSInteger, VCTYPE){
    VC_UNKNOW,
    VC_MyWaitToDo,
    VC_MyOnTheWayList,
    VC_ScanQRCode,
    VC_OrderRatepaying,//预约缴税过户
    VC_CheckRatePaying,//登记完税结果
    VC_CheckTransfer,//登记过户结果
    VC_CheckTransferLand,//登记土地过户结果
    
    
};
typedef NS_ENUM(NSInteger,URLTYPE){
    URLTYPE_login,
    URLTYPE_userInfo,
    URLTYPE_myWaitToDo,
    URLTYPE_myOnThewayList,
    URLTYPE_listDetail
};

#define NOINTERNETMODEL //无网络通行模式

@interface UIViewController(muban)

@property (nonatomic,assign)VCTYPE VCType;

@end


@interface Tool : NSObject

@property (nonatomic,retain)UINavigationController *mainVC;//主导航控制器存放

@property (nonatomic,assign)BOOL isShowMenu;

@property (nonatomic,strong) UserModel* curUser;

@property (nonatomic,strong) TEMenuViewController *menuVC;


+(instancetype)instance;

///点击方法openSliderMenu
+(void)setLeftMenuBarBtn:(UIViewController*)vc;

///添加返回pop
+(void)setLeftBackBarBtn:(UIViewController*)vc;

+(void)hidenMenu:(VCTYPE)type;

+(void)openVCWithType:(VCTYPE)type;

+(NSString *)getURLWithType:(URLTYPE)type;



@end

@interface UITableViewCell(moban)

-(void)uiConfig;

@end
