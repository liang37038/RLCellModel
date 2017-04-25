//
//  ViewController.m
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/1/7.
//  Copyright © 2017年 lwj. All rights reserved.
//

#import "ViewController.h"
#import "RLMineInfoTableViewCell.h"
#import "RLCellModelManager.h"

@interface ViewController ()<RLCellModelManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) RLCellModelManager *cellModelManager;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupCellModels];
}

- (void)setupNavigationBar{
    self.title = @"个人信息";
}

- (void)setupTableView{
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RLMineInfoTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RLMineInfoTableViewCell class])];
    
    self.cellModelManager = [[RLCellModelManager alloc]initWithGlobalCellIdentifier:NSStringFromClass([RLMineInfoTableViewCell class]) globalHeight:[RLMineInfoTableViewCell cellHeight] globalReuseCellBlock:^(RLMineInfoTableViewCell *cell, RLCellModel *cellModel) {
        NSDictionary *cellDict = cellModel.cellGenerateRuleDict;
        NSString *title = [cellDict objectForKey:@"title"];
        NSNumber *cellType = [cellDict objectForKey:@"cellType"];
        cell.generalType = cellType.integerValue;
        cell.titleLabel.text = title;
        
    } customExtractCellModelBlock:^RLCellModel *(NSArray *cellModels, NSIndexPath *indexPath) {
        return [[cellModels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }];
    
    self.cellModelManager.delegate = self;
    self.tableView.delegate = self.cellModelManager;
    self.tableView.dataSource = self.cellModelManager;
    self.tableView.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCellModels{
    RLCellModel *avatar = [RLCellModel new];
    avatar.cellGenerateRuleDict = @{@"cellType":@(GeneralTypeAvatar),
                                    @"title":@"头像",};
    avatar.dynamicCellHeightBlock = ^NSNumber *(NSIndexPath *indexPath) {
        return @(200);
    };
    avatar.cellHeight = [RLMineInfoTableViewCell cellHeightWithExtra];
    avatar.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *userName = [RLCellModel new];
    userName.cellGenerateRuleDict = @{@"title":@"用户名"};
    userName.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *realName = [RLCellModel new];
    realName.cellGenerateRuleDict = @{@"title":@"姓名"};
    realName.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *code = [RLCellModel new];
    code.cellGenerateRuleDict = @{@"title":@"编码"};
    code.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *gender = [RLCellModel new];
    gender.cellGenerateRuleDict = @{@"title":@"性别"};
    gender.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *qrcode = [RLCellModel new];
    qrcode.cellGenerateRuleDict = @{@"cellType":@(GeneralTypeQRCode),@"title":@"我的二维码"};
    qrcode.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *phone = [RLCellModel new];
    phone.cellGenerateRuleDict = @{@"title":@"手机号"};
    phone.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *cardNumber = [RLCellModel new];
    cardNumber.cellGenerateRuleDict = @{@"title":@"证件号"};
    cardNumber.cellSelectedBlock = ^{
        
    };
    
    RLCellModel *recommandPerson = [RLCellModel new];
    recommandPerson.cellGenerateRuleDict = @{@"title":@"推荐人"};
    recommandPerson.cellSelectedBlock = ^{
        
    };
    
    NSMutableArray *datasource = [NSMutableArray arrayWithArray:@[@[avatar, userName, realName, code,gender, qrcode],@[phone, cardNumber, recommandPerson]]];
    self.cellModelManager.cellModels = datasource;
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView rl_viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 9)];
    footerView.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView rl_heightForFooterInSection:(NSInteger)section{
    return 9;
}


@end
