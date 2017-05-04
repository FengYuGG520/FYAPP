#import "FYAPPWheelViewLayout.h"
#import "FYAPPWheelView.h"

@implementation FYAPPWheelViewLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    
    if (FYWheelFX == 1 || FYWheelFX == 2) {
        
        self.scrollDirection = 0;
    } else {
        
        self.scrollDirection = 1;
    }
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
}

@end
