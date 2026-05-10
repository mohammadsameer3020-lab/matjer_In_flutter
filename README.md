# flutter_application_1
# Shop App

تطبيق متجر زهور عصري تم بناؤه باستخدام **Flutter**، يركز على تقديم تجربة تسوق سلسة وجذابة لمحبي النباتات والهدايا.

---

## 🚀 نظرة عامة (Overview)
هذا المشروع هو عبارة عن منصة تجارة إلكترونية متكاملة لبيع الزهور، تهدف إلى تسهيل عملية اختيار وتنسيق الهدايا. يتميز التطبيق بسرعة الأداء، وتحديثات الأسعار اللحظية، وتصميم واجهة مستخدم (UI) مريح يعتمد على هوية بصرية مستوحاة من الطبيعة.

## 🛠 التقنيات المستخدمة (Tech Stack)
* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [Provider](https://pub.dev/packages/provider) (لإدارة حالة السلة وتحديث السعر فورياً).
* **Language:** Dart.
* **Design Pattern:** Clean Code & Modular Structure.

## ✨ المميزات (Features)
- **تصفح ذكي:** عرض المنتجات مع صور عالية الجودة وتفاصيل شاملة.
- **إدارة سلة التسوق (Cart Management):** - إضافة المنتجات بضغطة زر.
  - حذف منتج معين أو تصفير الكمية بالكامل.
  - تحديث إجمالي السعر وعدد العناصر في الـ AppBar تلقائياً (Real-time updates).
- **شاشة تفاصيل تفاعلية:** ميزة "عرض المزيد/أقل" للوصف النصي للمنتج.
- **ملف الشخصي (Profile):** واجهة مخصصة لإدارة حساب المستخدم، الطلبات، والإعدادات.
- **واجهة مستخدم متجاوبة:** تصميم يدعم مختلف أحجام شاشات الهواتف.

## 📂 هيكل المجلدات (Folder Structure)
```text
lib/
├── model/          # كائنات البيانات (مثل كلاس Item)
├── provider/       # منطق إدارة الحالة (Cart Provider)
├── pages/          # شاشات التطبيق (Home, Details, Checkout, Profile)
├── shared/         # ويدجت مشتركة (Appbar, Colors, Global Widgets)
└── main.dart       # نقطة الانطلاق للتطبيق
A new Flutter project
.
## 📸 واجهات التطبيق (App Screenshots)

<table style="width: 100%;">
  <tr>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/33013b7f-3d11-44ce-a545-9158ab58be37" width="250px" alt="Home Screen"/><br/>
      <b>الشاشة الرئيسية</b>
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/42294797-2402-4511-ac75-901342937428" width="250px" alt="Products Screen"/><br/>
      <b>قائمة المنتجات</b>
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/6c4c4dce-3116-4dc2-bf38-e6743fb93cd4" width="250px" alt="Details Screen"/><br/>
      <b>تفاصيل المنتج</b>
    </td>
  </tr>
  <tr>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/fba53322-aaff-4ac6-a062-fe09e221a0de" width="250px" alt="Cart Screen"/><br/>
      <b>سلة التسوق</b>
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/dcfb28f1-5aa6-40b6-9d79-451c2c9cde50" width="250px" alt="Checkout Screen"/><br/>
      <b>إتمام الدفع</b>
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/e66c89bc-efe1-4cd3-9b0a-fef2524f19c8" width="250px" alt="Profile Screen"/><br/>
      <b>الملف الشخصي</b>
    </td>
  </tr>
</table>
 صور التن
 ![home ](<img width="715" height="818" alt="Annotation 2026-05-10 225919" src="https://github.com/user-attachments/assets/33013b7f-3d11-44ce-a545-9158ab58be37" />
)
<img width="715" height="818" alt="Annotation 2026-05-10 225919" src="https://github.com/user-attachments/assets/42294797-2402-4511-ac75-901342937428" />
home
<img width="728" height="826" alt="Annotation 2026-05-10 225336" src="https://github.com/user-attachments/assets/6c4c4dce-3116-4dc2-bf38-e6743fb93cd4" />
المنتجات
<img width="725" height="818" alt="Annotation 2026-05-10 225427" src="https://github.com/user-attachments/assets/fba53322-aaff-4ac6-a062-fe09e221a0de" />
السله
<img width="726" height="827" alt="Annotation 2026-05-10 225520" src="https://github.com/user-attachments/assets/dcfb28f1-5aa6-40b6-9d79-451c2c9cde50" />
profile
<img width="723" height="830" alt="Annotation 2026-05-10 225613" src="https://github.com/user-attachments/assets/e66c89bc-efe1-4cd3-9b0a-fef2524f19c8" />




## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
