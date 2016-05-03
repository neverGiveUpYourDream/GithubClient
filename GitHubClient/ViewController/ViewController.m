//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "ClientNetWorkManager.h"
@interface ViewController (){
    UIActivityIndicatorView * _indicatorView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUIContentView];
}


- (void)initUIContentView{
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _indicatorView.center = self.view.center;
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _indicatorView.backgroundColor = [UIColor lightGrayColor];
    _indicatorView.hidesWhenStopped = YES;
    [self.view addSubview:_indicatorView];

}

- (IBAction)authorization:(id)sender {
    [_indicatorView startAnimating];
    [[ClientNetWorkManager shareManager] authorizationRequestSuccess:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [_indicatorView stopAnimating];
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString * alertString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        NSLog(@"%@",error);
        [_indicatorView stopAnimating];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
