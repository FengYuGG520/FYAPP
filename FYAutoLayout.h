/*
    使用注意:
        一定要在子控件添加到父控件之后, 才能进行布局
 
    三个核心函数:
        fy_makeConstraints     (构建约束)
        fy_updateConstraints   (修改已经建立的约束, 如果约束不存在, 会在控制台输出错误, 影响性能)
        fy_remakeConstraints   (删除已经建立的所有约束, 然后重新生成约束)
 
    等于函数:
        equalTo(对象)
        equalTo(对象.fy_对象属性)
        fy_equalTo(结构体)
 
    偏移函数:
        offset(CGFloat)
        fy_offset(结构体)
        make.width.equalTo(view).multipliedBy(0.5);
 
    make.edges.equalTo(view).fy_offset(UIEdgeInsetsMake(20, 20, 20, 20));
    (一行代码布局)
    make.top.equalTo(self.fy_topLayoutGuide);
    (辅助布局)
    self.view layoutIfNeeded
    (立即生成布局)
 */

#import "FYUtilities.h"
#import "View+FYAdditions.h"
#import "View+FYShorthandAdditions.h"
#import "ViewController+FYAdditions.h"
#import "NSArray+FYAdditions.h"
#import "NSArray+FYShorthandAdditions.h"
#import "FYConstraint.h"
#import "FYCompositeConstraint.h"
#import "FYViewAttribute.h"
#import "FYViewConstraint.h"
#import "FYConstraintMaker.h"
#import "FYLayoutConstraint.h"
#import "NSLayoutConstraint+FYDebugAdditions.h"
