//
//  ScanViewController.h
//  ScanCode
//
//  Created by Oma-002 on 16/7/7.
//  Copyright © 2016年 com.tjl.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController

typedef void(^ScanQRCodeResult)(NSString *serialNumber);

/**
 *  通过闭包返回获取到的字符串
 *
 *  @param complete 含有扫描结果字符串的闭包
 *
 *  @return 返回一个当前对象
 */
- (instancetype)initWithComplete:(ScanQRCodeResult) complete;

@end
