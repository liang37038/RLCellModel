//
//  RLMineInfoTableViewCell.h
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/3/2.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GeneralType) {
    GeneralTypeNormal = 0,
    GeneralTypeAvatar,
    GeneralTypeQRCode
};
typedef void(^SwitchBlock)(BOOL isOn);

@interface RLMineInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@property (assign, nonatomic) GeneralType generalType;

@property (copy, nonatomic) SwitchBlock switchBlock;


+ (CGFloat)cellHeight;
+ (CGFloat)cellHeightWithExtra;

@end
