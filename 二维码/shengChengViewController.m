//
//  shengChengViewController.m
//  二维码
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "shengChengViewController.h"
#import "UIView+Frame.h"

@interface shengChengViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UITextField *tf;

@property(nonatomic,strong)UILabel *label;

@end

@implementation shengChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //UIView *v = [[UIView alloc]initWithFrame:self.view.bounds];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    im.image = [UIImage imageNamed:@"12"];
    
    [self.view addSubview:im];
    
   // [self.view sendSubviewToBack:im];
    
    
    [self.view addSubview:im];
    
    
    [self.view sendSubviewToBack:im];
    
    
    
   
    
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x - (self.view.width - 80)/2,10,self.view.width - 80,self.view.width - 80)];
    
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"1.jpg"]];
    
    self.imgView.layer.cornerRadius = 5;
    
    self.imgView.layer.masksToBounds = YES;
    
    [self.view addSubview:_imgView];
    
   // [self erweima];
    
    [self textFilee];
    
}

-(void)textFilee
{
    _tf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.imgView.frame) , CGRectGetMaxY(self.imgView.frame )+20, self.imgView.width, 30)];
    
    _tf.placeholder = @"请输入要生成二维码的字";
    
    _tf.borderStyle = UITextBorderStyleRoundedRect;
    
    _tf.textColor = [UIColor greenColor];
    
    _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _tf.delegate = self;
    
    _tf.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:_tf];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(self.imgView.frame.origin.x, CGRectGetMaxY(self.imgView.frame )+55, _tf.width/2 - 10, 30);
    [btn setTitle:@"生成二维码" forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor colorWithRed:253/255.0 green:187/255.0 blue:30/255.0 alpha:1]];
    
    btn.layer.cornerRadius = 5;
    
    
    
    [btn addTarget:self action:@selector(ClickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.frame = CGRectMake(self.imgView.center.x +5, CGRectGetMaxY(self.imgView.frame )+55, _tf.width/2 - 5, 30);
    [btn1 setTitle:@"保存图片" forState:UIControlStateNormal];
    
    [btn1 setBackgroundColor:[UIColor colorWithRed:253/255.0 green:187/255.0 blue:30/255.0 alpha:1]];
    
    btn1.layer.cornerRadius = 5;
    
    
    
    [btn1 addTarget:self action:@selector(ClickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];

    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_tf.frame.origin.x, CGRectGetMaxY(btn1.frame) + 5, _tf.width, 100)];
    _label.textColor = [UIColor redColor];
    
    _label.numberOfLines = 0;
    
    _label.adjustsFontSizeToFitWidth = YES;
    
    [self.view addSubview:_label];
    
     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 注册监听：
    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
  
}
- (void)keyBoardWillShow:(NSNotification *)noti
{
    NSLog(@"键盘弹出");
   // NSLog(@"%@", noti.userInfo);
    CGRect keyFrame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat keyHeight = keyFrame.size.height; // 键盘的高度;
    CGFloat h =  self.view.height - keyHeight;

    NSLog(@"keyHeight==%f,h=%f,field.maxy=%f",keyHeight,h,CGRectGetMaxY(self.tf.frame));
    
    if ( CGRectGetMaxY(self.tf.frame) < h)
    { // 意味着键盘挡住textField:
        CGRect rect = self.view.frame;
        rect.origin.y = keyHeight - h; // textFiled的父视图，往上移动;
        
        NSLog(@"y==%f",rect.origin.y);
        
        self.view.frame = rect;
        NSLog(@"键盘dddddd  %f  %f ",self.view.frame.origin.x,self.view.bounds.origin.x);

        
    }
}

- (void)keyBoardWillHide:(NSNotification *)noti
{
    NSLog(@"键盘收起 ");
    //self.view.frame = self.view.bounds;
    
    self.view.frame = CGRectMake(375, 0, self.view.width, self.view.height);
    
    NSLog(@"键盘收起  %f  %f ",self.view.frame.origin.x,self.view.bounds.origin.x);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

//在label上显示输入的内容
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    _label.text = temp;
    
    return YES;
    
}


-(void)ClickBtn1
{
    UIImage *im = [UIImage imageNamed: @"00"];
    
    UIImageWriteToSavedPhotosAlbum(im, nil, nil, nil);

}

-(void)ClickBtn
{
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[_tf.text dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    _imgView.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
    
    
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    
    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
    
    _imgView.layer.shadowRadius=1;//设置阴影的半径
    
    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    
    _imgView.layer.shadowOpacity=0.3;
    


}




-(void)erweima

{
    
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[_tf.text dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    _imgView.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
    
    
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    
    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
    
    _imgView.layer.shadowRadius=1;//设置阴影的半径
    
    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    
    _imgView.layer.shadowOpacity=0.3;
    
    
    
}

//改变二维码大小

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
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
