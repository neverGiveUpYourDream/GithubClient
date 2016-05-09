//
//  OAuth2Manager.h
//  GitHubClient
//
//  Created by ink on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth2Manager : NSObject

+ (void)openSafariAndAuthorization;

+ (BOOL)delaCallBackUrl:(NSURL *)url;

@end
