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
#import "ErrorPageViewController.h"
#import "CheckRatePayingViewController.h"

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
    BOOL _isShowUserInfo;//用于控制文本框内容变化时，改变用户信息显示
    
    AFHTTPRequestOperationManager *manager;
    
    CGRect _photoDetailImageRect;
    CGRect _photoShowImageRect;
    
    UserModel *_curUser;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AFHTTPRequestOperationManager manager];

    [self uiConfig];
    
    [self rememberUserChangeShow:[Tool instance].curUser.isShowRemember];

    [self changeShowUserInfoWithIsHistoryRecord:[Tool instance].curUser.isShowRemember];
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.labelText = @"提交意见失败";
//    hud.progress = 0.7;
//    hud.labelColor = [UIColor whiteColor];
//    [hud hide:YES afterDelay:5];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    HL_ID.delegate = self;
    [HL_ID addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        
    _photoShowImageRect = CGRectMake(40, 40, 90, 90);
    _photoDetailImageRect = CGRectMake(115, 40, 90, 90);
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    self.navigationController.navigationBar.hidden = YES;
    _photoImage = [[PAAImageView alloc]initWithFrame:_photoDetailImageRect
                             backgroundProgressColor:UICOLOR_RGB_Alpha(0x80C8A1, 1) progressColor:[UIColor whiteColor]];
    [self.view addSubview:_photoImage];
    [_photoImage setImage:[UIImage imageNamed:@"emptyHeadImage"]];
    
    username.hidden = YES;
    userjob.hidden = YES;
    _photoImage.hidden = YES;
    
    fieldBack.layer.borderWidth = 1;
    fieldBack.layer.borderColor = UICOLOR_RGB_Alpha(0xcfcfcf, 1).CGColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tap];
}

///切换是否显示历史记录信息
-(void)changeShowUserInfoWithIsHistoryRecord:(BOOL)isHistory{
    if (isHistory) {
        [UIView animateWithDuration:0.3 animations:^{
            _photoImage.frame = _photoShowImageRect;
            _photoImage.hidden = NO;
        } completion:^(BOOL finished) {
            username.hidden = NO;
            userjob.hidden = NO;
            _isShowUserInfo = YES;
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
        _isShowUserInfo = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _photoImage.frame = _photoDetailImageRect;
        } completion:^(BOOL finished) {
            [_photoImage setImage:[UIImage imageNamed:@"emptyHeadImage"]];
        }];
    }
}


- (IBAction)loginClick:(id)sender {
    [self closeKeyboard];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:HL_ID.text,@"userName",HL_password.text,@"password", nil];
    NSLog(@"参数---》%@",params);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:[Tool getURLWithType:URLTYPE_login] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_login];
        if (model.isSuccessed&&model.data) {
            
            UserModel *m = [model.data objectAtIndex:0];
            [Tool instance].curUser.name = m.name;
            [Tool instance].curUser.position = m.position;
            if ([m.imageUrl hasPrefix:@"http://"]) {
                [Tool instance].curUser.imageUrl = m.imageUrl;
            }else{
                [Tool instance].curUser.imageUrl = [NSString stringWithFormat:@"http://%@",m.imageUrl];
            }
            [Tool instance].curUser.phone = m.phone;
            [[Tool instance].curUser saveUser];
            
            [Tool instance].curUser.isShowRemember = _isRememberUserInfo;
            [Tool instance].curUser.userID = HL_ID.text;
            
            [[Tool instance].curUser saveUser];
//            
//            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:[Tool getURLWithType:URLTYPE_login]]];
//                NSLog(@"---->%@",cookies);

            MyWaitingToDoViewController *wtdVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
            
            UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
            
            [self presentViewController:mainNav animated:YES completion:^{
                
            }];
            
        }else{
            login_warning.text = model.message;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败——》%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ErrorPageViewController *wtdVC = [[ErrorPageViewController alloc]init];
        
        UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
        
        [self presentViewController:mainNav animated:YES completion:^{
            
        }];
    }];
    

//    [manager POST:[Tool getURLWithType:URLTYPE_login] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_login];
//        if (model.isSuccessed) {
//            [Tool instance].curUser.isShowRemember = _isRememberUserInfo;
//            [Tool instance].curUser.userID = HL_ID.text;
//            [[Tool instance].curUser saveUser];
//            
//            MyWaitingToDoViewController *wtdVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
//            
//            UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
//            
//            [self presentViewController:mainNav animated:YES completion:^{
//                
//            }];
//        }else{
//            
//        }
//        login_warning.text = model.message;
//        NSLog(@"成功");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"失败——》%@",error);
//
//    }];
#ifdef NOINTERNETMODEL
//    CheckRatePayingViewController *wtdVC = [[CheckRatePayingViewController alloc]init];
//    wtdVC.isShowExamine = YES;
//    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
//    
//    [self presentViewController:mainNav animated:YES completion:^{
//        
//    }];
    
    MyWaitingToDoViewController *wtdVC = [[MyWaitingToDoViewController alloc]initWithNibName:@"MyWaitingToDoViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
    
    [self presentViewController:mainNav animated:YES completion:^{
        
    }];
#endif
    
}


///收键盘
-(void)closeKeyboard{
    [HL_ID resignFirstResponder];
    [HL_password resignFirstResponder];
}


//点击时，切换复选框显示
- (IBAction)rememberUsername:(id)sender {
    _isRememberUserInfo = (_isRememberUserInfo)?NO:YES;
    if (_isRememberUserInfo) {
        rememberCheckBox.image = [UIImage imageNamed:@"checkBox_selected"];
    }else{
        rememberCheckBox.image = [UIImage imageNamed:@"checkBox_empty"];
    }
}

///页面初始化时，切换选框显示
- (void)rememberUserChangeShow:(BOOL)isShow {
    _isRememberUserInfo = isShow;
    _isShowUserInfo = isShow;
    username.text = [Tool instance].curUser.name;
    userjob.text = [Tool instance].curUser.position;

    if (_isRememberUserInfo) {
        HL_ID.text = [Tool instance].curUser.userID;
        rememberCheckBox.image = [UIImage imageNamed:@"checkBox_selected"];
    }else{
        rememberCheckBox.image = [UIImage imageNamed:@"checkBox_empty"];
    }
}

///随账号信息变化显示数据
-(void)textFieldValueChanged:(UILabel *)label{
//    NSLog(@"userID----%@",label.text);
    if ([[Tool instance].curUser.userID isEqual:label.text]&&!_isShowUserInfo) {
        [self changeShowUserInfoWithIsHistoryRecord:YES];
    }else if(![[Tool instance].curUser.userID isEqual:label.text]&&_isShowUserInfo){
        [self changeShowUserInfoWithIsHistoryRecord:NO];
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
