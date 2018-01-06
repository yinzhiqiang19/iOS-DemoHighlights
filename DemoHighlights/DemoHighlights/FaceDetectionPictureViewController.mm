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

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

using namespace cv;

@interface FaceDetectionPictureViewController ()
{
    cv::Mat cvImage;
}
@property (nonatomic, weak) IBOutlet UIImageView* imageView;

@end

@implementation FaceDetectionPictureViewController
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addRightBtn];
    
    UIImage* image = [UIImage imageNamed:@"lesa"];
    
    // Convert UIImage* to cv::Mat
    UIImageToMat(image, cvImage);
    
//    if (0)
//    {
//        
//        NSString* filePath = [[NSBundle mainBundle]
//                              pathForResource:@"lena" ofType:@"png"];
//        // Create file handle
//        NSFileHandle* handle =
//        [NSFileHandle fileHandleForReadingAtPath:filePath];
//        // Read content of the file
//        NSData* data = [handle readDataToEndOfFile];
//        // Decode image from the data buffer
//        cvImage = cv::imdecode(cv::Mat(1, [data length], CV_8UC1,
//                                       (void*)data.bytes),
//                               CV_LOAD_IMAGE_UNCHANGED);
//    }
//    
//    if (0)
//    {
//        NSData* data = UIImagePNGRepresentation(image);
//        // Decode image from the data buffer
//        cvImage = cv::imdecode(cv::Mat(1, [data length], CV_8UC1,
//                                       (void*)data.bytes),
//                               CV_LOAD_IMAGE_UNCHANGED);
//    }
    
    if (!cvImage.empty())
    {
        cv::Mat gray;
        // Convert the image to grayscale
        cv::cvtColor(cvImage, gray, CV_RGBA2GRAY);
        // Apply Gaussian filter to remove small edges
        cv::GaussianBlur(gray, gray,
                         cv::Size(5, 5), 1.2, 1.2);
        // Calculate edges with Canny
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        // Fill image with white color
        cvImage.setTo(cv::Scalar::all(255));
        // Change color on edges
        cvImage.setTo(cv::Scalar(0, 128, 255, 255), edges);
        // Convert cv::Mat to UIImage* and show the resulting image
        imageView.image = MatToUIImage(cvImage);
    }
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
