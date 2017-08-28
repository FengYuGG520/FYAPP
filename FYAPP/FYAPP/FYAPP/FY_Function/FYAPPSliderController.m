#import "FYAPPSliderController.h"
#import "UIViewController+FYViewController.h"

// 设置左侧控制器的右边距离屏幕右边的最小距离
#define DistanceScreen 72

@interface FYAPPSliderController ()

@property (strong, nonatomic) UIViewController *leftVC;
@property (strong, nonatomic) UIViewController *rightVC;
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation FYAPPSliderController

#define ViewWidth self.view.bounds.size.width

+ (instancetype)fy_LeftVC:(UIViewController *)leftVC rightVC:(UIViewController *)rightVC {
    return [[self alloc] initWithLeftVC:leftVC rightVC:rightVC];
}

- (instancetype)initWithLeftVC:(UIViewController *)leftVC rightVC:(UIViewController *)rightVC {
    if (self = [super init]) {
        _leftVC = leftVC;
        _rightVC = rightVC;
        // 设置两个控制器为子控制器
        [self fy_addController:leftVC viewTo:self.view];
        [self fy_addController:rightVC viewTo:self.view];
        //创建拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_rightVC.view addGestureRecognizer:pan];
    }
    return self;
}

// 点按手势
- (void)tap:(UITapGestureRecognizer *)tap {
    [self closeLeftVC];
}

// 关闭左侧控制器
- (void)closeLeftVC {
    //复原
    [UIView animateWithDuration:0.3 animations:^{
        _rightVC.view.transform = CGAffineTransformIdentity;
    }];
    //再删除刚刚创建的点按手势
    [_rightVC.view removeGestureRecognizer:_tap];
}

// 拖拽手势
- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获得拖拽速度
    CGPoint velocity = [pan velocityInView:_rightVC.view];
    //获取偏移量
    CGPoint offset = [pan translationInView:self.view];
    //清零
    [pan setTranslation:CGPointZero inView:self.view];
    //不能让你一启动就可以往左边滚(否则会穿帮)
    if(offset.x + _rightVC.view.frame.origin.x < 0) return;
    //不能拖的超过 DistanceScreen 的位置
    if(offset.x + _rightVC.view.frame.origin.x >= ViewWidth - DistanceScreen) return;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            // 根据手指移动速度确定
            if (velocity.x > 250) {
                [_rightVC.view removeGestureRecognizer:_tap];
                [self fy_moveViewTime:0.4];
                [self fy_addTap];
                break;
            }
            if (velocity.x < -200) {
                [self closeLeftVC];
                break;
            }
        case UIGestureRecognizerStateChanged:
            //如果是开始或者正在拖拽,就拖多少走多少
            _rightVC.view.transform = CGAffineTransformTranslate(_rightVC.view.transform, offset.x, 0);
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            //如果是结束就要判断有没有超过一半
            if(_rightVC.view.frame.origin.x >= ViewWidth * 0.4){
                //移到 DistanceScreen 位置
                [self fy_moveViewTime:0.3];
                //先把上一次的手势删掉
                [_rightVC.view removeGestureRecognizer:_tap];
                //创建点按手势
                [self fy_addTap];
            }else [self closeLeftVC];
        default:
            break;
    }
}

// 让右视图移动到 DistanceScreen 的位置
- (void)fy_moveViewTime:(CGFloat)time {
    [UIView animateWithDuration:time animations:^{
        _rightVC.view.transform = CGAffineTransformMakeTranslation(ViewWidth - DistanceScreen, 0);
    }];
}

// 创建点按手势
- (void)fy_addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //给右侧控制器添加点按手势
    [_rightVC.view addGestureRecognizer:tap];
    _tap = tap;
}

@end
