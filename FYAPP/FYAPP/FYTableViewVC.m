//
//  FYTableViewVC.m
//  FYAPP
//
//  Created by FengYu on 2017/9/25.
//  Copyright © 2017年 FengYu. All rights reserved.
//

#import "FYTableViewVC.h"

@interface FYTableViewVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FYTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在 self.view viewWillAppear 的时候, 不把原来选中的行取消选中
    // 因为视图将要显示的时候会把原来选中的行取消选中
    // 设置下面的属性为 NO 后，就不会取消了
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // 往导航栏右边添加多个 item
//    self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem, self.editButtonItem];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


@end
