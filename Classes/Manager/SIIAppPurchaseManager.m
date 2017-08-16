//
//  SIIAppPurchaseManager.m
//  Category
//
//  Created by Silence on 24/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SIIAppPurchaseManager.h"
#import <StoreKit/StoreKit.h>
#import <netdb.h>  // 检查网络是否可用

@interface SIIAppPurchaseManager () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong) NSMutableArray *purchasedItems;
@property (strong) NSMutableDictionary *products;
@property BOOL purchasedItemsChanged;

@property (strong) NSMutableArray *productRequests;
@property (strong) NSMutableArray *payments;

@property (strong) NSMutableArray *purchasesChangedCallbacks;

@property (copy) RestorePurchasesCompletionBlock restoreCompletionBlock;
@property (copy) ErrorBlock restoreErrorBlock;

@end

NSURL *purchasesURL() {
    NSURL *appDocDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [appDocDir URLByAppendingPathComponent:@".purchases.plist"];
}

BOOL checkAppStoreAvailable() {
    const char *hostname = "appstore.com";
    struct hostent *hostinfo = gethostbyname(hostname);
    if (hostinfo == NULL) {
#ifdef DEBUG
        NSLog(@"-> no connection to App Store!\n");
#endif
        struct hostent *hostinfo2 = gethostbyname2(hostname,AF_INET6);
        
        if (hostinfo2 == NULL) {
            return NO;
        }
    }
    return YES;
}

@implementation SIIAppPurchaseManager

+ (SIIAppPurchaseManager *)sharedManager{
    static SIIAppPurchaseManager *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SIIAppPurchaseManager alloc]init] ;
    });
    return manager ;
}

- (instancetype)init{
    if (self = [super init]) {
        _purchasedItems = [NSMutableArray arrayWithContentsOfURL:purchasesURL()] ;
        if(!_purchasedItems){
            _purchasedItems = [NSMutableArray array] ;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self] ;
        _products = [NSMutableDictionary dictionary] ;
        _productRequests = [NSMutableArray array] ;
        _payments = [NSMutableArray array] ;
        _purchasesChangedCallbacks = [NSMutableArray array] ;
    }
    return self ;
}

- (void)persistPurchasedItems {
    BOOL success = [self.purchasedItems writeToURL:purchasesURL() atomically:YES];
    if(!success) {
        NSLog(@"保存购买列表到 %@ 失败!", purchasesURL());
    }
}

- (void)willResignActive:(NSNotification *)notification {
    if(self.purchasedItemsChanged) {
        [self persistPurchasedItems];
    }
}

- (BOOL)hasPurchased:(NSString *)productID{
    return [self.purchasedItems containsObject:productID] ;
}

