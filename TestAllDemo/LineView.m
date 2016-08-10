//
//  LineView.m
//  TestAllDemo
//
//  Created by Y杨定甲 on 16/7/12.
//  Copyright © 2016年 damai. All rights reserved.
//

/*
 参考简书
 http://www.jianshu.com/p/734b34e82135
 
 */


#import "LineView.h"

@implementation LineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
/*
 调用drawRect方法的时机：
 1.创建view时，系统会自动调用drawRect完成绘制
 2.drawRect不允许手动调用
 3.如果视图内容需要发生改变，也就是需要重绘视图时，绝对不能
 违反第二原则，只能通过给视图发setNeedsDisplay消息，来通知系统需要重绘
 */
- (void)drawRect:(CGRect)rect{
    [self special];
}
///画圆
- (void)circle{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:0.75f];
    pathAnima.fillMode = kCAFillModeBoth;
    //是否回到开始绘制的点
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    //方法2这个是弧线addArcWithCenter:
//    UIBezierPath *path1 = [UIBezierPath bezierPath];
//    [path1 addArcWithCenter:CGPointMake(120, 120) radius:50 startAngle:M_PI_4 endAngle:2*M_PI clockwise:YES];
//    [[UIColor redColor] setStroke];
//    
//    path1.lineWidth = 5;
//    
//    [path1 stroke];
    
    //Demo3
    //贝塞尔曲线必定通过首尾两个点，称为端点；中间两个点虽然未必要通过，但却起到牵制曲线形状路径的作用，称作控制点。提示：其组成是起始端点+控制点1+控制点2+终止端点
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    // 设置起始端点  终止端点为(40, 140)
    [path2 moveToPoint:CGPointMake(140, 40)];
    [path2 addCurveToPoint:CGPointMake(40, 140) controlPoint1:CGPointMake(40, 40) controlPoint2:CGPointMake(140, 140)];
    [path2 addCurveToPoint:CGPointMake(140, 240) controlPoint1:CGPointMake(140, 140) controlPoint2:CGPointMake(40, 240)];
//    [path2 addQuadCurveToPoint:CGPointMake(40, 160) controlPoint:CGPointMake(40, 40)];

    path2.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [path2 stroke];
    //Demo4  椭圆
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 150, 150)];
//    path.lineWidth = 5;
//    [[UIColor redColor] setStroke];
//    [path stroke];
    
}

///画三角形
- (void)triangle{
    //获取上下文对象  core
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 80, 100);
    CGContextAddLineToPoint(context, 120, 140);
    CGContextAddLineToPoint(context, 40, 140);
    CGContextClosePath(context);
    //设置 画笔 描边 颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    //边线+实心填充
    CGContextDrawPath(context, kCGPathFillStroke);
    
    ///方法2 //创建贝塞尔类的实例
    UIBezierPath * bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(195, 100)];
    //60是角度  70是边的大小  需要1/2的边
    [bezier addLineToPoint:CGPointMake(230, 100+35 * tan(60 / 180.f * M_PI))];
    [bezier addLineToPoint:CGPointMake(160, 100+35 * tan(60 / 180.f * M_PI))];
//    [bezier closePath];
    
    bezier.lineWidth = 10;
    // 设置线头的样式 需要关闭回路看效果
    bezier.lineCapStyle = kCGLineCapSquare;
    // 设置交叉点的样式
    bezier.lineJoinStyle = kCGLineJoinRound;
    [bezier stroke];
    [bezier fill];
}


///矩形  UIBezierPath合集
- (void)rect{
    //正常矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 100, 150, 100)];
    //带圆角的矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 100, 150, 100) cornerRadius:20];
    //这个可以控制其中一个角圆角
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    
    //通过已有路径创建路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:cgpath];
    
    path.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [path stroke];
    
}

- (void)special{
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 50, 160, 160)];
//    //添加剪切，将曲线以外的部分遮盖掉，只留曲线内的绘制内容
//    [path addClip];
//
//    UIImage *image = [UIImage imageNamed:@"head.png"];
//    //点 指的是在当前视图的坐标系下
////    [image drawAtPoint:CGPointMake(100, 50)];
//    [image drawInRect:CGRectMake(100, 50, 160, 160)];

    NSString *str = @"这是一个被唤醒的APP🇨🇳";
    NSDictionary *strAttrbutes = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:20.0],
                                   NSForegroundColorAttributeName:[UIColor redColor]};
    
    [str drawAtPoint:CGPointMake(50, 50) withAttributes:strAttrbutes];
    
    
    NSString *str2 = @"这是一串很长很长很长很长很长的字符串，用与做测试使用希望能够看到完整的显示";
    //根据字符串的内容，结合指定的size区域，算出适合的能够完整装下字符串的矩形区域
    CGRect newFrame = [str2 boundingRectWithSize:CGSizeMake(150, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:strAttrbutes context:nil];
    //[str2 drawAtPoint:CGPointMake(50, 100) withAttributes:strAttrbutes];
    [str2 drawInRect:CGRectMake(50, 100, newFrame.size.width, newFrame.size.height) withAttributes:strAttrbutes];
    
}

@end
