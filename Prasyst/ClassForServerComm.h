//
//  ClassForServerComm.h
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConstant.h"


@protocol ClassForServerCommDelegate <NSObject>

@optional


- (void)onServiceSuccess:(id)response;
- (void)onServiceFailed;
- (void)onWebViewServiceSuccess:(NSString *)resString;
@end

@interface ClassForServerComm : NSObject

@property (nonatomic, assign) id<ClassForServerCommDelegate> delegate;

- (void)sendHttpGetRequestWithParam:(NSString *)parametersString andServiceName:(NSString *)serviceName;
- (void)sendHttpPostRequestWithParam:(NSString *)parametersString andServiceName:(NSString *)serviceName;
- (void)sendHttpRequestWithParam:(NSString *)parametersString andServiceName:(NSString *)serviceName;
@end
