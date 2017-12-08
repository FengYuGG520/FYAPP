#import "ViewController.h"

#import "BlockDoc.h"

#import "UserModel.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()


@end

@implementation ViewController {
    BOOL LightOn;
    AVCaptureDevice *device;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btn setFrame:CGRectMake(100, 150, 100, 80)];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [self initUIIIUI];
    
    
}

- (void)initUIIIUI{
    
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (![device hasTorch]) {
        
        //无手电筒
        
    }
    
    LightOn = NO;
    
}

-(void)btnClicked

{
    
    LightOn = !LightOn;
    
    if (LightOn) {
        
        [self turnOn];
        
    }else{
        
        [self turnOff];
        
    }
    
}



-(void) turnOn

{
    
    [device lockForConfiguration:nil];
    
    [device setTorchMode:AVCaptureTorchModeOn];
    
    [device unlockForConfiguration];
    
}

-(void) turnOff

{
    
    [device lockForConfiguration:nil];
    
    [device setTorchMode: AVCaptureTorchModeOff];
    
    [device unlockForConfiguration];
    
}



@end
