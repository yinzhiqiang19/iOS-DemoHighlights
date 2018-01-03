//
//  OCRViewController.m
//  DemoHighlights
//  OCR识别
//  Created by yinzhiqiang on 2018/1/3.
//  Copyright © 2018年 yinzhiqiang. All rights reserved.
//

#import "OCRViewController.h"
#import "IDCardRecognitionViewController.h"
#import "BankCardRecognitionViewController.h"
#import "DriveLicenseRecognitionViewController.h"
#import "DriveCardRecognitionViewController.h"

#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3

@interface OCRViewController ()
{
    NSArray *titleArray;
    NSArray *titleDetailArray;
    NSArray *imageArray;
}

@property (nonatomic,strong) IBOutlet UITableView *myTableView;

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    titleArray = [[NSArray alloc] initWithObjects:@"身份证识别",@"银行卡识别",@"行驶证识别",@"驾驶证识别", nil];
    titleDetailArray = [[NSArray alloc] initWithObjects:@"识别身份证中的信息",@"识别银行卡的信息",@"识别行驶证中的信息",@"识别驾驶证中的信息", nil];
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
        IDCardRecognitionViewController *picture = [[IDCardRecognitionViewController alloc] init];
        picture.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:picture animated:YES];
    }else if(indexPath.row == 1){
        BankCardRecognitionViewController *video = [[BankCardRecognitionViewController alloc] init];
        video.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:video animated:YES];
    }else if(indexPath.row == 2){
        DriveLicenseRecognitionViewController *tracking = [[DriveLicenseRecognitionViewController alloc] init];
        tracking.title = [titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:tracking animated:YES];
    }else if(indexPath.row == 3){
        DriveCardRecognitionViewController *detail = [[DriveCardRecognitionViewController alloc] init];
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
