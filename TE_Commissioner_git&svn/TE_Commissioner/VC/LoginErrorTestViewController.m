//
//  LoginErrorTestViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/22.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "LoginErrorTestViewController.h"

@interface LoginErrorTestViewController ()

@end

@implementation LoginErrorTestViewController{
    
    __weak IBOutlet UILabel *InfoLabel;
    __weak IBOutlet UIImageView *backImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"异次元空间";
    if (_errorString) {
        InfoLabel.text = _errorString;

    }else{
        InfoLabel.text = @"无错误信息！";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    self.navigationController.navigationBar.barTintColor = UICOLOR_RGB_Alpha(0x404040, 1);
    
    [self performSelector:@selector(changeAlpha) withObject:nil afterDelay:0.5];
    // Do any additional setup after loading the view from its nib.
}
-(void)changeAlpha{
    [UIView animateWithDuration:2 animations:^{
        InfoLabel.alpha = 1;
    }];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
