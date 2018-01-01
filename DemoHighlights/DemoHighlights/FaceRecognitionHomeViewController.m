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

#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3

@interface FaceRecognitionHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
    NSArray *titleDetailArray;
    NSArray *imageArray;
}

@property (nonatomic,strong) IBOutlet UITableView *myTableView;

@end

@implementation FaceRecognitionHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    titleArray = [[NSArray alloc] initWithObjects:@"人脸检测-照片",@"人脸检测-视频",@"人脸跟踪",@"人脸识别", nil];
    titleDetailArray = [[NSArray alloc] initWithObjects:@"从照片中检测出人脸位置，并用矩形框标记",@"从视频中检测出人脸位置，并用矩形框标记",@"实时跟踪人脸位置，并用矩形框标记",@"人脸识别", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"face_detection_icon",@"face_detection_icon",@"face_detection_icon",@"face_detection_icon", nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ImageOnRightCell";
    UILabel *mainLabel, *secondLabel;
    UIImageView *photo;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        photo = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 8.0, 45.0, 45.0)];
        photo.tag = PHOTO_TAG;
        [cell.contentView addSubview:photo];
        
        mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(65.0, 10.0, 220.0, 15.0)];
        mainLabel.tag = MAINLABEL_TAG;
        mainLabel.font = [UIFont systemFontOfSize:15.0];
        mainLabel.textAlignment = NSTextAlignmentLeft;
        mainLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:mainLabel];
        
        secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(65.0, 30.0, 220.0, 35.0)];
        secondLabel.tag = SECONDLABEL_TAG;
        secondLabel.font = [UIFont systemFontOfSize:13.0];
        secondLabel.textAlignment = NSTextAlignmentLeft;
        secondLabel.textColor = [UIColor lightGrayColor];
        secondLabel.numberOfLines = 2;
        [cell.contentView addSubview:secondLabel];
    } else {
        photo = (UIImageView *)[cell.contentView viewWithTag:PHOTO_TAG];
        mainLabel = (UILabel *)[cell.contentView viewWithTag:MAINLABEL_TAG];
        secondLabel = (UILabel *)[cell.contentView viewWithTag:SECONDLABEL_TAG];
    }
    
    mainLabel.text = [titleArray objectAtIndex:indexPath.row];
    secondLabel.text = [titleDetailArray objectAtIndex:indexPath.row];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    
    photo.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];//theImage;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
    }
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
