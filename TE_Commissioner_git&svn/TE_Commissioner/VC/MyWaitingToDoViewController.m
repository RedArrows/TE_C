//
//  MyWaitingToDoViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/8.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "MyWaitingToDoViewController.h"
#import "PAAImageView.h"
#import "SetInfoViewController.h"
#import "ScanQRCodeViewController.h"
#import "MyOnTheWayListViewController.h"
#import "MyWaitToDoModel.h"
#import "UserModel.h"

@interface MyWaitingToDoViewController ()

@end

@implementation MyWaitingToDoViewController{
    
    __weak IBOutlet UIView *headView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *jobLabel;
    __weak IBOutlet UILabel *phoneLabel;
    PAAImageView * _photoImage;
    __weak IBOutlet UIButton *orderRatepaying;//预约缴税过户
    __weak IBOutlet UIButton *checkRatePaying;//登记完税结果
    
    __weak IBOutlet UIButton *checkTransfer;//登记过户结果
    __weak IBOutlet UIButton *CheckTransferLand;//登记土地过户结果
    
    AFHTTPRequestOperationManager *manager;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [manager.operationQueue cancelAllOperations];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AFHTTPRequestOperationManager manager];
    
    self.navigationController.navigationBar.barTintColor = UICOLOR_RGB_Alpha(0x313131, 1);
    self.title = @"我的待办";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    _photoImage = [[PAAImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)
                            backgroundProgressColor:[UIColor lightGrayColor] progressColor:[UIColor whiteColor]];
    [headView addSubview:_photoImage];
    [_photoImage setImage:[UIImage imageNamed:@"saberheader.png"]];
    
    [Tool setLeftMenuBarBtn:self];
    
    [self requestList];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)requestList{
    
    [manager POST:[Tool getURLWithType:URLTYPE_myWaitToDo] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_myWaitToDo];
        if (model.isSuccessed&&model.data) {
            MyWaitToDoModel *m = [model.data objectAtIndex:0];
            [orderRatepaying setTitle:[NSString stringWithFormat:@"%li",m.orderRatepayingNum] forState:UIControlStateNormal];
            [checkRatePaying setTitle:[NSString stringWithFormat:@"%li",m.checkRatepayingNum] forState:UIControlStateNormal];
            [checkTransfer setTitle:[NSString stringWithFormat:@"%li",m.checkTransferNum] forState:UIControlStateNormal];
            [CheckTransferLand setTitle:[NSString stringWithFormat:@"%li",m.checkTransferLandNum] forState:UIControlStateNormal];


        }
        NSLog(@"成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
    
    [manager POST:[Tool getURLWithType:URLTYPE_userInfo] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_userInfo];
        if (model.isSuccessed&&model.data) {
            UserModel *m = [model.data objectAtIndex:0];
            nameLabel.text = m.name;
            phoneLabel.text = m.phone;
            [_photoImage setImageURL:[NSURL URLWithString:m.imageUrl]];
            jobLabel.text = m.position;
        }
        NSLog(@"成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}

-(void)openSliderMenu{
    NSLog(@"open slider Menu");
}


/*预约缴税过户 2001
 *登记完税结果 2002
 *登记过户结果 2003
 *登记土地过户 2004
 */
- (IBAction)clickBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"---执行-->%li",(long)btn.tag);
    switch (btn.tag) {
        case 2001:
        {
            [Tool openVCWithType:VC_OrderRatepaying];
        }
            break;
        case 2002:
        {
            [Tool openVCWithType:VC_CheckRatePaying];
        }
            break;
        case 2003:
        {
            [Tool openVCWithType:VC_CheckTransfer];
        }
            break;
        case 2004:
        {
            [Tool openVCWithType:VC_CheckTransferLand];
        }
            break;
            
        default:
            break;
    }
    
    
}
- (IBAction)setClick:(id)sender {
    SetInfoViewController *setVC = [[SetInfoViewController alloc]initWithNibName:@"SetInfoViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (IBAction)scanQRCode:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        //your code
        [Tool openVCWithType:VC_ScanQRCode];
        
    }else{
        NSLog(@">_<没摄像头扫你妹的🐴！");
        
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
