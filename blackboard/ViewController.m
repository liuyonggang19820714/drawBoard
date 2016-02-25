//
//  ViewController.m
//  blackboard
//
//  Created by 极客学院 on 16/2/25.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

#define screenHeight [UIScreen mainScreen].bounds.size.height

#define iMargin 20

@interface ViewController ()
@property(nonatomic,strong)drawView*drawBoardView;


@end

@implementation ViewController

-(drawView *)drawBoardView
{
    if (!_drawBoardView) {
        _drawBoardView = [[drawView alloc]initWithFrame:CGRectMake(iMargin, 50, screenWidth - iMargin*2, screenHeight - 50 - iMargin)];
        _drawBoardView.backgroundColor = [UIColor colorWithRed:0.127 green:0.243 blue:0.239 alpha:1];
        
    }
    
    return _drawBoardView;
}

- (IBAction)clearAll:(id)sender {
    [self.drawBoardView clear];
}

- (IBAction)unDo:(id)sender {
    [self.drawBoardView UnDo];
}


- (IBAction)save:(id)sender {
    UIGraphicsBeginImageContext(self.drawBoardView.frame.size);
    
    [self.drawBoardView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*imageNew =  UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageWriteToSavedPhotosAlbum(imageNew, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    

}

- (void) image: (UIImage *) image
didFinishSavingWithError: (NSError *) error
   contextInfo: (void *) contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }
    else
    {
        NSLog(@"保存成功");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.drawBoardView];
    
    
}


@end
