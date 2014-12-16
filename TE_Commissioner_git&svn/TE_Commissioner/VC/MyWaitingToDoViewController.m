//
//  MyWaitingToDoViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/8.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "MyWaitingToDoViewController.h"
#import "PAImageView.h"
#import "SetInfoViewController.h"
#import "ScanQRCodeViewController.h"
#import "MyOnTheWayListViewController.h"

@interface MyWaitingToDoViewController ()

@end

@implementation MyWaitingToDoViewController{
    
    __weak IBOutlet UIView *headView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *jobLabel;
    __weak IBOutlet UILabel *phoneLabel;
    PAImageView * _photoImage;
    __weak IBOutlet UIButton *orderRatepaying;//预约缴税过户
    __weak IBOutlet UIButton *checkRatePaying;//登记完税结果
    
    __weak IBOutlet UIButton *orderTransfer;//登记土地过户
    __weak IBOutlet UIButton *checkTransfer;//登记过户结果
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.title = @"我的待办";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    _photoImage = [[PAImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)
                            backgroundProgressColor:[UIColor grayColor] progressColor:[UIColor greenColor]];
    [headView addSubview:_photoImage];
    [_photoImage updateWithImage:[UIImage imageNamed:@"saberheader.png"] animated:YES];
    
    [Tool setLeftMenuBarBtn:self];
    

    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)openSliderMenu{
    NSLog(@"open slider Menu");
}


/*预约缴税过户 2001
 *登记完税结果 2002
 *登记土地过户 2003
 *登记过户结果 2004
 */
- (IBAction)clickBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"---执行-->%li",(long)btn.tag);
    switch (btn.tag) {
        case 2001:
        {
            MyOnTheWayListViewController* otwVC = [[MyOnTheWayListViewController alloc]initWithNibName:@"MyOnTheWayListViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:otwVC animated:YES];
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
        ScanQRCodeViewController *SQVC = [[ScanQRCodeViewController alloc]initWithNibName:@"ScanQRCodeViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:SQVC animated:YES];
        
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
