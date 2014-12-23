//
//  Tool.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/16.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "Tool.h"
#import "TEMenuViewController.h"
#import "MyOnTheWayListViewController.h"
#import "ScanQRCodeViewController.h"
#import "MyWaitingToDoViewController.h"

@implementation Tool


static Tool *tool = nil;

+(instancetype)instance{
    @synchronized(self){
        if (!tool) {
            tool = [[Tool alloc]init];
        }
        return tool;
    }
}

+(void)setLeftMenuBarBtn:(UIViewController*)vc{
    if (!vc.navigationController) {
        return;
    }
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBarBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBarBtn setBackgroundImage:[UIImage imageNamed:@"btn_menu"] forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(openSliderMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:leftBarBtn];
    vc.navigationItem.leftBarButtonItem = item;
    
    if (![Tool instance].mainVC ) {
        [Tool instance].mainVC = vc.navigationController;
    }
}

+(void)openSliderMenu
{
    
    if (![Tool instance].isShowMenu) {
        
        [Tool instance].isShowMenu = YES;
        
        [Tool instance].menuVC = [[TEMenuViewController alloc] init];
        [tool.mainVC.view addSubview:[Tool instance].menuVC.view];
        
        [Tool instance].menuVC.view.frame = CGRectMake(-160, 64, 160, 504);
        CGRect rect = [Tool instance].menuVC.view.frame;
        rect.origin.x = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            [Tool instance].menuVC.view.frame = rect;
        }];
    }else{
        [Tool instance].isShowMenu = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [Tool instance].menuVC.view.frame = CGRectMake(-160, 64, 160, 504);
        }];
    }
}

+(void)hidenMenu:(VCTYPE)type
{
    [Tool instance].isShowMenu = NO;

    [UIView animateWithDuration:0.3 animations:^{
        [Tool instance].menuVC.view.frame = CGRectMake(-160, 64, 160, 504);
    } completion:^(BOOL finished) {
        [[Tool instance].mainVC popViewControllerAnimated:YES];
    }];
    [Tool openVCWithType:type];
}

+(void)openVCWithType:(VCTYPE)type{
    UIViewController *willOpenVC = nil;
    
    switch (type) {
        case VCMyWaitToDo:{
            if ([tool.mainVC.topViewController isKindOfClass:[MyWaitingToDoViewController class]]) {
                break;
            }
            willOpenVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
        }
            break;
        case VCMyOnTheWayList:{
            if ([tool.mainVC.topViewController isKindOfClass:[MyOnTheWayListViewController class]]) {
                break;
            }
            willOpenVC = [[MyOnTheWayListViewController alloc]initWithNibName:@"MyOnTheWayListViewController" bundle:[NSBundle mainBundle]];
        }
            break;
        case VCScanQRCode:{
            if ([tool.mainVC.topViewController isKindOfClass:[ScanQRCodeViewController class]]) {
                break;
            }
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                //your code
                willOpenVC = [[ScanQRCodeViewController alloc]initWithNibName:@"ScanQRCodeViewController" bundle:[NSBundle mainBundle]];
            }else{
                NSLog(@">_<没摄像头扫你妹的🐴！");
                
            }
            
            

        }
            break;
            
        default:
            break;
    }
    if (willOpenVC) {
        [tool.mainVC setViewControllers:[NSArray arrayWithObject:willOpenVC] animated:YES];
    }

}




@end
