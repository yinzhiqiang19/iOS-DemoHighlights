//
//  FaceRecognitionViewController.m
//  DemoHighlights
//  人脸识别
//  Created by yinzhiqiang on 2017/12/16.
//  Copyright © 2017年 yinzhiqiang. All rights reserved.
//

#import "FaceRecognitionHomeViewController.h"
#import "FaceDetectionPictureViewController.h"
#import "FaceDetectionVideoViewController.h"
#import "FaceTrackingViewController.h"
#import "FaceRecognitionViewController.h"
#import "OCRViewController.h"
#import "MyCollectionViewCell.h"

#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface FaceRecognitionHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *titleArray;
    NSArray *titleDetailArray;
    NSArray *imageArray;
    NSInteger cellWidth;
}

@property (nonatomic,strong) IBOutlet UICollectionView *myCollectionView;

@end

@implementation FaceRecognitionHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    cellWidth = 90;
    [self.myCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    titleArray = [[NSArray alloc] initWithObjects:@"人脸检测-照片",@"人脸检测-视频",@"人脸跟踪",@"人脸识别",@"OCR", nil];
    titleDetailArray = [[NSArray alloc] initWithObjects:@"从照片中检测出人脸位置，并用矩形框标记",@"从视频中检测出人脸位置，并用矩形框标记",@"实时跟踪人脸位置，并用矩形框标记",@"人脸识别",@"身份证、银行卡、行驶证、驾驶证识别", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"face_detection_icon",@"face_detection_icon",@"face_detection_icon",@"face_detection_icon",@"face_detection_icon", nil];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    //加载图片
    cell.iconImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    //设置label文字
    cell.nameLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (cellWidth < 100) {
        return CGSizeMake(cellWidth, 100);
    }else{
        return CGSizeMake(cellWidth, cellWidth);
    }
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FaceDetectionPictureViewController *picture = [[FaceDetectionPictureViewController alloc] init];
        picture.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:picture animated:YES];
    }else if(indexPath.row == 1){
        FaceDetectionVideoViewController *video = [[FaceDetectionVideoViewController alloc] init];
        video.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:video animated:YES];
    }else if(indexPath.row == 2){
        FaceTrackingViewController *tracking = [[FaceTrackingViewController alloc] init];
        tracking.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:tracking animated:YES];
    }else if(indexPath.row == 3){
        FaceRecognitionViewController *detail = [[FaceRecognitionViewController alloc] init];
        detail.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        OCRViewController *ocr = [[OCRViewController alloc] init];
        ocr.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:ocr animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
