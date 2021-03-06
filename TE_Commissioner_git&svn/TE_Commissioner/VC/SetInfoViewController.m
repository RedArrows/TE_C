//
//  SetInfoViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/9.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "SetInfoViewController.h"
#import "OpinionViewController.h"
#import "ImprintViewController.h"


@interface SetInfoViewController ()

@end

@implementation SetInfoViewController{
    
    __weak IBOutlet UIButton *checkUpdateBtn;
    __weak IBOutlet UIButton *exitUserBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [Tool setLeftBackBarBtn:self];
    self.title = @"设置";
    
    [self uiConfig];
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    if (ScreenHeight == 480.0) {
        checkUpdateBtn.frame = CGRectMake(checkUpdateBtn.frame.origin.x, checkUpdateBtn.frame.origin.y-26, checkUpdateBtn.frame.size.width, checkUpdateBtn.frame.size.height);
        exitUserBtn.frame = CGRectMake(exitUserBtn.frame.origin.x, exitUserBtn.frame.origin.y-33, exitUserBtn.frame.size.width, exitUserBtn.frame.size.height);
    }
}

//开关推送新业务单 
- (IBAction)switchNotify:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    NSLog(@"---->%d",sw.on);
}

/*提意见  2001
 *更新    2002
 *退出    2003
 */
- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 2001) {
        OpinionViewController *vc = [[OpinionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if  (btn.tag == 2002){
        [MobClick checkUpdateWithDelegate:self selector:@selector(acceptInfo:)];
    }
    if  (btn.tag == 2003){
        [self dismissViewControllerAnimated:YES completion:^{
            [Tool instance].mainVC = nil;
        }];
    }
}

-(void)acceptInfo:(NSDictionary *)info{
    NSLog(@"info----%@",info);
    if ([[info objectForKey:@"update"] isEqualToString:@"NO"]) {
        [Tool showWarning:self.view text:@"无版本更新"];
    }
}


- (IBAction)imprintClick:(id)sender {
    ImprintViewController *imVC = [[ImprintViewController alloc]init];
    [self.navigationController pushViewController:imVC animated:YES];
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