#pragma mark --- 商品信息
- (void)getProductsForIds:(NSArray *)productIds completion:(ProductsCompletionBlock)completionBlock error:(ErrorBlock)errorBlock{
    NSMutableArray *results = [NSMutableArray array] ;
    NSMutableSet *remainIds = [NSMutableSet set] ;
    for (NSString *productId in productIds){
        if ([self.products objectForKey:productIds]){
            [results addObject:[self.products objectForKey:productId]] ;
        }else{
            [remainIds addObject:productId] ;
        }
    }
    
    if(remainIds.count == 0){
        completionBlock(results) ;
        return ;
    }
    
    if (!errorBlock) {
        errorBlock = ^(NSError *error){} ;
    }
    
    SKProductsRequest *req = [[SKProductsRequest alloc]initWithProductIdentifiers:remainIds] ;
    req.delegate = self ;
    [self.productRequests addObject:@[req,completionBlock,errorBlock]] ;
    [req start] ;
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSUInteger c = [self.productRequests count];
    for(int i = 0; i < c; ++i) {
        NSArray *tuple = [self.productRequests objectAtIndex:i];
        if([tuple objectAtIndex:0] == request) {
            ProductsCompletionBlock completion = [tuple objectAtIndex:1];
            completion(response.products);
            [self.productRequests removeObjectAtIndex:i];
            return;
        }
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSUInteger c = [self.productRequests count];
    for(int i = 0; i < c; ++i) {
        NSArray *tuple = [self.productRequests objectAtIndex:i];
        if([tuple objectAtIndex:0] == request) {
            ErrorBlock errorBlock = [tuple objectAtIndex:2];
            errorBlock(error);
            [self.productRequests removeObjectAtIndex:i];
            return;
        }
    }
}

#pragma mark --- 购买
- (void)restorePurchases {
    [self restorePurchasesWithCompletion:nil];
}

- (void)restorePurchasesWithCompletion:(RestorePurchasesCompletionBlock)completionBlock {
    self.restoreCompletionBlock = completionBlock;
    return [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)restorePurchasesWithCompletion:(RestorePurchasesCompletionBlock)completionBlock error:(ErrorBlock)err {
    self.restoreErrorBlock = err;
    [self restorePurchasesWithCompletion:completionBlock];
}

- (void)purchaseProduct:(SKProduct *)product completion:(PurchaseCompletionBlock)completionBlock error:(ErrorBlock)err {
#ifdef SIMULATE_PURCHASES
    [self.purchasedItems addObject:product.productIdentifier];
    self.purchasedItemsChanged = YES;
    for(NSArray *t in self.purchasesChangedCallbacks) {
        PurchasedProductsChanged callback = t[0];
        callback();
    }
    [self persistPurchasedItems];
    completionBlock(NULL);
#else
    if(![self canPurchase])
        err([NSError errorWithDomain:@"SIIAppPurchaseManager" code:0 userInfo:[NSDictionary dictionaryWithObject:@"支付失败" forKey:NSLocalizedDescriptionKey]]);
    else {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [self.payments addObject:@[payment.productIdentifier, completionBlock, err]];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
#endif
}

- (void)purchaseProductForId:(NSString *)productId completion:(PurchaseCompletionBlock)completionBlock error:(ErrorBlock)err {
#ifdef SIMULATE_PURCHASES
    [self.purchasedItems addObject:productId];
    self.purchasedItemsChanged = YES;
    for(NSArray *t in self.purchasesChangedCallbacks) {
        PurchasedProductsChanged callback = t[0];
        callback();
    }
    [self persistPurchasedItems];
    completionBlock(NULL);
#else
    [self getProductsForIds:@[productId] completion:^(NSArray *products) {
        if([products count] == 0) err([NSError errorWithDomain:@"IAPManager" code:0 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Didn't find products with ID %@", productId] forKey:NSLocalizedDescriptionKey]]);
        else [self purchaseProduct:[products objectAtIndex:0] completion:completionBlock error:err];
    } error:^(NSError *error) {
        err(error);
    }];
#endif
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    BOOL newPurchases = NO;
    for(SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStateRestored:
            case SKPaymentTransactionStatePurchased: {
                [self.purchasedItems addObject:transaction.payment.productIdentifier];
                newPurchases = YES;
                [queue finishTransaction:transaction];
                break;
            }
            case SKPaymentTransactionStateFailed: {
                [queue finishTransaction:transaction];
                break;
            }
            case SKPaymentTransactionStatePurchasing: {
#ifdef DEBUG
                NSLog(@"%@ 通过 App Store...", transaction.payment.productIdentifier);
#endif
                break;
            }
            default: break;
        }
    }
    
    if(newPurchases) {
        [self persistPurchasedItems];
        self.purchasedItemsChanged = YES;
        
        for(NSArray *t in self.purchasesChangedCallbacks) {
            PurchasedProductsChanged callback = t[0];
            callback();
        }
    }
    
    for(SKPaymentTransaction *transaction in transactions) {
        NSUInteger c = [self.payments count];
        PurchaseCompletionBlock completion = nil;
        ErrorBlock err = nil;
        for(int i = 0; i < c; ++i) {
            NSArray *t = [self.payments objectAtIndex:i];
            if([t[0] isEqual:transaction.payment.productIdentifier]) {
                completion = t[1];
                err = t[2];
                break;
            }
        }
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStateRestored:
            case SKPaymentTransactionStatePurchased: {
                if(completion) completion(transaction);
                break;
            }
            case SKPaymentTransactionStateFailed: {
                if(err) err(transaction.error);
                break;
            }
            case SKPaymentTransactionStatePurchasing: {
                break;
            }
            default: break;
        }
    }
}

- (BOOL)canPurchase {
    return [SKPaymentQueue canMakePayments] && checkAppStoreAvailable();
}

#pragma mark --- 状态改变

- (void)addPurchasesChangedCallback:(PurchasedProductsChanged)callback withContext:(id)context {
    [self.purchasesChangedCallbacks addObject:@[callback, context]];
}

- (void)removePurchasesChangedCallbackWithContext:(id)context {
    NSUInteger c = [self.purchasesChangedCallbacks count];
    for(NSInteger i = c - 1; i >= 0; --i) {
        NSArray *t = self.purchasesChangedCallbacks[i];
        if(t[1] == context) {
            [self.purchasesChangedCallbacks removeObjectAtIndex:i];
        }
    }
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    if(self.restoreErrorBlock) {
        self.restoreErrorBlock(error);
    }
    self.restoreCompletionBlock = nil;
    self.restoreErrorBlock = nil;
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    if (self.restoreCompletionBlock) {
        self.restoreCompletionBlock();
    }
    self.restoreCompletionBlock = nil;
    self.restoreErrorBlock = nil;
}

@end
