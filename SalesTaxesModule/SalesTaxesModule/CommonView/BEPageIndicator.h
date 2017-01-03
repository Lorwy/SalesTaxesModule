//
//  BEPageIndicator.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/1.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BEPageIndicatorStyleRectangle = 0,
    BEPageIndicatorStyleCircle
}BEPageIndicatorStyle;

typedef enum
{
    BEPageIndicatorAlignLeft = 0,
    BEPageIndicatorAlignCenter,
    BEPageIndicatorAlignRight
    
}BEPageIndicatorAlign;

@interface BEPageIndicator : UIView

-(id)initWithFrame:(CGRect)frame withStyle:(BEPageIndicatorStyle)style withAlign:(BEPageIndicatorAlign)align;

//the page count
@property (nonatomic) NSInteger pageCount;
//which page current display
@property (nonatomic) NSInteger currentPage;
//the indicator color normal
@property (nonatomic) UIColor* indicatorColor;
//the indicator color high light
@property (nonatomic) UIColor* indicatorHighlight;
//the space between two indicator
@property (nonatomic) CGFloat indicatorSpace;

//set the width of indicator
//ONLY useful when set style to CHPageIndicatorStyleRectangle
@property (nonatomic) CGFloat indicatorWidth;
//set the height of indicator
//ONLY useful when set style to CHPageIndicatorStyleRectangle
@property (nonatomic) CGFloat indicatorHeight;

//set the radius of indicator
//ONLY useful when set style to CHPageIndicatorStyleCircle
@property (nonatomic) CGFloat indicatorRadius;
//set the style of indicator
@property (nonatomic) BEPageIndicatorStyle indicatorStyle;

//set the align type of indicators
@property (nonatomic) BEPageIndicatorAlign indicatorAlign;

@end
