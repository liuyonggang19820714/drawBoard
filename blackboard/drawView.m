//
//  drawView.m
//  blackboard
//
//  Created by 极客学院 on 16/2/25.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "drawView.h"

@interface drawView()

// 纪录所有点
@property(nonatomic,strong)NSMutableArray*allPointAray;

// 记录当前按下去移动时的所有点
@property(nonatomic,strong)NSMutableArray*subPointAray;

@end

@implementation drawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 清除所有
-(void)clear
{
    
    [self.allPointAray  removeAllObjects];
    [self setNeedsDisplay];
}

// 撤销上一步
-(void)UnDo
{
    
    [self.allPointAray  removeLastObject];
    [self setNeedsDisplay];
}

-(NSMutableArray *)allPointAray
{
    if (!_allPointAray) {
        _allPointAray = [[NSMutableArray alloc] init];
    }
    
    return _allPointAray;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch*touch1 = [touches anyObject];
    
    CGPoint point1 = [touch1 locationInView:touch1.view];
    
    self.subPointAray = [NSMutableArray array];
    
    [self.subPointAray addObject:[NSValue valueWithCGPoint:point1]];
    
    [self.allPointAray addObject:self.subPointAray];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch*touch1 = [touches anyObject];
    
    CGPoint point1 = [touch1 locationInView:touch1.view];
    
    [self.subPointAray addObject:[NSValue valueWithCGPoint:point1]];
    
    [self setNeedsDisplay];
    
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self setNeedsDisplay];
    
    UITouch*touch1 = [touches anyObject];
    
    CGPoint point1 = [touch1 locationInView:touch1.view];
    
    [self.subPointAray addObject:[NSValue valueWithCGPoint:point1]];
    
    
    [self setNeedsDisplay];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (NSMutableArray*sub in self.allPointAray) {
        for(int i = 0; i< sub.count; i++)
        {
            CGPoint pt= [sub[i] CGPointValue];
            
            if (i == 0) {
                CGContextMoveToPoint(ctx, pt.x, pt.y);
            }
            else
            {
                CGContextAddLineToPoint(ctx, pt.x, pt.y);
            }
            
        }
    }
    
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextStrokePath(ctx);
    
}



@end
