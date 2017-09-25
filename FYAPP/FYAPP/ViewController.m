#import "ViewController.h"

#import "BlockDoc.h"

#import "UserModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *parameters = @{};
    
    [FYNetworking.sharedNetworkTool fy_GETURLString:@"https://api.o2ovip.com/index/newProdList/1/1/10" parameters:parameters success:^(id responseObject) {
        
        NSLog(@"responseObject -> %@", responseObject);
        
        UserModel *dic = [NSDictionary fy_modelDictionaryWithClass:UserModel.class json:responseObject];
        UserModel *dic1 = [UserModel fy_modelWithDictionary:responseObject];
        UserModel *dic2 = [UserModel fy_modelWithJSON:responseObject];
        
        NSLog(@"%@", dic.data.list[0].image);
        NSLog(@"%@", dic1.data.list[0].image);
        NSLog(@"%@", dic2.data.list[0].image);
    } faile:^(NSError *error) {
        
        NSLog(@"error -> %@", error);
    }];
}


@end
