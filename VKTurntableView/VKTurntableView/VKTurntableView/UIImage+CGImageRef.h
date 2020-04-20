//
//  UIImage+CGImageRef.h
//  VKOOY
//
//  Created by vkooy on 2018/5/21.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CGImageRef)

- (CGImageRef)newCGImageRenderedInBitmapContext;

@end
