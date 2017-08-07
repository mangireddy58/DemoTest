//
// RTSpinKitUtils.m
//  eMaguen
//
//  Created by Rohit Yermalkar on 05/06/14.
//  Copyright (c) 2014 Simplicity. All rights reserved.
//

#import "RTSpinKitUtils.h"

#import "RTSpinKitFadingCircleAltAnimation.h"


CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective,
                                                 CGFloat angle,
                                                 CGFloat x,
                                                 CGFloat y,
                                                 CGFloat z)
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

NSObject<RTSpinKitAnimating>* RTSpinKitAnimationFromStyle(RTSpinKitViewStyle style)
{
    switch (style) {
//        case RTSpinKitViewStylePlane:
//            return [[RTSpinKitPlaneAnimation alloc] init];
            
//        case RTSpinKitViewStyleCircleFlip:
//            return [[RTSpinKitCircleFlipAnimation alloc] init];
//            
//        case RTSpinKitViewStyleBounce:
//            return [[RTSpinKitBounceAnimation alloc] init];
//            
//        case RTSpinKitViewStyleWave:
//            return [[RTSpinKitWaveAnimation alloc] init];
//            
//        case RTSpinKitViewStyleWanderingCubes:
//            return [[RTSpinKitWanderingCubesAnimation alloc] init];
//            
//        case RTSpinKitViewStylePulse:
//            return [[RTSpinKitPulseAnimation alloc] init];
//            
//        case RTSpinKitViewStyleChasingDots:
//            return [[RTSpinKitChasingDotsAnimation alloc] init];
//            
//        case RTSpinKitViewStyleThreeBounce:
//            return [[RTSpinKitThreeBounceAnimation alloc] init];
//            
//        case RTSpinKitViewStyleCircle:
//            return [[RTSpinKitCircleAnimation alloc] init];
//            
//        case RTSpinKitViewStyle9CubeGrid:
//            return [[RTSpinKit9CubeGridAnimation alloc] init];
//            
//        case RTSpinKitViewStyleWordPress:
//            return [[RTSpinKitWordPressAnimation alloc] init];
//            
//        case RTSpinKitViewStyleFadingCircle:
//            return [[RTSpinKitFadingCircleAnimation alloc] init];
//            
        case RTSpinKitViewStyleFadingCircleAlt:
            return [[RTSpinKitFadingCircleAltAnimation alloc] init];
            
//        case RTSpinKitViewStyleArc:
//            return [[RTSpinKitArcAnimation alloc] init];
            
//        case RTSpinKitViewStyleArcAlt:
//            return [[RTSpinKitArcAltAnimation alloc] init];
            
        default:
            NSCAssert(NO, @"Unicorns exist");
    }
    return nil;
}
