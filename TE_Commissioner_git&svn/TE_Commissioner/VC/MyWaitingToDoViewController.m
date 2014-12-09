//
//  MyWaitingToDoViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/8.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "MyWaitingToDoViewController.h"
#import "PAImageView.h"

@interface MyWaitingToDoViewController ()

@end

@implementation MyWaitingToDoViewController{
    
    __weak IBOutlet UIView *headView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *jobLabel;
    __weak IBOutlet UILabel *phoneLabel;
    PAImageView * _photoImage;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.title = @"我的待办";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    NSLog(@"---->%@",self.navigationController.title);
    
    _photoImage = [[PAImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)
                            backgroundProgressColor:[UIColor grayColor] progressColor:[UIColor greenColor]];
    [headView addSubview:_photoImage];
    [_photoImage updateWithImage:[UIImage imageNamed:@"saberheader.png"] animated:YES];
    
    // Do any additional setup after loading the view from its nib.
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
