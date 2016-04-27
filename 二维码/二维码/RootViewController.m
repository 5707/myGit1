//
//  RootViewController.m
//  二维码
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RootViewController.h"
#import "saoMiaoViewController.h"
#import "shengChengViewController.h"
#import "UIView+Frame.h"

@interface RootViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
@property(nonatomic,strong)UIScrollView *scr;


@end

@implementation RootViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _seg.tintColor = [UIColor colorWithRed:20/255.0 green:188/255.0 blue:227/255.0 alpha:1];
    _seg.backgroundColor = [UIColor colorWithRed:194/255.0 green:254/255.0 blue:244/255.0 alpha:1];

    
    [self scrrr];
    
}

- (IBAction)seg:(UISegmentedControl *)sender {
    
    [_scr setContentOffset:CGPointMake(_scr.width * sender.selectedSegmentIndex, 0) animated:YES];
    
}



-(void)scrrr
{
    _scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 54, self.view.width, self.view.height - 50)];
    _scr.pagingEnabled = YES;
    
    _scr.delegate = self;
    
    _scr.showsHorizontalScrollIndicator = NO;
    
    _scr.showsVerticalScrollIndicator = NO;
    
    _scr.bounces = NO;
    
    _scr.contentSize = CGSizeMake(_scr.width * 2, 0);
    
    [self.view addSubview:_scr];
    
    if (TARGET_IPHONE_SIMULATOR)
    {
        NSLog(@"当前设备是模拟器,无法扫描二维码");
        
    }else
    {
        saoMiaoViewController *saomiao = [[saoMiaoViewController alloc]init];
        saomiao.view.frame = CGRectMake(0, 0, _scr.width, _scr.height);
        
        [self addChildViewController:saomiao];
        
        [_scr addSubview:saomiao.view];
        //[self presentViewController:saomiao animated:YES completion:nil];
    }

    
    shengChengViewController *sc = [[shengChengViewController alloc]init];
    sc.view.frame = CGRectMake(_scr.width , 0, _scr.width, _scr.height);
    
    [self addChildViewController:sc];
    
    [_scr addSubview:sc.view];
    
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page  = self.scr.contentOffset.x / self.scr.width;
    
    self.seg.selectedSegmentIndex = page;
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
