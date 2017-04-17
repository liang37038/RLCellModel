//
//  RLMineInfoTableViewCell.m
//  RLCellModelProject
//
//  Created by Richard Liang on 2017/3/2.
//
//

#import "RLMineInfoTableViewCell.h"

@interface RLMineInfoTableViewCell()



@end

@implementation RLMineInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 32.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setGeneralType:(GeneralType)generalType{
    _generalType = generalType;
    self.avatarImageView.hidden = YES;
    self.defaultLabel.hidden = YES;
    self.qrCodeImageView.hidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    switch (generalType) {
        case GeneralTypeNormal:{
            self.defaultLabel.hidden = NO;
            break;
        }
        case GeneralTypeAvatar:{
            self.avatarImageView.hidden = NO;
            break;
        }
        case GeneralTypeQRCode:{
            self.defaultLabel.hidden = YES;
            self.qrCodeImageView.hidden = NO;
            break;
        }
    }
}

+ (CGFloat)cellHeight{
    return 54;
}

+ (CGFloat)cellHeightWithExtra{
    return 105;
}


@end
