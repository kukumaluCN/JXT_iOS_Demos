//
//  ViewController.m
//  JXTKit
//
//  Created by JXT on 2018/11/22.
//  Copyright © 2018 JXT. All rights reserved.
//

#import "ViewController.h"

#import "NSString+JXTAdd.h"

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UITextView * textView;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 50)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width-100, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入查找内容";
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = self;
    [bgView addSubview:textField];
    self.textField = textField;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification) name:UITextFieldTextDidChangeNotification object:nil];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(CGRectGetMaxX(textField.frame)+5, 0, bgView.bounds.size.width-CGRectGetMaxX(textField.frame)-5, 50);
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    searchButton.titleLabel.textColor = [UIColor whiteColor];
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchButton];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), self.view.bounds.size.width, self.view.bounds.size.height-20)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.editable = NO;
    [self.view addSubview:textView];
    self.textView = textView;

    
    NSString *text = @"\t燕子去了，有再来的时候；杨柳枯了，有再青的时候；桃花谢了，有再开的时候。但是，聪明的，你告诉我，我们的日子为什么一去不复返呢？——是有人偷了他们罢：那是谁？又藏在何处呢？是他们自己逃走了罢：现在又到了哪里呢？\n\t我不知道他们给了我多少日子；但我的手确乎是渐渐空虚了。在默默里算着，八千多日子已经从我手中溜去；像针尖上一滴水滴在大海里，我的日子滴在时间的流里，没有声音，也没有影子。我不禁头涔涔而泪潸潸了。\n\t去的尽管去了，来的尽管来着；去来的中间，又怎样地匆匆呢？早上我起来的时候，小屋里射进两三方斜斜的太阳。太阳他有脚啊，轻轻悄悄地挪移了；我也茫茫然跟着旋转。于是——洗手的时候，日子从水盆里过去；吃饭的时候，日子从饭碗里过去；默默时，便从凝然的双眼前过去。我觉察他去的匆匆了，伸出手遮挽时，他又从遮挽着的手边过去，天黑时，我躺在床上，他便伶伶俐俐地从我身上跨过，从我脚边飞去了。等我睁开眼和太阳再见，这算又溜走了一日。我掩着面叹息。但是新来的日子的影儿又开始在叹息里闪过了。\n\t在逃去如飞的日子里，在千门万户的世界里的我能做些什么呢？只有徘徊罢了，只有匆匆罢了；在八千多日的匆匆里，除徘徊外，又剩些什么呢？过去的日子如轻烟，被微风吹散了，如薄雾，被初阳蒸融了；我留着些什么痕迹呢？我何曾留着像游丝样的痕迹呢？我赤裸裸来到这世界，转眼间也将赤裸裸的回去罢？但不能平的，为什么偏要白白走这一遭啊？\n\t你聪明的，告诉我，我们的日子为什么一去不复返呢？";
    
    textView.attributedText = [self attributedStringWithText:text];
    
    NSLog(@"%zd - %@", text.length, text);
    
    for (NSString *str in [text componentsSeparatedByString:@"我"]) {
        NSLog(@"%zd - %@", str.length, str);
    }
    
    NSArray *ranges = [text jxt_rangeValuesOfString:@"我"];
    NSMutableString *t = [NSMutableString stringWithString:text];
    for (NSValue *rangeValue in ranges) {
        NSLog(@"%@:%@", rangeValue, [text substringWithRange:rangeValue.rangeValue]);
        [t replaceCharactersInRange:rangeValue.rangeValue withString:@"〇"];
    }
    NSLog(@"%@", t);
    
    NSLog(@"%d", [t containsString:@"我"]);
    
    
    [text jxt_enumerateStringBySentencesUsingBlock:^(NSString *substring, NSRange substringRange, BOOL *stop) {
        NSLog(@"%@ - %@", NSStringFromRange(substringRange), substring);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Methods
- (NSAttributedString *)attributedStringWithText:(NSString *)text
{
    return [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)highlightedSearchString:(NSString *)searchString
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textView.attributedText.string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
    NSArray *ranges = [attributedString.string jxt_rangeValuesOfString:searchString];
    NSLog(@"%f", CFAbsoluteTimeGetCurrent() - time);
    for (NSValue *rangeValue in ranges) {
        [attributedString addAttributes:@{
                                          NSForegroundColorAttributeName:[UIColor redColor],
                                          NSBackgroundColorAttributeName:[[UIColor blueColor] colorWithAlphaComponent:0.2],
                                          } range:rangeValue.rangeValue];
    }

    self.textView.attributedText = attributedString;
    self.textField.text = [NSString stringWithFormat:@"%@ - %zd", self.textField.text, ranges.count];
}



#pragma mark - Notification
- (void)textFieldTextDidChangeNotification
{
    [self highlightedSearchString:self.textField.text];
}


#pragma mark - Action
- (void)searchButtonAction:(UIButton *)sender
{
    [self.textField resignFirstResponder];
    [self highlightedSearchString:self.textField.text];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self highlightedSearchString:self.textField.text];
    return YES;
}

@end
