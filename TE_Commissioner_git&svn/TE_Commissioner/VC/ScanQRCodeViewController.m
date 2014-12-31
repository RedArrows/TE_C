//
//  ScanQRCodeViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/9.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "ResultForQRCodeViewController.h"

@interface ScanQRCodeViewController ()
{
    ResultForQRCodeViewController *resultVC;
}

@end

@implementation ScanQRCodeViewController{
    
}

-(void)dealloc
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_session stopRunning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupCamera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    [Tool setLeftBackBarBtn:self];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setupCamera{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(30,110,260,260);
//    [self.view.layer insertSublayer:self.preview atIndex:0];
    [self.view.layer addSublayer:_preview];
    
    
    // Start
    [_session startRunning];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ---- AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    NSLog(@"%@",stringValue);
//    if (!resultVC) {
        resultVC = [[ResultForQRCodeViewController alloc]initWithNibName:@"ResultForQRCodeViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:resultVC animated:YES];
//    }

//    [self dismissViewControllerAnimated:YES completion:^
//     {
//     }];
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
