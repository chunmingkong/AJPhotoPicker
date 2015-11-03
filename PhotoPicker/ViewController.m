//
//  ViewController.m
//  PhotoPicker
//
//  Created by AlienJunX on 15/11/2.
//  Copyright © 2015年 com.alienjun.demo. All rights reserved.
//

#import "ViewController.h"
#import "BoPhotoPickerViewController.h"

@interface ViewController ()<BoPhotoPickerProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)btnAction:(id)sender {
    
    BoPhotoPickerViewController *picker = [[BoPhotoPickerViewController alloc] init];
//    picker.maximumNumberOfSelection = 10;
//    picker.multipleSelection = YES;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=YES;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return YES;
    }];
    
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - BoPhotoPickerProtocol
-(void)photoPickerDidCancel:(BoPhotoPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)photoPicker:(BoPhotoPickerViewController *)picker didSelectAssets:(NSArray *)asset{
    
    NSLog(@"%s",__func__);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)photoPicker:(BoPhotoPickerViewController *)picker didSelectAsset:(ALAsset *)asset{
    NSLog(@"%s",__func__);
}

-(void)photoPicker:(BoPhotoPickerViewController *)picker didDeselectAsset:(ALAsset *)asset{
    NSLog(@"%s",__func__);
}


//超过最大选择项时
-(void)photoPickerDidMaximum:(BoPhotoPickerViewController *)picker{
    NSLog(@"%s",__func__);
}

//低于最低选择项时
-(void)photoPickerDidMinimum:(BoPhotoPickerViewController *)picker{
    NSLog(@"%s",__func__);
}

-(void)photoPickerTapAction:(BoPhotoPickerViewController *)picker{
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    UIImagePickerController *cameraUI = [UIImagePickerController new];
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraUI.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    
    [self presentViewController: cameraUI animated: YES completion:nil];
    
    
}


#pragma mark - UIImagePickerDelegate
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//保存相册后的回调
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        NSLog(@"保存到相册成功");
    }else{
        NSLog(@"保存到相册出错%@", error);
    }
}

//拍照完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
@end