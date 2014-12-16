//
//  LoginViewController.m
//  TE_Commissioner
//
//  Created by shiyao on 14-12-4.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "LoginViewController.h"
#import "PAImageView.h"
#import "MyWaitingToDoViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    PAImageView *_photoImage;
    __weak IBOutlet UILabel *username;
    __weak IBOutlet UILabel *userjob;
    __weak IBOutlet UILabel *login_warning;
    __weak IBOutlet UIView *fieldBack;

    __weak IBOutlet UITextField *HL_ID;
    __weak IBOutlet UITextField *HL_password;
    __weak IBOutlet UIButton *loginBtn;
    
    __weak IBOutlet UIImageView *rememberCheckBox;
    
}



- (IBAction)loginClick:(id)sender {
    MyWaitingToDoViewController *wtdVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
    
    [self presentViewController:mainNav animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    self.navigationController.navigationBar.hidden = YES;
    _photoImage = [[PAImageView alloc]initWithFrame:CGRectMake(40, 40, 90, 90)
                       backgroundProgressColor:[UIColor grayColor] progressColor:[UIColor greenColor]];
    [self.view addSubview:_photoImage];
    [_photoImage updateWithImage:[UIImage imageNamed:@"saberheader.png"] animated:YES];

    fieldBack.layer.borderWidth = 1;
    fieldBack.layer.borderColor = [UIColor grayColor].CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)closeKeyboard{
    [HL_ID resignFirstResponder];
    [HL_password resignFirstResponder];
}

- (IBAction)rememberUsername:(id)sender {
    NSLog(@"记住账号信息！");
    
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
