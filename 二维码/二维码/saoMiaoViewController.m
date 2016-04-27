//
//  saoMiaoViewController.m
//  二维码
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "saoMiaoViewController.h"
#import "UIView+Frame.h"
#import "laController.h"

//二维码扫描结束后播放自定义铃声
static SystemSoundID system_id = 0;


@interface saoMiaoViewController ()
{
    UIView *line;
    UILabel *_label;
    NSString *str1;
    UIButton *btn1;
    
}
@property (nonatomic,strong)UIImageView *imgView;
@end

@implementation saoMiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x - (self.view.width - 80)/2,10,self.view.width - 80,self.view.width - 80)];
    
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"1.jpg"]];
    self.imgView.layer.cornerRadius = 5;
    
    self.imgView.layer.masksToBounds = YES;
    
    [self.view addSubview:_imgView];
    
    line.hidden = YES;
    
     [self hahhah];
    
     [self labell];
    
     [self buttonn];

    
    // 蓝线
    
    line = [[UIImageView alloc] initWithFrame: CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y, self.preView.frame.size.width, 0.5)];
    
    line.backgroundColor = [UIColor blueColor];
    [self.view addSubview:line ];
    
}
-(void)labell
{_label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x - ((self.view.width - 30)/2), self.view.width - 80 + 10, self.view.width - 30, 50)];
    _label.text = @"二维码显示内容";
    
    _label.textColor = [UIColor redColor];
    
    _label.textAlignment = NSTextAlignmentCenter;
    
    _label.numberOfLines = 0;
    
    _label.adjustsFontSizeToFitWidth = YES;
    
    [self.view addSubview:_label];


}
-(void)buttonn
{
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(self.view.center.x - 40, CGRectGetMaxY(_label.frame)+20, 80, 30);
    
    [btn2 setTitle:@"点击打开" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.center.x - 40, CGRectGetMaxY(btn2.frame)+20, 80, 30);
    
    [btn setTitle:@"重新扫描" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.frame = CGRectMake(self.view.center.x - 75, CGRectGetMaxY(btn.frame)+20, 150, 30);
    
    [btn1 setTitle:@"开始扫描" forState:UIControlStateNormal];
    
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];
    [self.view addSubview:btn];
    [self.view addSubview:btn1];
  
    
}


-(void)click
{
    [_timer invalidate];
    
    [self.session startRunning];
    
    line.hidden = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerr: ) userInfo:nil repeats:YES];
    
}
-(void)click1:(UIButton *)btn
{
    btn.selected = ! btn.selected;
    if(btn.selected == YES)
    {
         _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerr: ) userInfo:nil repeats:YES];
        
        self.imgView.hidden = YES;
        [btn setTitle:@"停止扫描" forState:UIControlStateNormal];
        [self.session startRunning];
        line.hidden = NO;
    }else
    {
        [_timer invalidate];
        self.imgView.hidden = YES;
        [btn setTitle:@"开始扫描" forState:UIControlStateNormal];
        [self.session stopRunning];
        line.hidden = YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerr: ) userInfo:nil repeats:YES];
    }
    
}
-(void)click2
{
    NSURL * url = [NSURL URLWithString: str1];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        [[UIApplication sharedApplication] openURL: url];
    } else {
        
        
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"警告" message:@"无法解析的二维码" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *b = [UIAlertAction actionWithTitle:@"确定返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        UIAlertAction *c = [UIAlertAction actionWithTitle:@"取消重新扫描" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [btn1 setTitle:@"停止扫描" forState:UIControlStateNormal];
             line.hidden = NO;
            
            [UIView animateWithDuration:2.5 animations:^{
                
                line.frame = CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y+self.preView.frame.size.height, self.preView.frame.size.width, 1);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:2.5 animations:^{
                    
                    line.frame = CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y, self.preView.frame.size.width, 1);}];
                
                [self.session startRunning];
                
            }];
            }];
        [a addAction:c];
        [a addAction:b];
        [self presentViewController:a animated:YES completion:nil];
    }


}

-(void)hahhah
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session  = [[AVCaptureSession alloc]init];
    //设置高清摄像头
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //添加输入源，获取扫描图像
    if([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    //添加输出源，输出扫描的字符串
    if([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    //设置输出的结果为二维码；
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //设置扫描区域
    self.preView = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    //设置图片的模式：缩放
    self.preView.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.preView.frame = CGRectMake(self.view.center.x - (self.view.width - 80)/2,10,self.view.width - 80,self.view.width - 80);
    
//    self.preView.layer.cornerRadius = 5;
//    
//    self.preView.layer.masksToBounds = YES;
    
    [self.view.layer insertSublayer:self.preView atIndex:0];
 
 
}

-(void)timerr:(NSTimer *)timer
{
    
    
    
    /* 添加动画 */
    
//    [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
//        
//   line.frame = CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y+240, 250, 3);
//        
//    } completion:^(BOOL finished) {
//    
//        
//        [UIView animateWithDuration:5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
//        
//        line.frame = CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y, 250, 3);
//        } completion:nil ];
//        
//        
//    }];

    [UIView animateWithDuration:2.5 animations:^{
      
        line.frame = CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y+self.preView.frame.size.height, self.preView.frame.size.width, 1);

    } completion:^(BOOL finished) {
      
        [UIView animateWithDuration:2.5 animations:^{
           
            line.frame = CGRectMake(self.preView.frame.origin.x, self.preView.frame.origin.y, self.preView.frame.size.width, 1);

            
        }];
    }];


}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
   
    
    if(metadataObjects.count)
    {
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects firstObject];
        
        str1 = obj.stringValue;
    
    }

    _label.text = str1;
    
    if(_label.text.length >= 100)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labell:)];
        [_label addGestureRecognizer:tap];
        _label.userInteractionEnabled = YES;
    
    }
    
    [self.session stopRunning];
    [_timer invalidate];
    
    line.hidden = YES;
  
    //播放铃声
    NSString *path = [[NSBundle mainBundle]pathForResource:@"beep" ofType:@"wav"];
    if(path)
    {
    //将铃声注册到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &system_id);
    
    }
    
    AudioServicesPlaySystemSound(system_id);
    
}

-(void)labell:(UITapGestureRecognizer *)tap
{
    _label = (UILabel *)tap.view;
    
    laController *la = [[laController alloc]init];
    
    la.str1 = _label.text;
    
    [self presentViewController:la animated:YES completion:nil];
    
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
