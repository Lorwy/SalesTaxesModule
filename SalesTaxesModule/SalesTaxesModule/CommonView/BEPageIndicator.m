//
//  BEPageIndicator.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/1.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BEPageIndicator.h"

@interface BEPageIndicator()

@property (nonatomic) CGRect indicatorsBounds;
@property (nonatomic) CGPoint startPoint;

@end

@implementation BEPageIndicator

- (void)drawRect:(CGRect)rect {
    
    if (![self willDraw]) {
        [super drawRect:rect];
        return;
    }
    
    //draw transparent background
    if (self.indicatorStyle == BEPageIndicatorStyleCircle) {
        [self drawOvalIndicators];
    }else{
        [self drawRectangleIndicators];
    }
}

-(void)drawRectangleIndicators
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int page = 0 ; page < self.pageCount; ++page) {
        CGFloat posx = [self startXHint:page];
        CGFloat posy = [self startYHint:page];
        if (_currentPage == page) {
            [self.indicatorHighlight setFill];
        }else{
            [self.indicatorColor setFill];
        }
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context,posx,posy);
        UIBezierPath *oval = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, _indicatorWidth, _indicatorHeight)];
        oval.usesEvenOddFillRule = YES;
        [oval fill];
        CGContextRestoreGState(context);
    }
}

-(void)drawOvalIndicators
{
    CGFloat indicatorSize = self.indicatorRadius*2.0f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int page = 0 ; page < self.pageCount; ++page) {
        
        CGFloat posx = [self startXHint:page];
        CGFloat posy = [self startYHint:page];
        if (_currentPage == page) {
            [self.indicatorHighlight setFill];
        }else{
            [self.indicatorColor setFill];
        }
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context,posx,posy);
        UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, indicatorSize, indicatorSize)];
        oval.usesEvenOddFillRule = YES;
        [oval fill];
        
        CGContextRestoreGState(context);
    }
}

-(CGFloat)startXHint:(int)page
{
    if (page == 0) {
        return self.startPoint.x;
    }else{
        if (_indicatorStyle == BEPageIndicatorStyleCircle) {
            return self.startPoint.x + page*_indicatorRadius*2 + page*_indicatorSpace;
        }else{
            return self.startPoint.x + page*_indicatorWidth + page*_indicatorSpace;
        }
        
    }
}

-(CGFloat)startYHint:(int)page
{
    return _startPoint.y;
}

-(void)updateStartPoint
{
    CGPoint point;
    point.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.indicatorsBounds))/2;
    switch (_indicatorAlign) {
        case BEPageIndicatorAlignLeft:
            point.x = 0.0f;
            break;
        case BEPageIndicatorAlignCenter:
            point.x = (CGRectGetWidth(self.bounds)-CGRectGetWidth(self.indicatorsBounds))/2;
            break;
        case BEPageIndicatorAlignRight:
            point.x = (CGRectGetWidth(self.bounds)-CGRectGetWidth(self.indicatorsBounds));
            break;
    }
    self.startPoint = point;
}

-(BOOL)willDraw
{
    if (CGRectIsEmpty(_indicatorsBounds)) {
        return NO;
    }
    return YES;
}

-(void)updateIndicatorBounds
{
    self.indicatorsBounds = CGRectZero;
    if (_pageCount == 0 ) {
        return;
    }
    switch (_indicatorStyle) {
        case BEPageIndicatorStyleCircle:
        {
            CGFloat itemSize = _indicatorRadius*2.0f;
            _indicatorsBounds.size.height = itemSize;
            _indicatorsBounds.size.width = (_pageCount-1)*_indicatorSpace + _pageCount*itemSize;
            break;
        }
        case BEPageIndicatorStyleRectangle:
        {
            _indicatorsBounds.size.height = _indicatorHeight;
            _indicatorsBounds.size.width =(_pageCount-1)*_indicatorSpace + _pageCount*_indicatorWidth;
            break;
        }
        default:
            break;
    }
    [self updateStartPoint];
}

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withStyle:BEPageIndicatorStyleCircle withAlign:BEPageIndicatorAlignLeft];
}

-(id)initWithFrame:(CGRect)frame
         withStyle:(BEPageIndicatorStyle)style
         withAlign:(BEPageIndicatorAlign)align
{
    self = [super initWithFrame:frame];
    self.indicatorColor = [UIColor lightGrayColor];
    self.indicatorHighlight = [UIColor blueColor];
    self.pageCount = 0;
    self.currentPage = 0;
    self.indicatorSpace = 10;
    self.indicatorWidth = 10;
    self.indicatorHeight = 10;
    self.indicatorRadius = 5;
    self.indicatorStyle = style;
    self.indicatorAlign = align;
    [self updateIndicatorBounds];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)setPageCount:(NSInteger)pageCount
{
    //    if (_pageCount == pageCount || pageCount == 0) {
    //        return;
    //    }
    
    _pageCount = pageCount;
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    [self setNeedsDisplay];
}

-(void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    [self setNeedsDisplay];
}

-(void)setIndicatorHighlight:(UIColor *)indicatorHighlight
{
    _indicatorHighlight = indicatorHighlight;
    [self setNeedsDisplay];
}

-(void)setIndicatorSpace:(CGFloat)indicatorSpace
{
    if (_indicatorSpace == indicatorSpace) {
        return;
    }
    _indicatorSpace = indicatorSpace;
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

-(void)setIndicatorStyle:(BEPageIndicatorStyle)indicatorStyle
{
    _indicatorStyle = indicatorStyle;
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

-(void)setIndicatorAlign:(BEPageIndicatorAlign)indicatorAlign
{
    _indicatorAlign = indicatorAlign;
    [self updateStartPoint];
    [self setNeedsDisplay];
}

-(void)setIndicatorRadius:(CGFloat)indicatorRadius
{
    if (indicatorRadius == 0 || indicatorRadius == _indicatorRadius) {
        return;
    }
    _indicatorRadius = indicatorRadius;
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

-(void)setIndicatorWidth:(CGFloat)indicatorWidth
{
    _indicatorWidth = indicatorWidth;
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

-(void)setIndicatorHeight:(CGFloat)indicatorHeight
{
    _indicatorHeight = indicatorHeight;
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updateIndicatorBounds];
    [self setNeedsDisplay];
}

@end
