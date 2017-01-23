//
//  GenerateViewController.m
//  ScanCode
//
//  Created by Oma-002 on 16/8/16.
//  Copyright © 2016年 com.tjl.org. All rights reserved.
//

#import "GenerateViewController.h"

@interface GenerateViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation GenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码生成";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.imageView];
    [self generateQRCode];
}

- (void)generateQRCode {
    //二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    
    if ([self.string isEqualToString:@""] || !self.string) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符串不能为空" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        //将字符串转换成NSData
        NSData *data = [self.string dataUsingEncoding:NSUTF8StringEncoding];
        //通过KVO设置滤镜inputmessage数据
        [filter setValue:data forKey:@"inputMessage"];
        
        CIImage *outputImage = [filter outputImage];
        //将CIImage转换成UIImage,并放大显示
        self.imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100];
    }
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.width/2.0)];
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
