//
//  ZPMTraitView.m
//  TraitDemon
//
//  Created by 吴桐 on 2018/8/20.
//  Copyright © 2018年 cowlevel. All rights reserved.
//

#import "ZPMTraitView.h"
#import "UIColor+Extension.h"
#define buttonWidth 60
#define buttonHeight 28
#define leftMargin 12
#define topMargin 12
#define BlockCallWithOneArg(block,arg)  if(block){block(arg);}
@interface ZPMTraitView ()
@property(strong,nonatomic)NSMutableArray *oneArray;
@property(strong,nonatomic)UIScrollView *scrollView;
@property(assign,nonatomic)long clickNum;
@end
@implementation ZPMTraitView


- (void)setUI{
    [self addSubview:self.scrollView];
    self.oneArray = [[NSMutableArray alloc]initWithArray:self.fatherArray];
    [self createPailie:self.oneArray];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        _scrollView.scrollEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

#pragma mark - 创建菜单
//创建一级菜单
- (void)createPailie:(NSArray *)array{
    int firstLeftX = 0;
    int firstTopY = 0;
    
    int lastLeftX  = 0;
    int lastPointTopY  = 0;
    for (int i =0; i<array.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor yellowColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        NSInteger tagInteger = (i+1)*100;
        button.tag = tagInteger;
        NSString *btnTitle = array[i];
        NSString *btnTitle_sel = [btnTitle stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
        [button setTitle:btnTitle forState:UIControlStateNormal];
        [button setTitle:btnTitle_sel forState:UIControlStateSelected];
        CGSize btnSize = [self boundingRectWithText:btnTitle font:[UIFont systemFontOfSize:14] size:CGSizeMake(100, 28)];
        btnSize.width += 20;
        if (i != 0) {
            firstLeftX  = lastLeftX;
            firstTopY  = lastPointTopY;
        }else{
            firstTopY = 50;
            firstLeftX = 0;
        }
        
        if (firstLeftX + btnSize.width + leftMargin <= self.bounds.size.width) {
            firstLeftX = firstLeftX + leftMargin;
        }
        else{
            firstTopY = firstTopY + buttonHeight + topMargin;
            firstLeftX = leftMargin;
        }
        button.frame = CGRectMake(firstLeftX, firstTopY, btnSize.width, buttonHeight);
        button.layer.cornerRadius = 15.0;
        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(logWord:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        lastLeftX = CGRectGetMaxX(button.frame);
        lastPointTopY  = CGRectGetMinY(button.frame);
    }
}

//插入二级菜单
- (void)insertWord:(NSArray *)array
         andPostionX:(long)x{
    
    int pointLeftX = 0;
    int pointTopY = 0;
    
    int lastPointLeftX  = 0;
    int lastPointTopY  = 0;
    NSString *tagString = [NSString stringWithFormat:@"%lu00",x];
    NSInteger tagInteger = [tagString integerValue];
    UIButton *pointBtn = [self viewWithTag:self.clickNum * 100];
    for (int i =0; i<array.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor yellowColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = tagInteger + i +1;
        [button setTitle:array[i] forState:UIControlStateNormal];
        CGSize sonBtnSize = [self boundingRectWithText:array[i] font:[UIFont systemFontOfSize:14] size:CGSizeMake(100, 28)];
        sonBtnSize.width +=20;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15.0;
        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.frame = pointBtn.frame;
        [button addTarget:self action:@selector(sonLogWord:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            pointLeftX  = CGRectGetMaxX(pointBtn.frame);
            pointTopY  = CGRectGetMinY(pointBtn.frame);
        }
        else{
            pointLeftX  = lastPointLeftX;
            pointTopY  = lastPointTopY;
        }
        
        if (pointLeftX + sonBtnSize.width + leftMargin <= self.bounds.size.width) {
            pointLeftX = pointLeftX + leftMargin;
        }
        else{
            pointTopY = pointTopY + buttonHeight + topMargin;
            pointLeftX = leftMargin;
        }
        [UIView animateWithDuration:0.4 animations:^{
            [self.scrollView addSubview:button];
            button.frame = CGRectMake(pointLeftX, pointTopY, sonBtnSize.width, buttonHeight);
        }];
        
        
        lastPointLeftX = CGRectGetMaxX(button.frame);
        lastPointTopY  = CGRectGetMinY(button.frame);
    }
    [self changeOriginBtnPosition:array andPostionX:x];
    if (lastPointTopY >= self.bounds.size.height -20) {
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width,lastPointTopY * 2);
        NSNumber *heightNum = [[NSNumber alloc]initWithFloat:lastPointTopY + 50];
        BlockCallWithOneArg(self.selectTraitWord, heightNum);
    }
}

//插入二级菜单之后，改变原来一级&二级菜单位置
- (void)changeOriginBtnPosition:(NSArray *)array
                    andPostionX:(long)x{
    NSString *tagString = [NSString stringWithFormat:@"%lu00",x];
    NSInteger tagInteger = [tagString integerValue];
    UIButton *insertBtn = [self viewWithTag:tagInteger + array.count];
    int leftX = 0;
    int topY = 0;
    
    int lastLeftX  = 0;
    int lastTopY  = 0;
    
    
    
    for (int i =0; i<self.fatherArray.count - self.clickNum; i ++) {
        NSInteger goalTag = 1;
        if (self.clickNum +i < self.sonArray.count) {
            goalTag = ((NSArray *)(self.sonArray[self.clickNum +i])).count;
        }
        
        for (int j = 0; j < goalTag+1; j++) {
            UIButton *originBtn = [self viewWithTag:self.clickNum * 100+((i+1)*100 + j)];
            if (!originBtn) {
                continue;
            }
            if (i == 0 && j ==0) {
                leftX  = CGRectGetMaxX(insertBtn.frame);
                topY  = CGRectGetMinY(insertBtn.frame);
            }
            else{
                leftX  = lastLeftX;
                topY  = lastTopY;
            }
            if (leftX + originBtn.bounds.size.width + leftMargin <= self.bounds.size.width) {
                leftX = leftX + leftMargin;
            }
            else{
                topY = topY + buttonHeight + topMargin;
                leftX = leftMargin;
            }
            [UIView animateWithDuration:0.4 animations:^{
                originBtn.frame = CGRectMake(leftX, topY, originBtn.bounds.size.width, buttonHeight);
            }];
            
            
            lastLeftX = CGRectGetMaxX(originBtn.frame);
            lastTopY  = CGRectGetMinY(originBtn.frame);
        }
    }
    
    if (lastTopY >= self.bounds.size.height - 20) {
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width,lastTopY*2);
        NSNumber *heightNum = [[NSNumber alloc]initWithFloat:lastTopY + 50];
        BlockCallWithOneArg(self.selectTraitWord, heightNum);
    }
    
}

- (void)logWord:(UIButton *)button{
    button.userInteractionEnabled = NO;
    button.selected = YES;
    if (button.tag == 100) {
        button.backgroundColor = [UIColor colorBLue];
    }
    else if(button.tag == 200) {
        button.backgroundColor = [UIColor colorWithHexString:@"#49A4FE"];
        button.layer.borderColor = [UIColor colorWithHexString:@"#49A4FE"].CGColor;
    }
    else if(button.tag == 300) {
        button.backgroundColor = [UIColor colorWithHexString:@"#6288FE"];
        button.layer.borderColor = [UIColor colorWithHexString:@"#6288FE"].CGColor;
    }
    else if(button.tag == 400) {
        button.backgroundColor = [UIColor colorWithHexString:@"#7A6AFE"];
        button.layer.borderColor = [UIColor colorWithHexString:@"#7A6AFE"].CGColor;
    }
    else{
        button.backgroundColor = [UIColor colorWithHexString:@"#855CFE"];
        button.layer.borderColor = [UIColor colorWithHexString:@"#855CFE"].CGColor;
    }
    long btnTag = button.tag;
    self.clickNum = btnTag/100;
    [self insertWord:self.sonArray[self.clickNum - 1] andPostionX:self.clickNum];
    NSLog(@"%@",button.titleLabel.text);
}

- (void)sonLogWord:(UIButton *)button{
    button.selected = !button.selected;
    NSString *word =[button.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",button.titleLabel.text);
    if (button.selected) {
        if (button.tag > 100 && button.tag < 200) {
            button.backgroundColor = [UIColor colorBLue];
        }
        else if(button.tag > 200 && button.tag < 300) {
            button.backgroundColor = [UIColor colorWithHexString:@"#49A4FE"];
            button.layer.borderColor = [UIColor colorWithHexString:@"#49A4FE"].CGColor;
        }
        else if(button.tag > 300 && button.tag < 400) {
            button.backgroundColor = [UIColor colorWithHexString:@"#6288FE"];
            button.layer.borderColor = [UIColor colorWithHexString:@"#6288FE"].CGColor;
        }
        else if(button.tag > 400 && button.tag < 500) {
            button.backgroundColor = [UIColor colorWithHexString:@"#7A6AFE"];
            button.layer.borderColor = [UIColor colorWithHexString:@"#7A6AFE"].CGColor;
        }
        else{
            button.backgroundColor = [UIColor colorWithHexString:@"#855CFE"];
            button.layer.borderColor = [UIColor colorWithHexString:@"#855CFE"].CGColor;
        }
        
        BlockCallWithOneArg(self.chooseTraitWord, word);
    }else{
        button.backgroundColor = [UIColor yellowColor];
        BlockCallWithOneArg(self.removeTraitWord, word);
    }
}

- (CGSize)boundingRectWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

@end
