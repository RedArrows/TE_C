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

typedef NS_ENUM(NSInteger, VCTYPE){
    VCMyWaitToDo,
    VCMyOnTheWayList,
    VCScanQRCode,
    
};
@interface Tool : NSObject

@property (nonatomic,retain)UINavigationController *mainVC;//主导航控制器存放

@property (nonatomic,assign)BOOL isShowMenu;

@property (nonatomic,strong) TEMenuViewController *menuVC;


+(instancetype)instance;

///点击方法openSliderMenu
+(void)setLeftMenuBarBtn:(UIViewController*)vc;

+(void)hidenMenu:(VCTYPE)type;

+(void)openVCWithType:(VCTYPE)type;



@end
