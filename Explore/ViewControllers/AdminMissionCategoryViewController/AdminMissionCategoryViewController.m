//
//  AdminMissionCategoryViewController.m
//  Explore
//
//  Created by Varun on 26/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AdminMissionCategoryViewController.h"

#import "MissionModel.h"
#import "CategoryModel.h"

@interface AdminMissionCategoryViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate> {
    
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
    
//    For Category
    
    __weak IBOutlet UIView *viewCategory;
    __weak IBOutlet UITextField *txtFieldCategoryTitle;
    __weak IBOutlet UITextView *txtFieldCategoryDesc;
}

@end

@implementation AdminMissionCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrModelsType = [[NSMutableArray alloc] init];
    
    BOOL isMission = (_adminChoiceType == ChoiceMission);
    NSString *prefixCatName = !isMission ? @"Category" : @"Mission";
    [self setTitle:prefixCatName];
    for (int i = 0; i < 10; i ++) {
        
        NSString *strTitle = [NSString stringWithFormat:@"%@ %d", prefixCatName, i];
        NSString *strID = [NSString stringWithFormat:@"%d", i];
        NSString *strDesc = [NSString stringWithFormat:@"Description %d", i];
        
        id modelToAdd;
        
        if (isMission) {
            
            MissionModel *objMission = [[MissionModel alloc] init];
            [objMission setMissionID:strID];
            [objMission setMissionCategory:@"Category"];
            [objMission setMissionName:strTitle];
            [objMission setMissionDescription:strDesc];
            [objMission setMissionImageUrl:nil];
            
            modelToAdd = objMission;
        }
        else {
            
            CategoryModel *objCategory = [[CategoryModel alloc] init];
            [objCategory setCategoryID:strID];
            [objCategory setCategoryName:strTitle];
            [objCategory setCategoryDescription:strDesc];
            
            modelToAdd = objCategory;
        }
        
        [arrModelsType addObject:modelToAdd];
    }
    
    indexNumber = -1;
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addModelInArray)];
    [self.navigationItem setRightBarButtonItem:barButtonAdd];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
                [objNewMiss setMissionCategory:txtFieldCategory.text];
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
                [missModel setMissionCategory:txtFieldCategory.text];
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
        }
        [tableViewCatMiss reloadData];
        [self performSelector:@selector(buttonCloseMissionOrCategoryTouched:)
                   withObject:nil];
        indexNumber = -1;
    }
}

#pragma mark - Add Bar Button Action

- (void)addModelInArray {
    
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
        [txtFieldMission setText:objMission.missionName];
        [txtFieldCategory setText:objMission.missionCategory];
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

#pragma mark - TextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {

    [textView setText:@""];
    [textView setTextColor:[UIColor blackColor]];
}

#pragma mark - UITableView Delegates/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrModelsType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"ModelCellType";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    BOOL isMission = (_adminChoiceType == ChoiceMission);
    id addedModel = [arrModelsType objectAtIndex:indexPath.row];

    NSString *title = isMission ? [(MissionModel *)addedModel missionName] : [(CategoryModel *) addedModel categoryName];
    
    [cell.textLabel setText:title];
    if (_adminChoiceType == ChoiceMission)
        [cell.imageView setImage:[UIImage imageNamed:@"proflle_img"]];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self fillAccessoryViewWithModelForIndex:indexPath.row];
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
