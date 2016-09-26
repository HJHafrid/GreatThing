//
//  MeViewController.m
//  01啪啪
//
//  Created by mac57 on 16/9/12.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "MeViewController.h"
#import "ModelViewController.h"
@interface MeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{

}
@end

@implementation MeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;

    
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 40;
    _imageView.userInteractionEnabled = YES;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    _imageView.tag = 1;
    
    [self _createHeaderView];
}
- (void)_createHeaderView
{
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickPhoto)]];
}
- (void)pickPhoto
{
    if (_imageView.tag == 1) {
        _imageView.tag++;
        NSLog(@"%li", _imageView.tag);
        ModelViewController *vc = [[ModelViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (_imageView.tag > 1)
    {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}
- (IBAction)FeedBack:(id)sender {
    NSLog(@"1");
}
- (IBAction)Set:(id)sender {
    NSLog(@"2");
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    NSLog(@"1111");
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
