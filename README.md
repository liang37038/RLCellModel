# RLCellModel
An elegant way to create an infomation TableView

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
Here is THE CODE:

```
self.cellModelManager = [[RLCellModelManager alloc]
//Sometimes you just need one TableViewCell
//but you could override it with your specific RLCellModel
initWithGlobalCellIdentifier:NSStringFromClass([RLMineInfoTableViewCell class]) 
//Sometimes you just need one Cell Height, 
//but you could override it with your specific RLCellModel
globalHeight:[RLMineInfoTableViewCell cellHeight]
globalReuseCellBlock:^(RLMineInfoTableViewCell *cell, RLCellModel *cellModel) {

        //Do things you used to do in 
        //- (UITableViewCell *)tableView:(UITableView *)tableView
        //cellForRowAtIndexPath:(NSIndexPath *)indexPath;
        NSDictionary *cellDict = cellModel.cellGenerateRuleDict;
        NSString *title = [cellDict objectForKey:@"title"];
        NSNumber *cellType = [cellDict objectForKey:@"cellType"];
        cell.generalType = cellType.integerValue;
        cell.titleLabel.text = title;
    }
    customExtractCellModelBlock:^RLCellModel *(NSArray *cellModels, NSIndexPath *indexPath) {
        //Sometimes your TableView does not just have one section
        //(if you have one, just set this block to nil),
        //this Manager need to know how to extract cellModel from datasource
        //to do boring things for you
        return [[cellModels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }];
    
self.cellModelManager.delegate = self;
self.tableView.delegate = self.cellModelManager;
self.tableView.dataSource = self.cellModelManager;
```

Let's see how to implement a row

```
//One Model represent a single Cell
RLCellModel *avatar = [RLCellModel new];

//You can retrieve this Dict in RLCellModelManager's GlobalReuseCellBlock 
avatar.cellGenerateRuleDict = @{@"cellType":@(GeneralTypeAvatar),
                                    @"title":@"头像",};
//If you set this property, it will override the manager's global height (only this row)
avatar.cellHeight = @([RLMineInfoTableViewCell cellHeightWithExtra]);

avatar.cellSelectedBlock = ^{
    //This block will trigger When the cell selected        
};

avatar.refreshBlock = ^(id cell){
    //This block will override the manager's global reuseBlock (only this row)
};

//Continue to create other cellModels

NSMutableArray *datasource = [NSMutableArray arrayWithArray:@[@[avatar, userName, realName, code,gender, qrcode],@[phone, cardNumber, recommandPerson]]];
//Just give the datasource to manager, then reload
self.cellModelManager.cellModels = datasource;
[self.tableView reloadData];

```

Here is screenshot of example:
![](https://ww4.sinaimg.cn/large/006tNbRwgy1feq2pkyrgsj30ku12a0ui.jpg)


