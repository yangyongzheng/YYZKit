//
//  ViewController.m
//  YYZMainProj
//
//  Created by yangyongzheng on 2019/12/18.
//  Copyright © 2019 yangyongzheng. All rights reserved.
//

#import "ViewController.h"
#import "SupplyZiZhiExampleViewController.h"
#import "SupplyZiZhiImageBrowserViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.userInteractionEnabled = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
//    SZiZhiExampleParam *param = [[SZiZhiExampleParam alloc] init];
//    param.image = [UIImage imageNamed:@"3"];
//    param.imageURLString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596958557326&di=aacae9b4876249658b488abadbf8a22a&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F21%2F14425%2Fdabb9c5fc143dd81_1366x768.jpg";
//    param.actionTitle = @"添加农药网销许可证";
//    param.resultHandler = ^(UIImage * _Nonnull image) {
//        NSLog(@"%@", image);
//    };
//    SupplyZiZhiExampleViewController *vc = [SupplyZiZhiExampleViewController viewControllerWithParam:param];
//    [self.navigationController pushViewController:vc animated:YES];
    
    SZiZhiImageBrowserParam *param = [[SZiZhiImageBrowserParam alloc] init];
    param.pageTitle = @"农药网销许可证";
    param.image = [UIImage imageNamed:@"3"];
    param.imageURLString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596962789410&di=37f9738593183cfcc29d6c37d11e3f7d&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F15%2F20180715000211_tumia.jpg";
    param.deleteHandler = ^{

    };
    param.changeImageHandler = ^(UIImage * _Nonnull image) {
        NSLog(@"%@", image);
    };
    SupplyZiZhiImageBrowserViewController *vc = [SupplyZiZhiImageBrowserViewController viewControllerWithParam:param];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
