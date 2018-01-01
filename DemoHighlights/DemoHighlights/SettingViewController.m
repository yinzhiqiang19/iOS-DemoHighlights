//
//  SettingViewController.m
//  DemoHighlights
//
//  Created by yinzhiqiang on 2018/1/1.
//  Copyright © 2018年 yinzhiqiang. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"

#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
    NSArray *titleDetailArray;
    NSArray *imageArray;
}

@property (nonatomic,strong) IBOutlet UITableView *myTableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    _myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    titleArray = [[NSArray alloc] initWithObjects:@"人脸检测-照片",@"关于", nil];
    titleDetailArray = [[NSArray alloc] initWithObjects:@"从照片中检测出人脸位置，并用矩形框标记",@"从视频中检测出人脸位置，并用矩形框标记", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"face_detection_icon",@"face_detection_icon", nil];
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

    cell.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:223.0/255.0 blue:182.0/255.0q alpha:1.0];
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
    AboutViewController *picture = [[AboutViewController alloc] init];
    picture.title = [titleArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:picture animated:YES];
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
