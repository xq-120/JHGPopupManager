//
//  JHGPopupView+Manager.h
//  JHGPopupManagerDemo
//
//  Created by uzzi on 2025/7/14.
//

#import <JHGPopupKit/JHGPopupView.h>
#import <JHGPopupManager/JHGPopupManager-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHGPopupView (ManagerItem) <JHGPopupManagerItemProtocol>

- (void)jh_showWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)jh_hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (BOOL)jh_shouldPopupIn:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
