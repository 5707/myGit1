//
//  laController.m
//  二维码
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "laController.h"

@interface laController ()


@end

@implementation laController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.label1.text = self.str1;
    NSLog(@"%@",_str1);
    
}
- (IBAction)Btn:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
