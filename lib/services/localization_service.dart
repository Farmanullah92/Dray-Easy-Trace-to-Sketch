import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("fr", LocaleData.FR),
  MapLocale("pt", LocaleData.PT),
  MapLocale("de", LocaleData.DE),
  MapLocale("ko", LocaleData.KO),
  MapLocale("ja", LocaleData.JA),
  MapLocale("es", LocaleData.ES),
  MapLocale("vi", LocaleData.VI),
];

mixin LocaleData {
  static const String splashTitle = 'splashTitle';
  static const String splashSubtitle = 'splashSubtitle';
  static const String onboardingTitle1 = 'onboardingTitle1';
  static const String onboardingSubtitle1 = 'onboardingSubtitle1';
  static const String onboardingTitle2 = 'onboardingTitle2';
  static const String onboardingSubtitle2 = 'onboardingSubtitle2';
  static const String skip = 'skip';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String finish = 'finish';
  static const String selectLanguage = 'selectLanguage';
  static const String subscription = 'subscription';
  static const String rateThisApp = 'rateThisApp';
  static const String shareApp = 'shareApp';
  static const String privacyPolicy = 'privacyPolicy';
  static const String licenseAndCredits = 'licenseAndCredits';
  static const String checkAndUpdate = 'checkAndUpdate';
  static const String done = 'done';
  static const String drawEasyTraceToSketch = 'drawEasyTraceToSketch';

  static const Map<String, dynamic> EN = {
    splashTitle: 'Draw Easy',
    splashSubtitle: 'Trace to Sketch',
    onboardingTitle1: 'CAPTURE & DETECT',
    onboardingSubtitle1: 'Detect edges in any photo to sketch.',
    onboardingTitle2: 'DRAW',
    onboardingSubtitle2:
        'You can easily trace a photo on paper using a tripod or glass.',
    skip: 'Skip',
    next: 'Next',
    previous: 'Previous',
    finish: 'Finish',
    selectLanguage: 'Select Language',
    subscription: 'Subscription',
    rateThisApp: 'Rate this App',
    shareApp: 'Share App',
    privacyPolicy: 'Privacy Policy',
    licenseAndCredits: 'License & Credits',
    checkAndUpdate: 'Check & Update',
    done: 'Done',
    drawEasyTraceToSketch: 'Draw Easy: Trace to Sketch',
  };

  static const Map<String, dynamic> FR = {
    splashTitle: 'Dessiner Facile',
    splashSubtitle: 'Tracer en Croquis',
    onboardingTitle1: 'CAPTURER & DÉTECTER',
    onboardingSubtitle1:
        'Détectez les contours d\'une photo pour en faire un croquis.',
    onboardingTitle2: 'DESSINER',
    onboardingSubtitle2:
        'Tracez facilement une photo sur papier à l\'aide d\'un trépied ou d\'une vitre.',
    skip: 'Passer',
    next: 'Suivant',
    previous: 'Précédent',
    finish: 'Terminer',
    selectLanguage: 'Choisir la langue',
    subscription: 'Abonnement',
    rateThisApp: 'Noter cette application',
    shareApp: 'Partager l\'application',
    privacyPolicy: 'Politique de confidentialité',
    licenseAndCredits: 'Licence et crédits',
    checkAndUpdate: 'Vérifier & Mettre à jour',
    done: 'Terminé',
    drawEasyTraceToSketch: 'Dessiner Facile: Tracer en Croquis',
  };

  static const Map<String, dynamic> PT = {
    splashTitle: 'Desenhar Fácil',
    splashSubtitle: 'Trace para Esboço',
    onboardingTitle1: 'CAPTURAR & DETECTAR',
    onboardingSubtitle1: 'Detecte bordas em qualquer foto para esboçar.',
    onboardingTitle2: 'DESENHAR',
    onboardingSubtitle2:
        'Você pode facilmente traçar uma foto no papel usando um tripé ou vidro.',
    skip: 'Pular',
    next: 'Próximo',
    previous: 'Anterior',
    finish: 'Concluir',
    selectLanguage: 'Selecionar Idioma',
    subscription: 'Assinatura',
    rateThisApp: 'Avaliar App',
    shareApp: 'Compartilhar App',
    privacyPolicy: 'Política de Privacidade',
    licenseAndCredits: 'Licença e Créditos',
    checkAndUpdate: 'Verificar & Atualizar',
    done: 'Concluído',
    drawEasyTraceToSketch: 'Desenhar Fácil: Trace para Esboço',
  };

  static const Map<String, dynamic> DE = {
    splashTitle: 'Einfach Zeichnen',
    splashSubtitle: 'Nachzeichnen zu Skizze',
    onboardingTitle1: 'ERFASSEN & ERKENNEN',
    onboardingSubtitle1:
        'Erkenne Kanten in jedem Foto, um eine Skizze zu erstellen.',
    onboardingTitle2: 'ZEICHNEN',
    onboardingSubtitle2:
        'Zeichne einfach ein Foto auf Papier mit einem Stativ oder Glas nach.',
    skip: 'Überspringen',
    next: 'Weiter',
    previous: 'Zurück',
    finish: 'Fertig',
    selectLanguage: 'Sprache wählen',
    subscription: 'Abonnement',
    rateThisApp: 'App bewerten',
    shareApp: 'App teilen',
    privacyPolicy: 'Datenschutz-Bestimmungen',
    licenseAndCredits: 'Lizenz & Credits',
    checkAndUpdate: 'Prüfen & Aktualisieren',
    done: 'Fertig',
    drawEasyTraceToSketch: 'Einfach Zeichnen: Nachzeichnen zu Skizze',
  };

  static const Map<String, dynamic> KO = {
    splashTitle: '쉽게 그리기',
    splashSubtitle: '스케치 따라 그리기',
    onboardingTitle1: '캡처 및 감지',
    onboardingSubtitle1: '사진의 윤곽선을 감지하여 스케치로 만듭니다.',
    onboardingTitle2: '그리기',
    onboardingSubtitle2: '삼각대나 유리를 사용하여 사진을 종이에 쉽게 따라 그릴 수 있습니다.',
    skip: '건너뛰기',
    next: '다음',
    previous: '이전',
    finish: '완료',
    selectLanguage: '언어 선택',
    subscription: '구독',
    rateThisApp: '앱 평가',
    shareApp: '앱 공유',
    privacyPolicy: '개인정보 보호정책',
    licenseAndCredits: '라이선스 및 크레딧',
    checkAndUpdate: '확인 및 업데이트',
    done: '완료',
    drawEasyTraceToSketch: '쉽게 그리기: 스케치 따라 그리기',
  };

  static const Map<String, dynamic> JA = {
    splashTitle: '簡単に描く',
    splashSubtitle: 'スケッチにトレース',
    onboardingTitle1: 'キャプチャ＆検出',
    onboardingSubtitle1: '写真のエッジを検出してスケッチします。',
    onboardingTitle2: '描く',
    onboardingSubtitle2: '三脚やガラスを使って紙に写真を簡単にトレースできます。',
    skip: 'スキップ',
    next: '次へ',
    previous: '前へ',
    finish: '完了',
    selectLanguage: '言語を選択',
    subscription: '購読',
    rateThisApp: 'アプリを評価',
    shareApp: 'アプリを共有',
    privacyPolicy: 'プライバシーポリシー',
    licenseAndCredits: 'ライセンスとクレジット',
    checkAndUpdate: '確認と更新',
    done: '完了',
    drawEasyTraceToSketch: '簡単に描く: スケッチにトレース',
  };

  static const Map<String, dynamic> ES = {
    splashTitle: 'Dibuja Fácil',
    splashSubtitle: 'Traza para Boceto',
    onboardingTitle1: 'CAPTURAR Y DETECTAR',
    onboardingSubtitle1:
        'Detecta bordes en cualquier foto para convertirla en un boceto.',
    onboardingTitle2: 'DIBUJAR',
    onboardingSubtitle2:
        'Puedes trazar fácilmente una foto en papel usando un trípode o vidrio.',
    skip: 'Saltar',
    next: 'Siguiente',
    previous: 'Anterior',
    finish: 'Finalizar',
    selectLanguage: 'Seleccionar idioma',
    subscription: 'Suscripción',
    rateThisApp: 'Calificar esta app',
    shareApp: 'Compartir app',
    privacyPolicy: 'Política de privacidad',
    licenseAndCredits: 'Licencia y créditos',
    checkAndUpdate: 'Verificar y actualizar',
    done: 'Hecho',
    drawEasyTraceToSketch: 'Dibuja Fácil: Traza para Boceto',
  };

  static const Map<String, dynamic> VI = {
    splashTitle: 'Vẽ Dễ Dàng',
    splashSubtitle: 'Theo Dõi Đến Bản Phác Thảo',
    onboardingTitle1: 'CHỤP & PHÁT HIỆN',
    onboardingSubtitle1:
        'Phát hiện các cạnh trong bất kỳ bức ảnh nào để tạo bản phác thảo.',
    onboardingTitle2: 'VẼ',
    onboardingSubtitle2:
        'Bạn có thể dễ dàng vẽ theo ảnh trên giấy bằng chân máy hoặc kính.',
    skip: 'Bỏ qua',
    next: 'Tiếp theo',
    previous: 'Trước',
    finish: 'Hoàn thành',
    selectLanguage: 'Chọn ngôn ngữ',
    subscription: 'Đăng ký',
    rateThisApp: 'Đánh giá ứng dụng',
    shareApp: 'Chia sẻ ứng dụng',
    privacyPolicy: 'Chính sách bảo mật',
    licenseAndCredits: 'Giấy phép và ghi nhận',
    checkAndUpdate: 'Kiểm tra & cập nhật',
    done: 'Xong',
    drawEasyTraceToSketch: 'Vẽ Dễ Dàng: Theo Dõi Đến Bản Phác Thảo',
  };
}
