//
//  AdminMissionCategoryViewController.m
//  Explore
//
//  Created by Varun on 26/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AdminMissionCategoryViewController.h"

#import "ProfileViewController.h"

#import "MissionModel.h"
#import "CategoryModel.h"
#import "UserModel.h"

@interface AdminMissionCategoryViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate, UISearchBarDelegate> {
    
    NSMutableArray *arrModelsType;
    //    id editingModel;
    NSInteger indexNumber;
    
    __weak IBOutlet UITableView *tableViewCatMiss;
    //    For Mission
    
    __weak IBOutlet UIView *viewMission;
    __weak IBOutlet UIImageView *imgViewMission;
    __weak IBOutlet UITextField *txtFieldCategory;
    __weak IBOutlet UITextField *txtFieldMission;
    __weak IBOutlet UITextView *txtFieldMissionDesc;
    __weak IBOutlet UIButton *btnMission;
    
    //    For Category
    
    __weak IBOutlet UIView *viewCategory;
    __weak IBOutlet UITextField *txtFieldCategoryTitle;
    __weak IBOutlet UITextView *txtFieldCategoryDesc;
    __weak IBOutlet UIButton *btnCategory;
    
    //    Input Accessory
    UITableView *tblViewMissionAccessory;
    NSMutableArray *arrNewMissionCategories;
    
    NSMutableArray *arrSearchResults;
    UISearchBar *searchBarUser;
}

@end

@implementation AdminMissionCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [txtFieldCategoryDesc.layer setCornerRadius:4.0f];
    [txtFieldMissionDesc.layer setCornerRadius:4.0f];
    
    [btnCategory.layer setCornerRadius:4.0f];
    [btnMission.layer setCornerRadius:4.0f];
    
    arrNewMissionCategories = [[NSMutableArray alloc] init];
    arrModelsType = [[NSMutableArray alloc] init];
    
    tblViewMissionAccessory = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 256)];
    [tblViewMissionAccessory setDelegate:self];
    [tblViewMissionAccessory setDataSource:self];
    
    [txtFieldCategory setInputView:tblViewMissionAccessory];
    
    [self setTitle:(_adminChoiceType == ChoiceMission) ? @"Missions" : ((_adminChoiceType == ChoiceCategory) ? @"Categories" : @"Users")];
    
    for (int i = 0; i < 10; i ++) {
        
        NSString *strTitle = [NSString stringWithFormat:@"## %d", i];
        NSString *strID = [NSString stringWithFormat:@"%d", i];
        NSString *strDesc = [NSString stringWithFormat:@"Description %d", i];
        
        id modelToAdd;
        
        switch (_adminChoiceType) {
            case ChoiceMission: {
                
                NSMutableArray *arrCategories = [[NSMutableArray alloc] initWithObjects:
                                                 @"Category 1", nil];
                
                MissionModel *objMission = [[MissionModel alloc] init];
                [objMission setMissionID:strID];
                [objMission setMissionArrCategory:arrCategories];
                [objMission setMissionName:[strTitle  stringByReplacingOccurrencesOfString:@"##" withString:@"Mission"]];
                [objMission setMissionDescription:strDesc];
                [objMission setMissionImageUrl:nil];
                
                modelToAdd = objMission;
            }
                break;
            case ChoiceCategory: {
                CategoryModel *objCategory = [[CategoryModel alloc] init];
                [objCategory setCategoryID:strID];
                [objCategory setCategoryName:[strTitle stringByReplacingOccurrencesOfString:@"##" withString:@"Category"]];
                [objCategory setCategoryDescription:strDesc];
                
                modelToAdd = objCategory;
            }
                break;
            case ChoiceUsers: {
                UserModel *objUser = [[UserModel alloc] init];
                [objUser setUserID:strID];
                [objUser setUserName:[strTitle stringByReplacingOccurrencesOfString:@"##" withString:@"User"]];
                [objUser setUserMobile:@"999"];
                [objUser setUserAddress:@"Add"];
                [objUser setUserImageUrl:@""];
                
                modelToAdd = objUser;
            }
                break;
        }
        
        [arrModelsType addObject:modelToAdd];
    }
    
    indexNumber = -1;
    
    if (_adminChoiceType != ChoiceUsers) {
        UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addModelInArray)];
        [self.navigationItem setRightBarButtonItem:barButtonAdd];
    }
    else {
        searchBarUser = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        [searchBarUser setEnablesReturnKeyAutomatically:YES];
        [searchBarUser setShowsCancelButton:YES];
        [searchBarUser setDelegate:self];
        [tableViewCatMiss setTableHeaderView:searchBarUser];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    tblViewMissionAccessory.delegate = nil;
    tblViewMissionAccessory.dataSource = nil;
    tblViewMissionAccessory = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)clearViews {
    
    [arrNewMissionCategories removeAllObjects];
    arrNewMissionCategories = nil;
    
    [txtFieldCategory resignFirstResponder];
    [txtFieldCategoryDesc resignFirstResponder];
    [txtFieldCategoryTitle resignFirstResponder];
    [txtFieldMission resignFirstResponder];
    [txtFieldMissionDesc resignFirstResponder];
    
    [txtFieldCategory setText:@""];
    [txtFieldCategoryDesc setText:@"category description"];
    [txtFieldCategoryTitle setText:@""];
    [txtFieldMission setText:@""];
    [txtFieldMissionDesc setText:@"mission description"];
    
    [txtFieldMissionDesc setTextColor:[UIColor colorWithWhite:200/255.0 alpha:1.0f]];
    [txtFieldCategoryDesc setTextColor:[UIColor colorWithWhite:200/255.0 alpha:1.0f]];
}

