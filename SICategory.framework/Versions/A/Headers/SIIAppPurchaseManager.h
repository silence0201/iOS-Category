//
//  SIIAppPurchaseManager.h
//  Category
//
//  Created by 杨晴贺 on 24/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SKPaymentTransaction,SKProduct ;
typedef void(^PurchaseCompletionBlock)(SKPaymentTransaction *transaction);
typedef void(^ProductsCompletionBlock)(NSArray *products);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^PurchasedProductsChanged)();
typedef void(^RestorePurchasesCompletionBlock)();

@interface SIIAppPurchaseManager : NSObject

+ (SIIAppPurchaseManager *)sharedManager ;

- (BOOL)hasPurchased:(NSString *)productID ;

#pragma mark --- 商品信息
- (void)getProductsForIds:(NSArray *)productIds
               completion:(ProductsCompletionBlock)completionBlock
                    error:(ErrorBlock)errorBlock ;

#pragma mark --- 购买
- (void)restorePurchases ;

- (void)restorePurchasesWithCompletion:(RestorePurchasesCompletionBlock)completionBlock;

- (void)restorePurchasesWithCompletion:(RestorePurchasesCompletionBlock)completionBlock error:(ErrorBlock)err;

- (void)purchaseProduct:(SKProduct *)product completion:(PurchaseCompletionBlock)completionBlock error:(ErrorBlock)err;

- (void)purchaseProductForId:(NSString *)productId completion:(PurchaseCompletionBlock)completionBlock error:(ErrorBlock)err;

- (BOOL)canPurchase;

#pragma mark --- 状态改变
- (void)addPurchasesChangedCallback:(PurchasedProductsChanged)callback withContext:(id)context;

- (void)removePurchasesChangedCallbackWithContext:(id)context;


@end
