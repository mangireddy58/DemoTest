//
// RTSpinKitView.m
//  eMaguen
//
//  Created by Rohit Yermalkar on 05/06/14.
//  Copyright (c) 2014 Simplicity. All rights reserved.
//

#import "RTSpinKitView.h"
#import "RTSpinKitUtils.h"

#include <tgmath.h>

static const CGFloat kRTSpinKitViewDefaultSpinnerSize = 37.0;

@interface RTSpinKitView ()
@end

@implementation RTSpinKitView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self applyAnimation];
    }

    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [self initWithStyle:RTSpinKitViewStylePlane];
    if (self) {
        self.frame = frame;
    }
    return self;
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style {
    return [self initWithStyle:style color:[UIColor grayColor]];
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor *)color {
    return [self initWithStyle:style color:color spinnerSize:kRTSpinKitViewDefaultSpinnerSize];
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color spinnerSize:(CGFloat)spinnerSize {
    self = [super initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2) - (spinnerSize/2), ([UIScreen mainScreen].bounds.size.height/2) - spinnerSize, spinnerSize, spinnerSize)];
    if (self) {
        _style = style;
        _color = color;
        _spinnerSize = spinnerSize;
        _hidesWhenStopped = YES;
        [self applyAnimation];
        [self sizeToFit];
    }
    return self;
}

-(void)setStyle:(RTSpinKitViewStyle)style {
    _style = style;
    [self applyAnimation];
}

-(void)setSpinnerSize:(CGFloat)spinnerSize {
    _spinnerSize = spinnerSize;
    [self applyAnimation];
    [self invalidateIntrinsicContentSize];
}

#pragma mark - Animation

-(void)applyAnimation {
    // Remove any sublayer.
    self.layer.sublayers = nil;

    CGSize size = CGSizeMake(self.spinnerSize, self.spinnerSize);
    NSObject<RTSpinKitAnimating> *animation = RTSpinKitAnimationFromStyle(self.style);
    [animation setupSpinKitAnimationInLayer:self.layer withSize:size color:self.color];
}

#pragma mark - Hooks

-(void)applicationWillEnterForeground {
    if (self.stopped) {
        [self pauseLayers];
    } else {
        [self resumeLayers];
    }
}

-(void)applicationDidEnterBackground {
    [self pauseLayers];
}

-(BOOL)isAnimating {
    return !self.isStopped;
}

-(void)startAnimating {
    if (self.isStopped) {
        self.hidden = NO;
        self.stopped = NO;
        [self resumeLayers];
    }
}

-(void)stopAnimating {
    if ([self isAnimating]) {
        if (self.hidesWhenStopped) {
            self.hidden = YES;
        }
        
        self.stopped = YES;
        [self pauseLayers];
    }
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(self.spinnerSize, self.spinnerSize);
}

-(CGSize)intrinsicContentSize {
    return CGSizeMake(self.spinnerSize, self.spinnerSize);
}

-(void)setColor:(UIColor *)color {
    _color = color;
    for (CALayer *l in self.layer.sublayers) {
        l.backgroundColor = color.CGColor;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