#pragma mark - To Save Mission

- (IBAction)buttonSaveMissionTouched:(id)sender {
}

#pragma mark - To Save Category

- (IBAction)buttonSaveCategoryTouched:(id)sender {
    
    BOOL isEmpty = NO;
    BOOL isMission = (_adminChoiceType == ChoiceMission);
    
    UIView *theViewToCheck = !isMission ? viewCategory : viewMission;
    
    for (UIView *theSubView in theViewToCheck.subviews) {
        if ([theSubView isKindOfClass:[UITextField class]]) {
            isEmpty = ![[(UITextField *)theSubView text] length];
        }
        else if ([theSubView isKindOfClass:[UITextView class]]) {
            isEmpty = ![[(UITextView *)theSubView text] length];
        }
        
        if (isEmpty)
            break;
    }
    
    if (isEmpty) {
        [[[UIAlertView alloc] initWithTitle:@"Missing"
                                    message:@"All fields are mandatory, please fill all fields"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    else {
        
        if (indexNumber != -1) {
            
            id editingModel = [arrModelsType objectAtIndex:indexNumber];
            id newModelToInsert = nil;
            
            if (isMission) {
                
                MissionModel *objNewMiss = [[MissionModel alloc] init];
                [objNewMiss setMissionName:txtFieldMission.text];
                [objNewMiss setMissionDescription:txtFieldMissionDesc.text];
                [objNewMiss setMissionImageUrl:nil];
                [objNewMiss setMissionArrCategory:[[NSMutableArray alloc] initWithArray:arrNewMissionCategories]];
                [objNewMiss setMissionID:[(MissionModel *)editingModel missionID]];
                
                newModelToInsert = objNewMiss;
            }
            else {
                
                CategoryModel *objNewCat = [[CategoryModel alloc] init];
                [objNewCat setCategoryDescription:txtFieldCategoryDesc.text];
                [objNewCat setCategoryName:txtFieldCategoryTitle.text];
                [objNewCat setCategoryID:[(CategoryModel *)editingModel categoryID]];
                
                newModelToInsert = objNewCat;
            }
            [arrModelsType replaceObjectAtIndex:indexNumber withObject:newModelToInsert];
        }
        else {
            
            CategoryModel *catModel = nil;
            MissionModel *missModel = nil;
            
            if (isMission) {
                
                missModel = [[MissionModel alloc] init];
                [missModel setMissionID:[NSString stringWithFormat:@"%d", arrModelsType.count]];
                [missModel setMissionImageUrl:nil];
                [missModel setMissionArrCategory:[[NSMutableArray alloc] initWithArray:arrNewMissionCategories]];
                [missModel setMissionDescription:txtFieldMissionDesc.text];
                [missModel setMissionName:txtFieldMission.text];
                
                [arrModelsType addObject:missModel];
            }
            else {
                
                catModel = [[CategoryModel alloc] init];
                [catModel setCategoryDescription:txtFieldCategoryDesc.text];
                [catModel setCategoryName:txtFieldCategoryTitle.text];
                [catModel setCategoryID:[NSString stringWithFormat:@"%d", arrModelsType.count]];
                
                [arrModelsType addObject:catModel];
            }
            [arrNewMissionCategories removeAllObjects];
            arrNewMissionCategories = nil;
        }
        [tableViewCatMiss reloadData];
        [self performSelector:@selector(buttonCloseMissionOrCategoryTouched:)
                   withObject:nil];
        indexNumber = -1;
    }
}

#pragma mark - Add Bar Button Action

- (void)addModelInArray {
    
    if (!arrNewMissionCategories)
    arrNewMissionCategories = [[NSMutableArray alloc] init];
    
    UIView *viewToShow = (_adminChoiceType == ChoiceCategory) ? viewCategory : viewMission;
    
    [UIView animateWithDuration:0.25
                     animations:^ {
                         [viewToShow setAlpha:1.0f];
                     }];
}

#pragma mark - To remove the views

- (IBAction)buttonCloseMissionOrCategoryTouched:(id)sender {
    
    indexNumber = -1;
    UIView *viewToHide = (_adminChoiceType == ChoiceCategory) ? viewCategory : viewMission;
    
    [UIView animateWithDuration:0.15
                     animations:^ {
                         [viewToHide setAlpha:0.0f];
                     }];
    [self clearViews];
}

#pragma mark - Fill Accessory View

- (void)fillAccessoryViewWithModelForIndex:(NSInteger)index {
    
    indexNumber = index;
    id editingModel = [arrModelsType objectAtIndex:index];
    if (_adminChoiceType == ChoiceMission) {
        
        MissionModel *objMission = (MissionModel *)editingModel;
        
        [arrNewMissionCategories removeAllObjects];
        arrNewMissionCategories = nil;
        
        arrNewMissionCategories = [[NSMutableArray alloc] initWithArray:objMission.missionArrCategory];
        
        [txtFieldMission setText:objMission.missionName];
        [txtFieldCategory setText:[arrNewMissionCategories componentsJoinedByString:@", "]];
        [txtFieldMissionDesc setText:objMission.missionDescription];
    }
    else {
        
        CategoryModel *objCategory = (CategoryModel *)editingModel;
        [txtFieldCategoryTitle setText:objCategory.categoryName];
        [txtFieldCategoryDesc setText:objCategory.categoryDescription];
    }
    
    [txtFieldMissionDesc setTextColor:[UIColor blackColor]];
    [txtFieldCategoryDesc setTextColor:[UIColor blackColor]];
    [self performSelector:@selector(addModelInArray)];
}

#pragma mark - Show Profile

- (void)showUserProfile {
    
    UIStoryboard *storyboardUser = [UIStoryboard storyboardWithName:_EX_IDMainStrbrd
                                                             bundle:nil];
    ProfileViewController *objProfileView = [storyboardUser instantiateViewControllerWithIdentifier:_EX_IDProfileStrbrdID];
    [self.navigationController pushViewController:objProfileView animated:YES];
}

#pragma mark - TextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [textView setText:@""];
    [textView setTextColor:[UIColor blackColor]];
}

#pragma mark - SearchBar Delegate

//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//    
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchBar.text length] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName contains[c] %@", searchBar.text];
        NSArray *filteredArray = [arrModelsType filteredArrayUsingPredicate:predicate];
        arrSearchResults = [NSMutableArray arrayWithArray:filteredArray];
    }
    else
        [arrSearchResults removeAllObjects];
    [tableViewCatMiss reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [arrSearchResults removeAllObjects];
    [tableViewCatMiss reloadData];
}

