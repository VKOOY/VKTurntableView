//
//  UIImage+CGImageRef.m
//  VKOOY
//
//  Created by vkooy on 2018/5/21.
//  Copyright © 2017年. All rights reserved.
//

#import "UIImage+CGImageRef.h"

//thx to Benedict Cohen @stackoverflow "http://stackoverflow.com/questions/6708200/ios-improving-speed-of-image-drawing"
@implementation UIImage (CGImageRef)

- (CGImageRef)newCGImageRenderedInBitmapContext
{
    //bitmap context properties
    CGSize size = self.size;
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * size.width;
    NSUInteger bitsPerComponent = 8;
    
    //create bitmap context
    unsigned char *rawData = malloc(size.height * size.width * 4);
    memset(rawData, 0, size.height * size.width * 4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rawData, size.width, size.height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //draw image into bitmap context
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
    CGImageRef renderedImage = CGBitmapContextCreateImage(context);
    
    //tidy up
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(rawData);
    
    //done!
    //Note that we're not returning an autoreleased ref and that the method name reflects this by using 'new' as a prefix
    return renderedImage;
}

@end
