//
//  FaceDetectionPictureViewController.m
//  DemoHighlights
//
//  Created by yinzhiqiang on 2018/1/1.
//  Copyright © 2018年 yinzhiqiang. All rights reserved.
//

#import "FaceDetectionPictureViewController.h"
#import "opencv2/highgui/ios.h"
#import <opencv2/highgui/cap_ios.h>
#import "PublicFunction.h"

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

using namespace cv;

@interface FaceDetectionPictureViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>
{
    cv::Mat cvImage;
    cv::CascadeClassifier faceDetector;
    UIImage *myFaceImage;
}
@property (nonatomic, weak) IBOutlet UIImageView* contentImageView;
@property (nonatomic, weak) IBOutlet UILabel* timeLabel;

@end

@implementation FaceDetectionPictureViewController
@synthesize contentImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addRightBtn];
    
    
}

// 从相机获取
- (void)getImageFromCamera
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

// 从系统相册获取
- (void)getImageFromPicture
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *resultImage = [self normalizedImage:image];
    
    // 设置图片
    self.contentImageView.image = resultImage;//info[UIImagePickerControllerOriginalImage];
    myFaceImage = resultImage;//info[UIImagePickerControllerOriginalImage];
    [self detectFace];
}

- (UIImage *)normalizedImage:(UIImage*)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPictureBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)uploadPictureBtnClick {
    NSLog(@"onClickedOKbtn");
    //创建一个UIActionSheet，其中destructiveButton会红色显示，可以用在一些重要的选项
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    
    //actionSheet风格，感觉也没什么差别- -
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;//默认风格，灰色背景，白色文字
    //    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    //    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    //    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//纯黑背景，白色文字
    
    //如果想再添加button
    //    [actionSheet addButtonWithTitle:@"其他方式"];
    
    //更改ActionSheet标题
    //    actionSheet.title = @"选择照片";
    
    //获取按钮总数
    NSString *num = [NSString stringWithFormat:@"%ld", actionSheet.numberOfButtons];
    NSLog(@"%@", num);
    
    //获取某个索引按钮的标题
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:1];
    NSLog(@"%@", btnTitle);
    
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
//根据被点击的按钮做出反应，0对应destructiveButton，之后的button依次排序
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"拍照");
        [self getImageFromCamera];
    }else if (buttonIndex == 1) {
        NSLog(@"相册");
        [self getImageFromPicture];
    }
}

-(void)detectFace
{
    [PublicFunction printTime:1];
    
    // Load cascade classifier from the XML file
    NSString* cascadePath = [[NSBundle mainBundle]
                             pathForResource:@"haarcascade_frontalface_alt"
                             ofType:@"xml"];
    faceDetector.load([cascadePath UTF8String]);
    
    // Load image with face
//    UIImage* image = [UIImage imageNamed:@"lena1.png"];
    cv::Mat faceImage;
    UIImageToMat(myFaceImage, faceImage);
    
    // Convert to grayscale
    cv::Mat gray;
    cvtColor(faceImage, gray, CV_BGR2GRAY);
    
    // Detect faces
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(gray, faces, 1.1,
                                  2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    // Draw all detected faces
    for(unsigned int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        // Get top-left and bottom-right corner points
        cv::Point tl(face.x, face.y);
        cv::Point br = tl + cv::Point(face.width, face.height);
        
        // Draw rectangle around the face
        cv::Scalar magenta = cv::Scalar(255, 0, 255);
        cv::rectangle(faceImage, tl, br, magenta, 4, 8, 0);
    }
    
    // Show resulting image
    contentImageView.image = MatToUIImage(faceImage);
    
    NSString *startEndTime = [PublicFunction printTime:2];
    _timeLabel.text = startEndTime;
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
