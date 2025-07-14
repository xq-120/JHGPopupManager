//
//  JHGPopupView+Manager.h
//  JHGPopupManagerDemo
//
//  Created by 薛权 on 2025/7/14.
//

#import <JHGPopupKit/JHGPopupView.h>
#import <JHGPopupManager/JHGPopupManager-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHGPopupView (Manager) <JHGPopupViewProtocol>

- (void)jh_showWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)jh_hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (BOOL)shouldPopupIn:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
