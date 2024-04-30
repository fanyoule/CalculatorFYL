//
//  YLUserToolManager.m
//  yaoxinzjty
//
//  Created by 樊佑乐 on 2021/7/14.
//

#import "YLUserToolManager.h"
#import "YLNavigationViewController.h"



#define SearchTime 1
#define SearchDevicelocalTime 300
@interface YLUserToolManager()
//跑秒
@property(nonatomic,strong)dispatch_source_t timer;



@end
@implementation YLUserToolManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static YLUserToolManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YLUserToolManager alloc] init];
        
    });
    return instance;
}
+(BOOL)pushTologioVC{
    
    return NO;
    
}
+ (UIViewController *)lz_getCurrentViewController{
    UIViewController* currentViewController = [self lz_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}
+ (UIViewController *)lz_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    if ([window.rootViewController isKindOfClass:[YLTabBarViewController class]]) {
        YLTabBarViewController * tabbarVC = (YLTabBarViewController *)window.rootViewController;
        return tabbarVC.childViewControllers[tabbarVC.selectedIndex];
    }
    return window.rootViewController;

}
+(UIColor *)getAppMainColor{
    NSString * color_str = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_MainAppColor];
    if (IS_VALID_STRING(color_str)) {
        UIColor * curretColor = [UIColor jk_colorWithHexString:color_str];
        return curretColor;
    }
    return UIColor.greenColor;
}
+(UIFont *)getAppTitleFont{
    NSString * title_font = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_TitleFont];
    if (IS_VALID_STRING(title_font)) {
        UIFont * font = [UIFont boldSystemFontOfSize:title_font.intValue];
        return font;
    }
    return [UIFont boldSystemFontOfSize:20];
}
/**
 * 0 插入备注
 * 1备注
 * 2完成
 * 3存档
 * 4清空
 * 5保存当前记录
 * 6打开本地存档
 * 7取消
 * 8确定
 * 9设置
 * 10恢复
 * 11删除
 * 12升级VIP(无广告+语音报数)
 * 13音效
 * 14主题
 * 15触感
 * 16键盘
 * 17字体大小
 * 18小数位数
 * 19千分位 9,999
 * 20日期
 * 21量级
 * 22语言
 * 23回收站
 * 24帮助反馈
 * 25分享
 * 26赏个好评吧
 * 27购买
 * 28恢复
 * 29无
 * 30默认
 * 31水滴
 * 32清脆
 * 33鼓声
 * 34木质
 * 35钢琴
 * 36真人语音
 * 37中文
 * 38英文
 * 39我的反馈
 * 40请留下您宝贵的意见或反馈，我们会及时的回复您
 * 41您的联系方式
 */
