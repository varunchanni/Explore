//
//  AdminQuesViewController.m
//  Explore
//
//  Created by Varun on 1/08/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AdminQuesViewController.h"
#import "QuestionModel.h"

static NSString *REUSEQuesCellID = @"QuestionCell";

@interface AdminQuesViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    __weak IBOutlet UITableView *tblViewQuestions;
    __weak IBOutlet UIButton *btnSave;
    __weak IBOutlet UIView *viewQuestion;
    __weak IBOutlet UIView *viewContent;
    __weak IBOutlet UITextField *txtFieldMissions;
    __weak IBOutlet UITextView *txtViewQuestion;
    __weak IBOutlet UITextView *txtViewAnswer;
    __weak IBOutlet UITextField *txtFieldPoints;
    __weak IBOutlet NSLayoutConstraint *constraintViewContentToSuperview;   // 15 default
    
    NSMutableArray *arrQuesModels;
    NSMutableArray *arrCurrentMissions;
    UITableView *tblViewQuestionAccessory;
    QuestionModel *modelCurrent;
}

@end

@implementation AdminQuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupQuestionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    tblViewQuestionAccessory.delegate = nil;
    tblViewQuestionAccessory.dataSource = nil;
    tblViewQuestionAccessory = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - To be Deleted

- (void)makeDefaultArrayOfModels {
    
    arrQuesModels = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 10; i ++) {
        
        QuestionModel *objQuesModel = [[QuestionModel alloc] init];
        [objQuesModel setQuesID:[NSString stringWithFormat:@"%d", i]];
        [objQuesModel setQuesText:[NSString stringWithFormat:@"Square of %d?", i]];
        [objQuesModel setQuesAnswer:[NSString stringWithFormat:@"Answer is %d", i * i]];
        [objQuesModel setQuesArrMissions:[[NSMutableArray alloc] initWithObjects:@"Mission 1", nil]];
        [objQuesModel setQuesPoints:[NSString stringWithFormat:@"50"]];
        
        [arrQuesModels addObject:objQuesModel];
    }
}

#pragma mark - Setup/Edit/Reset Question View

- (void)setupQuestionView {
    
    [self makeDefaultArrayOfModels];
    
    tblViewQuestionAccessory = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 256)];
    [tblViewQuestionAccessory setDelegate:self];
    [tblViewQuestionAccessory setDataSource:self];
    [txtFieldMissions setInputView:tblViewQuestionAccessory];
    
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addQuestionInArrayModel)];
    [self.navigationItem setRightBarButtonItem:barButtonAdd];
    
    [self setTitle:@"Questions"];
    [txtViewQuestion.layer setCornerRadius:4.0f];
    [txtViewAnswer.layer setCornerRadius:4.0f];
    [btnSave.layer setCornerRadius:4.0f];
}

- (void)clearQuestionView {
    
    modelCurrent = nil;
    for (UITextField *txtField in viewContent.subviews) {
        if ([txtField isKindOfClass:[UITextField class]]) {
            [txtField setText:@""];
            [txtField resignFirstResponder];
        }
    }
    for (UITextView *txtView in viewContent.subviews) {
        if ([txtView isKindOfClass:[UITextView class]]) {
            [txtView setText:@""];
            [txtView resignFirstResponder];
        }
    }
}

- (void)resetQuestionView {
    
    constraintViewContentToSuperview.constant = 15.0f;
    [viewContent setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.25f animations:^{
        [viewQuestion layoutIfNeeded];
    }];
}

- (void)addQuestionInArrayModel {
    
    if (!arrCurrentMissions)
        arrCurrentMissions = [[NSMutableArray alloc] init];
    
    [self setQuestionViewAlpha:1.0f];
}

- (void)setQuestionViewAlpha:(CGFloat)alpha {
    
    [self resetQuestionView];
    [self clearQuestionView];
    
    [UIView animateWithDuration:0.25
                     animations:^ {
                         [viewQuestion setAlpha:alpha];
                     }
                     completion:nil];
}

