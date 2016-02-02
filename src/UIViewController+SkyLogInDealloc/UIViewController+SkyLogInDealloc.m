//
//  UIViewController+SkyLogInDealloc.m
//
//  Created by skytoup on 16/2/2.
//  Copyright © 2016年 skytoup. All rights reserved.
//

#import "UIViewController+SkyLogInDealloc.h"
#import <objc/runtime.h>

@implementation UIViewController (SkyLogInDealloc)

#if DEBUG
+ (void)load {
    [super load];

    SEL originSEL  = NSSelectorFromString(@"dealloc");
    SEL swapSEL = @selector(skyLogInDealloc);
    
    Method originMethod = class_getInstanceMethod(self, originSEL);
    Method swapMethod = class_getInstanceMethod(self, swapSEL);
    
    IMP originIMP = method_getImplementation(originMethod);
    IMP swapIMP = method_getImplementation(swapMethod);

    BOOL didAddMethod = class_addMethod(self, originSEL, swapIMP, method_getTypeEncoding(originMethod));
    
    if(didAddMethod) {
        class_replaceMethod(self, swapSEL, originIMP, method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swapMethod);
    }
}

- (void)skyLogInDealloc {
    printf("\n");
    NSLog(@"-------------start-------------");
    NSLog(@"Dealloc : %@", NSStringFromClass([self class]));
    NSLog(@"--------------end--------------");
    printf("\n");
    [self skyLogInDealloc];
}
#endif

@end

