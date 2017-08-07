//
// RTSpinKitUtils.h
//  eMaguen
//
//  Created by Rohit Yermalkar on 05/06/14.
//  Copyright (c) 2014 Simplicity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTSpinKitView.h"
#import "RTSpinKitAnimating.h"

CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective, CGFloat angle, CGFloat x, CGFloat y, CGFloat z);
NSObject<RTSpinKitAnimating>* RTSpinKitAnimationFromStyle(RTSpinKitViewStyle style);
