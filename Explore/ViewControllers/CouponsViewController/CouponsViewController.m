//
//  CouponsViewController.m
//  Explore
//
//  Created by Varun on 7/06/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "CouponsViewController.h"
#import "CouponCell.h"

NSString *const REUSECouponCell = @"ReuseCouponCell";

@interface CouponsViewController () {
    
    __weak IBOutlet UITableView *tblCoupons;
}

@end

@implementation CouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCouponsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View Defaults

- (void)setupCouponsView {
    
    [self setTitle:@"Coupons"];
    
    UINib *nibCouponCell = [UINib nibWithNibName:@"CouponCell" bundle:nil];
    [tblCoupons registerNib:nibCouponCell forCellReuseIdentifier:REUSECouponCell];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Delegate and DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CouponCell *cellCoupon = [tableView dequeueReusableCellWithIdentifier:REUSECouponCell];
    [cellCoupon setCouponText:[NSString stringWithFormat:@"Coupon No. #%ld", (long)indexPath.row]];
    return cellCoupon;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
