//
//  ListDetailMidMenu.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ResultMidMenu.h"

@implementation ResultMidMenu{
    NSArray *_titleArray;
    NSMutableArray *_btnArray;
    
    UIView *_contentView;
    
    UIImageView *_arrowTip;
}



- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:CGRectMake(0, 64, 320, 52)];
    if (self) {
        self.clipsToBounds = NO;
        _titleArray = [NSArray arrayWithArray:titleArray];
        _btnArray = [[NSMutableArray alloc]init];
        self.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1);

        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 290, 40)];
        [whiteView addSubview:_contentView];
        _contentView.clipsToBounds = NO;
        
        _arrowTip = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 9, 4)];
        _arrowTip.image = [UIImage imageNamed:@"arrow_up_white.png"];
        
        [self configBtn];
        [self addSubview:_arrowTip];
    }
    return self;
}

-(void)configBtn{
    [_btnArray removeAllObjects];
    CGFloat btnGap = 2.0;
    CGFloat btnWidth = (_contentView.frame.size.width-(_titleArray.count-1)*btnGap)/_titleArray.count;
    CGFloat btnHeight = _contentView.frame.size.height;
    CGFloat cumulation = 0;
    
    int tag = 0;
    
    for (NSString *title in _titleArray) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_gray_block"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateSelected];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setFrame:CGRectMake(cumulation, 0, btnWidth, btnHeight)];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = tag++;
        cumulation += btnWidth+btnGap;
        [_contentView addSubview:btn];
        [_btnArray addObject:btn];
        if (btn.tag == 0) {
            _arrowTip.frame = CGRectMake(_contentView.frame.origin.x + btn.frame.origin.x+btn.frame.size.width/2-_arrowTip.frame.size.width/2, _contentView.frame.origin.y +_contentView.frame.size.height-_arrowTip.frame.size.height+2, _arrowTip.frame.size.width, _arrowTip.frame.size.height);
        }
    }
    
    
}
-(void)clickBtn:(UIButton *)btn{
//    [_btnArray makeObjectsPerformSelector:@selector(setSelected:) withObject:[NSNumber numberWithBool:NO]];
    for (UIButton *button in _btnArray) {
        [button setSelected:NO];
    }
    [btn setSelected:YES];
    if (_callback) {
        _callback(btn.tag);
    }
    _arrowTip.frame = CGRectMake(_contentView.frame.origin.x + btn.frame.origin.x+btn.frame.size.width/2-_arrowTip.frame.size.width/2, _contentView.frame.origin.y +_contentView.frame.size.height-_arrowTip.frame.size.height+2, _arrowTip.frame.size.width, _arrowTip.frame.size.height);
}

-(void)setSelected:(NSInteger)index{
    if (index>_btnArray.count-1) {
        return;
    }
    [self clickBtn:[_btnArray objectAtIndex:index]];
}

-(void)updateWithTabArray:(NSArray *)tabArray{
    if (!tabArray) {
        return;
    }
    
    if (![tabArray isEqual:_titleArray]) {
        _titleArray = tabArray;
        [self configBtn];
    }
}

@end
