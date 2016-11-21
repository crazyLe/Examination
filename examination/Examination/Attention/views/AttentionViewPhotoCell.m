//
//  AttentionViewPhotoCell.m
//  Examination
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AttentionViewPhotoCell.h"

#define  HorizontalCount 8

@implementation AttentionViewPhotoCell

- (void)awakeFromNib {
    // Initialization code
    self.chatData = [NSMutableArray arrayWithCapacity:7];
    for(int i=0;i<HorizontalCount;i++) {
        _chatData[i] = [NSNumber numberWithFloat: (float)i/30.0 + (float)(rand() % 100) / 500.0f];
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
    
    NSArray* months = @[@"8", @"10", @"12", @"14", @"16", @"18", @"20",@"22"];
    
    // Setting up the line chart
    _chartView.verticalGridStep = 6;
    _chartView.horizontalGridStep = HorizontalCount;
    _chartView.indexLabelFont = [UIFont systemFontOfSize:15];
    _chartView.valueLabelFont = [UIFont systemFontOfSize:15];
    _chartView.fillColor = [UIColor colorWithHexString:@"ffecd6"];
    _chartView.displayDataPoint = YES;
    _chartView.dataPointColor = [UIColor colorWithHexString:@"fe9a33"];
    _chartView.dataPointBackgroundColor = [UIColor colorWithHexString:@"fe9a33"];;
    _chartView.dataPointRadius = 2;
    _chartView.color = [_chartView.dataPointColor colorWithAlphaComponent:0.3];
    _chartView.valueLabelPosition = ValueLabelLeftMirrored;
    _chartView.valueLabelPosition = ValueLabelLeft;
    _chartView.labelForIndex = ^(NSUInteger item) {
        return months[item];
    };
    
    _chartView.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.02f", value];
    };
    
    [_chartView setChartData:_chatData];

}

@end
