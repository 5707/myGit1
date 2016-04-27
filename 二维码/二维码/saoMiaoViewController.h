//
//  saoMiaoViewController.h
//  二维码
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//扫描二维码需要摄像头，需要导入

#import <AVFoundation/AVFoundation.h>


@interface saoMiaoViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureDevice *device;//扫描设备

@property(nonatomic,strong)AVCaptureDeviceInput *input;
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preView;//扫描；
@property(nonatomic,strong)NSTimer *timer;

@end