#pragma mark - UITableView Delegates/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView == tblViewMissionAccessory ? 10 : (arrSearchResults.count || searchBarUser.text.length ? [arrSearchResults count] : [arrModelsType count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"ModelCellType";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if (tableView != tblViewMissionAccessory) {
        BOOL isMission = (_adminChoiceType == ChoiceMission);
        BOOL isCategory = (_adminChoiceType == ChoiceCategory);
        
        id addedModel = [arrModelsType objectAtIndex:indexPath.row];
        if ([arrSearchResults count] || searchBarUser.text.length) {
            addedModel = [arrSearchResults objectAtIndex:indexPath.row];
        }
        
        NSString *title = isMission ? [(MissionModel *)addedModel missionName] : (isCategory ? [(CategoryModel *)addedModel categoryName] : [(UserModel *)addedModel userName]);
        
        [cell.textLabel setText:title];
        if (_adminChoiceType == ChoiceMission || _adminChoiceType == ChoiceUsers)
            [cell.imageView setImage:[UIImage imageNamed:@"proflle_img"]];
    }
    else {
        
        NSString *strToShow = [NSString stringWithFormat:@"Category %d", indexPath.row];
        [cell.textLabel setText:strToShow];
        NSInteger accessoryType = UITableViewCellAccessoryNone;
        if ([arrNewMissionCategories containsObject:strToShow])
            accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setAccessoryType:accessoryType];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView != tblViewMissionAccessory) {
        if (_adminChoiceType != ChoiceUsers)
            [self fillAccessoryViewWithModelForIndex:indexPath.row];
        else
            [self showUserProfile];
    }
    else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *textCell = [[cell textLabel] text];
        
        if ([arrNewMissionCategories containsObject:textCell]) {
            [arrNewMissionCategories removeObject:textCell];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else {
            [arrNewMissionCategories addObject:textCell];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        [txtFieldCategory setText:[arrNewMissionCategories componentsJoinedByString:@", "]];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrModelsType removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        //        [tableView reloadData];
    }
}

#pragma mark - UITextField Delegate 

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == txtFieldCategory)
        [tblViewMissionAccessory reloadData];
}

#pragma mark - Touch Method

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIView *viewTouched = [[touches anyObject] view];
    if (viewTouched == viewMission || viewTouched == viewCategory) {
        
        for (UIView *sbView in viewTouched.subviews) {
            if ([sbView isKindOfClass:[UITextField class]] ||
                [sbView isKindOfClass:[UITextView class]]) {
                
                [sbView resignFirstResponder];
            }
        }
    }
}

@end
