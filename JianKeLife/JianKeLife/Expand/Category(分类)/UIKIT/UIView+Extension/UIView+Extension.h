 
#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic)CGFloat cornerRad;
@property(nonatomic)CGFloat Cy;
@property(nonatomic)CGFloat Cx;

@property(nonatomic,assign)CGFloat X;
@property(nonatomic,assign)CGFloat Y;
@property(nonatomic,assign)CGFloat Sh;
@property (nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat Sw;
/*!< 渐变属性*/
@property(nullable, copy) NSArray *colors;
@property(nullable, copy) NSArray<NSNumber *> *locations;
@property CGPoint startPoint;
@property CGPoint endPoint;
+ (UIView *_Nullable)gradientViewWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;    /*!< 渐变色view*/


-(void)setBlurStyle:(UIBlurEffectStyle)style;
-(void)removeBlur;

#pragma mark - Create Table for button
+(UIView *)CreateTableWithFrame:(CGRect )frame Number:(int)Number spacing:(CGFloat)spacing;

#pragma mark - TapAction LongPressAction
- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;

- (void)setCornerValue:(CGFloat)value;/*!< 圆角*/
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor*)color; /*!< 边框*/
/**
 *  添加圆角边框
 */
-(void)addBorderWithcornerRad:(CGFloat)cornerRad lineCollor:(UIColor *)collor lineWidth:(CGFloat)lineWidth;
/**
 *  加载
 */
-(void)startLoading;
-(void)stopLoding;

/**
 *  切某一方向的圆角
 */
-(void)viewCutRoundedOfRectCorner:(UIRectCorner)rectCorner cornerRadii:(CGFloat)cornerRadii;

/**
 *  获取view的所在控制器
 */
-(UIViewController*)MyViewController;

@end
