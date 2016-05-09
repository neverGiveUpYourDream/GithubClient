//
//  OAuth2Manager.m
//  GitHubClient
//
//  Created by ink on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "OAuth2Manager.h"
#import "ClientHttpConfigration.h"
#import <UIKit/UIKit.h>
#import "NSUserDefaults+TokenAccess.h"
#import "TokenRequest.h"
@implementation OAuth2Manager

+ (void)openSafariAndAuthorization{
    NSString * webUrlString = [NSString stringWithFormat:@"%@?client_id=%@&scpe=%@",GitHubAuthorizeURLString,GitHubClientID,GitHubAuthScope];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrlString]];
}

+ (BOOL)delaCallBackUrl:(NSURL *)url{
    if ([url.absoluteString.lowercaseString containsString:GitHubRedirect.lowercaseString]) {
        NSString * codeString = [url.resourceSpecifier substringFromIndex:[url.resourceSpecifier rangeOfString:@"="].location+1];
        TokenRequest * tokenRequest = [[TokenRequest alloc] initWithCode:codeString];
        [tokenRequest startRequestWithFinshBlock:^(id result, NSError *error) {
            if (!error) {
                NSDictionary * resultDictionary = (NSDictionary *)result;
                [[NSUserDefaults standardUserDefaults] setToken:resultDictionary[@"access_token"]];
            }
        }];
        return YES;
    }else{
        return NO;
    }
    
}




@end