- (void)fillQuestionViewWithModel:(QuestionModel *)objQuesModel {
    
    [self setQuestionViewAlpha:1.0f];
    
    if (arrCurrentMissions) {
        [arrCurrentMissions removeAllObjects];
        arrCurrentMissions = nil;
    }
    
    modelCurrent = objQuesModel;
    
    arrCurrentMissions = [[NSMutableArray alloc] initWithArray:objQuesModel.quesArrMissions];
    
    [txtViewQuestion setText:objQuesModel.quesText];
    [txtViewAnswer setText:objQuesModel.quesAnswer];
    [txtFieldMissions setText:[arrCurrentMissions componentsJoinedByString:@", "]];
    [txtFieldPoints setText:objQuesModel.quesPoints];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - IBAction Buttons

- (IBAction)buttonCloseAction:(id)sender {
    
    [arrCurrentMissions removeAllObjects];
    arrCurrentMissions = nil;
    [self setQuestionViewAlpha:0.0f];
}

- (IBAction)buttonSaveQuestionAction:(id)sender {
    
    BOOL isEmpty = NO;
    for (UIView *theSubView in viewContent.subviews) {
        if ([theSubView isKindOfClass:[UITextField class]])
            isEmpty = ![[(UITextField *)theSubView text] length];
        else if ([theSubView isKindOfClass:[UITextView class]])
            isEmpty = ![[(UITextView *)theSubView text] length];
        
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
        
        NSMutableArray *arrMissions = [[NSMutableArray alloc] initWithArray:
                                       [txtFieldMissions.text componentsSeparatedByString:@", "]];
        
        QuestionModel *objNewModel = [[QuestionModel alloc] init];
        [objNewModel setQuesID:[NSString stringWithFormat:@"%d", [arrQuesModels count]]];
        [objNewModel setQuesText:txtViewQuestion.text];
        [objNewModel setQuesAnswer:txtViewAnswer.text];
        [objNewModel setQuesArrMissions:arrMissions];
        [objNewModel setQuesPoints:txtFieldPoints.text];
        
        NSPredicate *predicateQuesModel =[NSPredicate predicateWithFormat:@"quesID ==[c] %@", modelCurrent.quesID];
        NSArray *filt = [arrQuesModels filteredArrayUsingPredicate:predicateQuesModel];
        if ([filt count] > 0) {
            
            [arrQuesModels replaceObjectAtIndex:[arrQuesModels indexOfObject:modelCurrent]
                                     withObject:objNewModel];
        }
        else {
            [arrQuesModels addObject:objNewModel];
        }
        [tblViewQuestions reloadData];
        [self setQuestionViewAlpha:0.0f];
    }
}

#pragma mark - UITextField/UITextView Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField tag] == 1)
        [tblViewQuestionAccessory reloadData];
    
    constraintViewContentToSuperview.constant = textField.tag == 1 ? 15 : -80.0f;
    [viewContent setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.25f animations:^{
        [viewQuestion layoutIfNeeded];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    constraintViewContentToSuperview.constant = textView.tag == 1 ? 15 : -30.0f;
    [viewContent setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.25f animations:^{
        [viewQuestion layoutIfNeeded];
    }];
}

#pragma mark - UITableView Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView == tblViewQuestionAccessory ? 10 : [arrQuesModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cellForRow = nil;
    if (tableView != tblViewQuestionAccessory) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEQuesCellID];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                          reuseIdentifier:REUSEQuesCellID];
        
        UILabel *lblQuestion = (UILabel *)[cell viewWithTag:1];
        UILabel *lblAnswer = (UILabel *)[cell viewWithTag:2];
        UILabel *lblPoints = (UILabel *)[cell viewWithTag:3];
        
        QuestionModel *objQuesModel = (QuestionModel *)[arrQuesModels objectAtIndex:indexPath.row];
        [lblQuestion setText:objQuesModel.quesText];
        [lblAnswer setText:objQuesModel.quesAnswer];
        [lblPoints setText:objQuesModel.quesPoints];
        cellForRow = cell;
    }
    else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellQMiss"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"CellQMiss"];
        
        NSString *strToShow = [NSString stringWithFormat:@"Mission %d", indexPath.row + 1];
        [cell.textLabel setText:strToShow];
        NSInteger accessoryType = UITableViewCellAccessoryNone;
        if ([arrCurrentMissions containsObject:strToShow])
            accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setAccessoryType:accessoryType];
        cellForRow = cell;
    }
    
    return cellForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView != tblViewQuestionAccessory) {
        QuestionModel *objQuesModel = (QuestionModel *)[arrQuesModels objectAtIndex:indexPath.row];
        [self fillQuestionViewWithModel:objQuesModel];
    }
    else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *textCell = [[cell textLabel] text];
        
        if ([arrCurrentMissions containsObject:textCell]) {
            [arrCurrentMissions removeObject:textCell];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else {
            [arrCurrentMissions addObject:textCell];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        [txtFieldMissions setText:[arrCurrentMissions componentsJoinedByString:@", "]];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrQuesModels removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        //        [tableView reloadData];
    }
}

#pragma mark - Touch Method

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIView *viewTouched = [[touches anyObject] view];
    
    if (viewTouched == viewContent || viewTouched == viewQuestion) {
        for (UIView *sbView in viewTouched.subviews)
            if ([sbView isKindOfClass:[UITextField class]] ||
                [sbView isKindOfClass:[UITextView class]])
                [sbView resignFirstResponder];
        [self resetQuestionView];
    }
}


@end
