# RLCellModel

**An elegant way to create an infomation TableView**

**INSTALL**

> Pod

```
pod 'RLCellModel', '~> 1.0.3'
```

##Why do you need this

In old days to create different function of rows in a TableView, you need to distinguish row function by **indexPath** , just like these:

```
if (indexPath.row == 1) {
        //do something
    }else if(indexPath.row == 2){
        //do something
    }
}
```

This can do , but when your product manager change some idea, remove or delete some rows, you will just became cracied about changing the old logic....

---

But with this **RLCellModelManager**, you can just 

* Use a model represent a row style and its function
* **DON'T NEED** to distinguish row by if/else 
* Easy way to ADD or DELETE or MOVE any items in TableView

---
###OK, Let's do this

**Here is THE CODE:**

> First of all, do some global setting

```
self.cellModelManager = [[RLCellModelManager alloc]
initWithGlobalCellIdentifier:NSStringFromClass([RLMineInfoTableViewCell class]) 
globalHeight:[RLMineInfoTableViewCell cellHeight]
globalReuseCellBlock:^(RLMineInfoTableViewCell *cell, RLCellModel *cellModel) {
        NSDictionary *cellDict = cellModel.cellGenerateRuleDict;
        NSString *title = [cellDict objectForKey:@"title"];
        NSNumber *cellType = [cellDict objectForKey:@"cellType"];
        cell.generalType = cellType.integerValue;
        cell.titleLabel.text = title;
    }
    customExtractCellModelBlock:^RLCellModel *(NSArray *cellModels, NSIndexPath *indexPath) {
        return [[cellModels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }];
    
self.cellModelManager.delegate = self;
self.tableView.delegate = self.cellModelManager;
self.tableView.dataSource = self.cellModelManager;
```

> Let's see how to implement a row

```
//One Model represent a single Cell
RLCellModel *avatar = [RLCellModel new];

avatar.cellGenerateRuleDict = @{@"cellType":@(GeneralTypeAvatar),
                                    @"title":@"头像",};

avatar.cellHeight = @([RLMineInfoTableViewCell cellHeightWithExtra]);

avatar.cellSelectedBlock = ^{
};

avatar.cellRefreshBlock = ^(id cell){
};

avatar.dynamicCellHeightBlock = ^(NSNumber *)(NSIndexPath *indexPath){
}

```
> Final step

```
NSMutableArray *datasource = [NSMutableArray arrayWithArray:@[
@[avatar, userName, realName, code,gender, qrcode],
@[phone, cardNumber, recommandPerson]]];

self.cellModelManager.cellModels = datasource;

[self.tableView reloadData];
```

**Here is screenshot of example:**
![](https://ww4.sinaimg.cn/large/006tNbRwgy1feq2pkyrgsj30ku12a0ui.jpg)


