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
        
    }
    
    return @"";
}


@end
