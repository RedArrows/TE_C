//
//  OpinionViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/6.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()

@end

@implementation OpinionViewController{
    
    __weak IBOutlet UITextView *textView;
    
    AFHTTPRequestOperationManager *manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要提意见";
    [Tool setLeftBackBarBtn:self];
    manager = [AFHTTPRequestOperationManager manager];
    [self uiConfig];
    
    // Do any additional setup after loading the view from its nib.
    
}
-(void)uiConfig{
    
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)closeKeyboard{
    [textView resignFirstResponder];
}

- (IBAction)submitClick:(id)sender {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:[Tool instance].curUser.name forKey:@"userName"];
    [params setObject:[Tool instance].curUser.userID forKey:@"userCode"];
    [params setObject:[Tool instance].curUser.phone forKey:@"mobile"];
    [params setObject:textView.text forKey:@"opinion"];

    
    [manager GET:[Tool getURLWithType:URLTYPE_opinion] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_opinion];
        if (model.isSuccessed) {
            
        }
        NSLog(@"成功%@",responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        
        
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
