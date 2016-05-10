//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "ClientNetWorkManager.h"
#import "OAuth2Manager.h"
#import "UserRequest.h"
@interface ViewController (){
    UIActivityIndicatorView * _indicatorView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)authorization:(id)sender {
     [OAuth2Manager openSafariAndAuthorization];
}


- (IBAction)getUserInformation:(id)sender{
    UserRequest * userRequest = [UserRequest new];
    [userRequest startRequestWithFinshBlock:^(id result, NSError *error) {
        if (!error) {
            
        NSDictionary * dic = (NSDictionary *)result;
        NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString * alertString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        }

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
