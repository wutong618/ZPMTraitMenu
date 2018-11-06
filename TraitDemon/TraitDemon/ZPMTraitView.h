//
//  ZPMTraitView.h
//  TraitDemon
//
//  Created by 吴桐 on 2018/8/20.
//  Copyright © 2018年 cowlevel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^EventHandler)(id sender);

@interface ZPMTraitView : UIView
@property(strong,nonatomic)NSArray *fatherArray;
@property(strong,nonatomic)NSArray *sonArray;
//选中二级菜单
@property(strong,nonatomic)EventHandler chooseTraitWord;
//取消选择二级菜单
@property(strong,nonatomic)EventHandler removeTraitWord;
@property(strong,nonatomic)EventHandler selectTraitWord;
- (void)setUI;
@end
