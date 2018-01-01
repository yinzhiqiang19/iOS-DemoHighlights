//
//  FaceDetectionPictureViewController.m
//  DemoHighlights
//
//  Created by yinzhiqiang on 2018/1/1.
//  Copyright © 2018年 yinzhiqiang. All rights reserved.
//

#import "FaceDetectionPictureViewController.h"

@interface FaceDetectionPictureViewController ()

@end

@implementation FaceDetectionPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addRightBtn];
}

- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPictureBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)uploadPictureBtnClick {
    NSLog(@"onClickedOKbtn");
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
