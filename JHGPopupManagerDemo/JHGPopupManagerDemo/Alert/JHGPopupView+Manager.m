//
//  JHGPopupView+Manager.m
//  JHGPopupManagerDemo
//
//  Created by 薛权 on 2025/7/14.
//

#import "JHGPopupView+Manager.h"

@implementation JHGPopupView (Manager)

- (void)jh_showWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self showWithAnimated:animated completion:completion];
}

- (void)jh_hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self hiddenWithAnimated:animated completion:completion];
}

- (BOOL)shouldPopupIn:(UIViewController *)viewController {
    return true;
}

@end
