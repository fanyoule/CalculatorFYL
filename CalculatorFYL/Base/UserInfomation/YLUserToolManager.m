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
    }
    return @"";
}


@end
