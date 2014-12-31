//
//  LoginViewController.m
//  TE_Commissioner
//
//  Created by shiyao on 14-12-4.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "LoginViewController.h"
#import "PAAImageView.h"
#import "MyWaitingToDoViewController.h"
#import "Tool.h"
#import "AFNetworking.h"
#import "ResponseModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    PAAImageView *_photoImage;
    __weak IBOutlet UILabel *username;
    __weak IBOutlet UILabel *userjob;
    __weak IBOutlet UILabel *login_warning;
    __weak IBOutlet UIView *fieldBack;

    __weak IBOutlet UITextField *HL_ID;
    __weak IBOutlet UITextField *HL_password;
    __weak IBOutlet UIButton *loginBtn;
    
    __weak IBOutlet UIImageView *rememberCheckBox;
    
    BOOL _isRememberUserInfo;
    AFHTTPRequestOperationManager *manager;
    
    CGRect _photoDetailImageRect;
    CGRect _photoShowImageRect;
    
    UserModel *_curUser;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AFHTTPRequestOperationManager manager];

    [self uiConfig];
    _isRememberUserInfo = YES;
    
    [self changeShowUserInfoWithIsHistoryRecord:[Tool instance].curUser.isShowRemember];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    _photoShowImageRect = CGRectMake(40, 40, 90, 90);
    _photoDetailImageRect = CGRectMake(115, 40, 90, 90);
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    self.navigationController.navigationBar.hidden = YES;
    _photoImage = [[PAAImageView alloc]initWithFrame:_photoDetailImageRect
                             backgroundProgressColor:[UIColor lightGrayColor] progressColor:[UIColor whiteColor]];
    [self.view addSubview:_photoImage];
    [_photoImage setImage:[UIImage imageNamed:@"emptyHeadImage"]];
    
    username.hidden = YES;
    userjob.hidden = YES;
    _photoImage.hidden = YES;
    
    fieldBack.layer.borderWidth = 1;
    fieldBack.layer.borderColor = [UIColor grayColor].CGColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)changeShowUserInfoWithIsHistoryRecord:(BOOL)isHistory{
    if (isHistory) {
        [UIView animateWithDuration:0.3 animations:^{
            _photoImage.frame = _photoShowImageRect;
            _photoImage.hidden = NO;
        } completion:^(BOOL finished) {
            username.hidden = NO;
            userjob.hidden = NO;
            if ([Tool instance].curUser.imagePath) {
                [_photoImage setImage:[UIImage imageWithContentsOfFile:[Tool instance].curUser.imagePath]];
            }else{
                [_photoImage setImageURL:[NSURL URLWithString:[Tool instance].curUser.imageUrl]];

            }
        }];
    }else{
        username.hidden = YES;
        userjob.hidden = YES;
        _photoImage.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _photoImage.frame = _photoDetailImageRect;
        } completion:^(BOOL finished) {
            [_photoImage setImage:[UIImage imageNamed:@"emptyHeadImage"]];
        }];
    }
}


- (IBAction)loginClick:(id)sender {

    [manager POST:[Tool getURLWithType:URLTYPE_login] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_login];
        if (model.isSuccessed) {
            if (_isRememberUserInfo) {
                
            }else{
                
            }
            
            MyWaitingToDoViewController *wtdVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
            
            UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
            
            [self presentViewController:mainNav animated:YES completion:^{
                
            }];
        }
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败——》%@",error);

    }];
#ifdef NOINTERNETMODEL
    MyWaitingToDoViewController *wtdVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
    
    [self presentViewController:mainNav animated:YES completion:^{
        
    }];
#endif
    
}



-(void)closeKeyboard{
    [HL_ID resignFirstResponder];
    [HL_password resignFirstResponder];
}

- (IBAction)rememberUsername:(id)sender {
    _isRememberUserInfo = (_isRememberUserInfo)?NO:YES;
    if (_isRememberUserInfo) {
        rememberCheckBox.image = [UIImage imageNamed:@"checkBox_selected"];
    }else{
        rememberCheckBox.image = [UIImage imageNamed:@"checkBox_empty"];
    }
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
