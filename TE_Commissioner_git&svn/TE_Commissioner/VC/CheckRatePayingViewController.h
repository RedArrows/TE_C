//
//  CheckRatePayingViewController.h
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/5.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckRatePayingViewController : UIViewController

@property (nonatomic,assign)BOOL isShowExamine;//当为公积金.市属时激活此项，显示特别标签
@property (nonatomic,copy)NSString *documentNO;

@end