+(NSString *)getTextTag:(NSInteger)tag{
    NSString * local_languageType = [[NSUserDefaults standardUserDefaults]objectForKey:@"languageType"];
    if (tag == 0) {//插入备注
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Insert note", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"插入备注";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"插入備註";
        }else if (local_languageType.intValue == 3){//English
            return @"Insert note";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"コメントの挿入";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"추가 정보 삽입";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Вставить примечание";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Inserisci nota";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Insérer une remarque";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Notiz einfügen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"إدراج ملاحظة";
        }else if (local_languageType.intValue == 11){//波兰语 Polski 
            return @"Wstaw notatkę";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Indsæt note";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Lisää huomautus";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Notitie invoegen";
        }
        
    }else if (tag == 1){//备注
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Remarks", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"备注";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"備註";
        }else if (local_languageType.intValue == 3){//English
            return @"Remarks";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"コメント";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"코멘트";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Замечания";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Osservazioni";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Commentaires";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Bemerkungen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"ملاحظات";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Uwagi";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Bemærkninger";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Huomautuksia";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Opmerkingen";
        }
        
        
    }else if (tag == 2){//完成
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Done", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"完成";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"完成";
        }else if (local_languageType.intValue == 3){//English
            return @"Done";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"ドーン";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"도른";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Дорн.";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Fatto";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Dorn";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Fertig";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"دون";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Gotowe";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Udfærdiget";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Tehty";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Gereed";
        }
        
    }else if (tag == 3){//存档
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"On file", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"存档";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"存檔";
        }else if (local_languageType.intValue == 3){//English
            return @"On file";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"アーカイブ";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"아카이빙";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Архив";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"In archivio";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Archive";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"In der Datei";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"الأرشيف";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"W aktach";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"På fil";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Asiakirjassa";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"In bestand";
        }
        
    }else if (tag == 4){//清空
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Clear", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"清空";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"清空";
        }else if (local_languageType.intValue == 3){//English
            return @"Clear";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"はっきりした";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"명확했어";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Очистить";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Cancella";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Clairement";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Löschen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"واضح";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Wyczyść";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Ryd";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Tyhjennä";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Clear";
        }
        
    }else if (tag == 5){//保存当前记录
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Save current record", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"保存当前记录";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"保存當前記錄";
        }else if (local_languageType.intValue == 3){//English
            return @"Save current record";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"現在のレコードを保存";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"현재 레코드 저장";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Сохранить текущую запись";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Salva record corrente";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Conserver l'enregistrement actuel";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Aktueller Datensatz speichern";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"حفظ السجل الحالي";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Zapisz bieżący rekord";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Gem nuværende post";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Tallenna nykyinen tietue";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Huidige record opslaan";
        }
        
    }else if (tag == 6){//打开本地存档
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Open local archive", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"打开本地存档";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"打開本地存檔";
        }else if (local_languageType.intValue == 3){//English
            return @"Open local archive";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"ローカルアーカイブを開く";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"로컬 아카이브 열기";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Открыть локальный архив";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Apri archivio locale";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Ouvrir une archive locale";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Lokales Archiv öffnen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"فتح الأرشيف المحلي";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Otwórz lokalne archiwum";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Åbn lokalt arkiv";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Avaa paikallinen arkisto";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Lokaal archief openen";
        }
        
    }else if (tag == 7){//取消
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Cancel", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"取消";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"取消";
        }else if (local_languageType.intValue == 3){//English
            return @"Cancel";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"キャンセル";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"취소";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Отменить";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Annulla";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Annulation";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Abbrechen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"ألغى";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Anuluj";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Annullér";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Peruuta";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Annuleren";
        }
        
    }else if (tag == 8){//确定
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Make sure", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"确定";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"確定";
        }else if (local_languageType.intValue == 3){//English
            return @"Make sure";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"確実に";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"확보";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Обеспечить";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Assicurati che";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Assurez - vous";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Stellen Sie sicher";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"أكّد";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Upewnij się, że";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Sørg for";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Varmista, että";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Zorg ervoor";
        }
        
    }else if (tag == 9){//设置
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Settings", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"设置";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"設定";
        }else if (local_languageType.intValue == 3){//English
            return @"Settings";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"設定＃セッテイ＃";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"설치";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Настройка";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Impostazioni";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Paramètres";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Einstellungen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"ضبط";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Ustawienia";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Indstillinger";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Asetukset";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Instellingen";
        }
        
    }else if (tag == 10){//恢复
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"recovery", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"恢复";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"恢復";
        }else if (local_languageType.intValue == 3){//English
            return @"recovery";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"リカバリ";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"복구";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Восстановление";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"recupero";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Récupération";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Rückgewinnung";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"استعاد";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"odzyskiwanie";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"inddrivelse";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"hyödyntäminen";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"terugwinning";
        }
    }else if (tag == 11){//删除
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"delete", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"删除";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"删去";
        }else if (local_languageType.intValue == 3){//English
            return @"delete";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"削除";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"삭제";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Исключить";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"elimina";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Supprimer";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"löschen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"حذف";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"usunąć";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"slet";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Poista";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"verwijderen";
        }
    }else if (tag == 12){//升级VIP
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Upgrade VIP", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"升级VIP(无广告+语音报数)";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"陞級VIP";
        }else if (local_languageType.intValue == 3){//English
            return @"Upgrade VIP";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"VIPのアップグレード";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"VIP 승급";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Обновление VIP";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Aggiorna VIP";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Mise à niveau VIP";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"VIP upgraden";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"ترقية كبار الشخصيات";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Aktualizacja VIP";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Opgrader VIP";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Päivitä VIP";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"VIP upgraden";
        }
    }else if (tag == 13){//音效
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Sound", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"音效";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"聲音";
        }else if (local_languageType.intValue == 3){//English
            return @"Sound";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"サウンド";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"소리";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Голос";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Suono";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"La voix";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Ton";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"صوت .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Dźwięk";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Lyd";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Ääni";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Geluid";
        }
    }else if (tag == 14){//主题
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Theme", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"主题";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"主題";
        }else if (local_languageType.intValue == 3){//English
            return @"Theme";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"トピック＃トピック＃";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"주제";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Тема";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Tema";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Thèmes";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Thema";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"موضوع .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Motyw";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Tema";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Teema";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Thema";
        }
    }else if (tag == 15){//振动
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Vibrate", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"振动";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"振動";
        }else if (local_languageType.intValue == 3){//English
            return @"Vibrate";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"しんどう";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"진동";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Вибрация";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Vibra";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Vibrations";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Vibration";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"اهتزازي";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Wibracja";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Vibrerer";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Tärinää";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Tribbelen";
        }
    }else if (tag == 16){//键盘
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Keyboard", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"键盘";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"鍵盤";
        }else if (local_languageType.intValue == 3){//English
            return @"Keyboard";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"キーボード";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"키보드";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Клавиатура";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Tastiera";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Clavier";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Tastatur";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"لوحة المفاتيح .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Klawiatura";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Tastatur";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Näppäimistö";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Toetsenbord";
        }
    }else if (tag == 17){//字体大小
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Font Size", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"字体大小";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"字體大小";
        }else if (local_languageType.intValue == 3){//English
            return @"Font Size";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"フォントサイズ";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"글꼴 크기";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Размер шрифта";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Dimensione carattere";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Taille de la police";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Schriftgröße";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"حجم الخط";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Rozmiar czcionki";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Skriftstørrelse";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Kirjasikoko";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Lettertypegrootte";
        }
    }else if (tag == 18){//小数位数
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Decimal Places", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"小数位数";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"小數位";
        }else if (local_languageType.intValue == 3){//English
            return @"Decimal Places";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"小数点以下のビット";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"소수점";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Десятичный разряд";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Posti decimali";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Petit nombre";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Dezimalstellen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"عشري";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Miejsca dziesiętne";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Decimalsteder";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Desimaalipaikat";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Decimale plaatsen";
        }
    }else if (tag == 19){//千分位 9,999
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Thousands 9,999", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"千分位 9,999";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"千 9,999";
        }else if (local_languageType.intValue == 3){//English
            return @"Thousands 9,999";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"千 9,999";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"천9999";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"В тыс. 9999";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Migliaia 9.999";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Milliers 9999";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Tausende 9.999";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"9,999 ألف";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Tysiące 9,999";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Tusindvis 9.999";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Tuhannet 9 999";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Duizenden 9,999";
        }
    }else if (tag == 20){//日期
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Date", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"日期";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"日期";
        }else if (local_languageType.intValue == 3){//English
            return @"Date";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"日付";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"날짜";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Дата";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Data";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Date";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Datum";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"تواريخ";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Data";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Dato";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Päivämäärä";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Datum";
        }
    }else if (tag == 21){//量级
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Order", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"量级";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"量级";
        }else if (local_languageType.intValue == 3){//English
            return @"Order";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"じゅんじょ";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"순서";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Последовательность";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Ordine";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Order";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Reihenfolge";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"متتابعة";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Kolejność";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Rækkefølge";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Järjestys";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Orde";
        }
    }else if (tag == 22){//语言
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Language", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"语言";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"語言";
        }else if (local_languageType.intValue == 3){//English
            return @"Language";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"言語";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"언어";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Язык";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Lingua";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Langue";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Sprache";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"لغة";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Język";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Sprog";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Kieli";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Taal";
        }
    }else if (tag == 23){//回收站
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Recycle", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"回收站";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"回收利用";
        }else if (local_languageType.intValue == 3){//English
            return @"Recycle";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"リサイクル";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"재활용";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Рекуперация";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Ricicla";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Recyclage";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Recycling";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"إعادة التدوير";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Recykling";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Genbrug";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Kierrätä";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Recyclen";
        }
    }else if (tag == 24){//帮助反馈
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Feedback", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"帮助反馈";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"反饋";
        }else if (local_languageType.intValue == 3){//English
            return @"Feedback";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"フィードバック";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"피드백";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Обратная связь";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Feedback";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Feedback";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Feedback";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"تغذية مرتدة";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Informacje zwrotne";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Feedback";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Palaute";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Feedback";
        }
    }else if (tag == 25){//分享
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Share", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"分享";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"共有";
        }else if (local_languageType.intValue == 3){//English
            return @"Share";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"共有＃キョウユウ＃";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"공유";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Совокупность";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Condividi";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Au total";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Anteil";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"مشترك";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Udział";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Del";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Osuus";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Aandelen";
        }
    }else if (tag == 26){//赏个好评吧
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Rate", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"赏个好评吧";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"好評";
        }else if (local_languageType.intValue == 3){//English
            return @"Rate";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"スピード＃";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"속도";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Скорость";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Tasso";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Vitesse";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Rate";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"سرعة .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Stawka";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Rate";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Rate";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Tarief";
        }
    }else if (tag == 27){//购买
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Purchase", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"购买";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"購買";
        }else if (local_languageType.intValue == 3){//English
            return @"Purchase";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"購入する";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"속도";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"구매";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Acquisto";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Acheter";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Kauf";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"شراء";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Zakup";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Køb";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Osto";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Aankoop";
        }
    }else if (tag == 28){//恢复
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Restore", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"恢复购买";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"恢复购买";
        }else if (local_languageType.intValue == 3){//English
            return @"Restore";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"リカバリ";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"복구";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Восстановление";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Ripristina";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Récupération";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Wiederherstellen";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"استعاد";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Przywróć";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Gendan";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Palauta";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Herstellen";
        }
    }else if (tag == 29){//无
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"None", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"无";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"無";
        }else if (local_languageType.intValue == 3){//English
            return @"None";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"一つもない";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"하나도 없다";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Ни одного.";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Nessuno";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Pas un seul";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Keine";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"لا أحد";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Żadnych";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Ingen";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Ei mitään";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Geen";
        }
    }else if (tag == 30){//默认
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Default", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"默认";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"默認";
        }else if (local_languageType.intValue == 3){//English
            return @"Default";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"約束を破る";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"위약";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Нарушение обязательств";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Predefinito";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Violation";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Standard";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"خرق";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Domyślne";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Standard";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Oletus";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Standaard";
        }
    }else if (tag == 31){//水滴
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Water", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"水滴";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"水滴";
        }else if (local_languageType.intValue == 3){//English
            return @"Water";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"水";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"물";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Вода";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Acqua";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Eau";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Wasser";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"ماء .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Woda";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Vand";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Vesi";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Water";
        }
    }else if (tag == 32){//清脆
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Crisp", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"清脆";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"清脆";
        }else if (local_languageType.intValue == 3){//English
            return @"Crisp";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"カリカリした";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"바삭바삭하다";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Хрустящий";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Crisp";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Croustillant";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Knackig";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"هش";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Chrupiące";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Sprød";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Rapea";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Crisp";
        }
    }else if (tag == 33){//鼓声
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Drum", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"鼓声";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"鼓聲";
        }else if (local_languageType.intValue == 3){//English
            return @"Drum";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"ドラム";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"북";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Б";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Tamburo";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Tambours";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Trommel";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"براميل";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Bęben";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Tromme";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Rumpu";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Trommel";
        }
    }else if (tag == 34){//木质
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Wood", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"木质";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"木質";
        }else if (local_languageType.intValue == 3){//English
            return @"Wood";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"もくざい";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"목재";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Лесоматериалы";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Legno";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Bois";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Holz";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"الخشب .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Drewno";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Træ";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Puu";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Hout";
        }
    }else if (tag == 35){//钢琴
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Piano", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"钢琴";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"鋼琴";
        }else if (local_languageType.intValue == 3){//English
            return @"Piano";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"ピアノ";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"피아노";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Пианино";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Piano";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Piano";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Klavier";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"بيانو .";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Fortepian";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Klaver";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Piano";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Piano";
        }
    }else if (tag == 36){//真人语音
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Voice", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"真人语音";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"真人語音";
        }else if (local_languageType.intValue == 3){//English
            return @"Voice";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"声";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"목소리";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Голос";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Voce";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"La voix";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Stimme";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"صوت";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Głos";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Stemme";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Ääni";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Stem";
        }
    }else if (tag == 37){//中文
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Chinese", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"中文";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"中文";
        }else if (local_languageType.intValue == 3){//English
            return @"Chinese";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"中国人";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"중국인";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Китайцы";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Cinese";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Chinois";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Chinesisch";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"الصينية";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Chiński";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Kinesisk";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Kiinalainen";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Chinees";
        }
    }else if (tag == 38){//英文
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"English", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"英文";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"英文";
        }else if (local_languageType.intValue == 3){//English
            return @"English";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"英語";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"영어";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Английский язык";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Inglese";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Anglais";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Englisch";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"إنجليزي";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Angielski";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Engelsk";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Englanti";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Engels";
        }
    }else if (tag == 39){//我的反馈
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"My feedback", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"我的反馈";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"我的迴響";
        }else if (local_languageType.intValue == 3){//English
            return @"My feedback";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"私のフィードバック";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"내 피드백";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Мои отзывы.";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Il mio feedback";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Mon feedback";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Mein Feedback";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"ملاحظاتي";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Moja opinia";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Min feedback";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Palautteeni";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Mijn feedback";
        }
    }else if (tag == 40){//请留下您宝贵的意见或反馈，我们会及时的回复您
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Please leave your valuable comments,we will reply you in time", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"请留下您宝贵的意见或反馈，我们会及时的回复您";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"請留下您寶貴的意見或迴響，我們會及時的回復您";
        }else if (local_languageType.intValue == 3){//English
            return @"Please leave your valuable comments,we will reply you in time";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"貴重なご意見を残していただければ、すぐにご返事いたします";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"당신의 귀중한 의견을 남겨 주십시오. 우리는 즉시 당신에게 회답할 것입니다";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Оставьте свои ценные замечания, и мы ответим вам вовремя.";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Si prega di lasciare i vostri preziosi commenti, vi risponderemo in tempo";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Laissez - nous vos précieux commentaires, nous vous répondrons rapidement";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Bitte hinterlassen Sie Ihre wertvollen Kommentare, wir werden Ihnen rechtzeitig antworten";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"يرجى ترك التعليقات القيمة الخاصة بك ، ونحن سوف الرد عليك في الوقت المناسب";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Zostaw swoje cenne komentarze, odpowiemy na czas";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Venligst efterlad dine værdifulde kommentarer, vi vil svare dig i tide";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Jätä arvokkaat kommentit, me vastaamme sinulle ajoissa";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Laat uw waardevolle opmerkingen achter, wij zullen u op tijd antwoorden";
        }
    }else if (tag == 41){//您的联系方式
        if (local_languageType.intValue == 0) {//跟随系统
            return NSLocalizedString(@"Your contact information or Email", nil);
        }else if (local_languageType.intValue == 1){//简体中文
            return @"您的聯繫方式";
        }else if (local_languageType.intValue == 2){//繁体中文
            return @"請留下您寶貴的意見或迴響，我們會及時的回復您";
        }else if (local_languageType.intValue == 3){//English
            return @"Your contact information or Email";
        }else if (local_languageType.intValue == 4){//日语  日本語
            return @"お問い合わせ情報またはEメール";
        }else if (local_languageType.intValue == 5){//韩语 한국어
            return @"연락처 정보 또는 이메일";
        }else if (local_languageType.intValue == 6){//俄语 Русский
            return @"Ваша контактная информация или электронная почта";
        }else if (local_languageType.intValue == 7){//意大利语 Italiano
            return @"Le tue informazioni di contatto o email";
        }else if (local_languageType.intValue == 8){//法语 Français
            return @"Vos coordonnées ou votre courriel";
        }else if (local_languageType.intValue == 9){//德语 Deutsch
            return @"Ihre Kontaktdaten oder E-Mail";
        }else if (local_languageType.intValue == 10){//阿拉伯语 العربية
            return @"معلومات الاتصال الخاصة بك أو البريد الإلكتروني";
        }else if (local_languageType.intValue == 11){//波兰语 Polski
            return @"Twoje dane kontaktowe lub e-mail";
        }else if (local_languageType.intValue == 12){//丹麦语 Dansk
            return @"Dine kontaktoplysninger eller e-mail";
        }else if (local_languageType.intValue == 13){//芬兰语 Suomi
            return @"Yhteystiedot tai sähköposti";
        }else if (local_languageType.intValue == 14){//荷兰语 Nederlands
            return @"Uw contactgegevens of e-mail";
        }
    }
   return @"";
}


@end
