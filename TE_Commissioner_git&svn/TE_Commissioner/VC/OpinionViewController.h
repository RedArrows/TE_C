//
//  OpinionViewController.h
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/6.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"

@interface OpinionViewController : UIViewController<UMFeedbackDataDelegate>

@property (nonatomic,strong)UMFeedback *umFeedBack;

@end
