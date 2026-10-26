# 🛒 E-Commerce App - Project Tracker & Architecture Guide

> **آخر تحديث:** 2026-10-21  
> **الهدف من هذا الملف:** توثيق شامل لبنية المشروع، المعايير والأنماط البرمجية المعتمدة، وسجل التحديثات المستمرة لتفادي ضياع الوقت وتكرار الشرح في كل محادثة.

---

## 📌 1. التقنيات والمكتبات الأساسية (Tech Stack)

* **Framework:** Flutter (Dart)
* **Design / Responsive:** `flutter_screenutil` (Design Size: `430 x 932`)
* **State Management:** `flutter_bloc` (Cubit)
* **Architecture Pattern:** Clean Architecture (Data, Domain, Presentation/UI)
* **Dependency Injection:** `get_it` + `injectable` (مع التوليد التلقائي `build_runner`)
* **Networking:** `dio` + `retrofit` + `pretty_dio_logger` + `connectivity_plus`
* **Typography & Fonts:** Google Fonts (`Poppins`), `auto_size_text`
* **UI Helpers & Dialogs:** `dialog_utils.dart`, `flutter_toast.dart`

---

## 🏗️ 2. الهيكل المعماري المعتمد (Architecture & Conventions)

### أ. إدارة الحالات (State Management Convention)
* **المعيار الإلزامي:** استخدام كلاس الحالة الموحد **`ResourceState<T>`** الموجود في:  
  `lib/features/common/resource_state.dart`
* **الحالات المدعومة داخل ResourceState:**
  - `ResourceState.initial()`
  - `ResourceState.loading()`
  - `ResourceState.success([data])`
  - `ResourceState.error([errorMessage])`
* **الـ Getters الجاهزة للاستخدام في الـ UI:**
  - `state.isLoading`
  - `state.isSuccess`
  - `state.isError`
  - `state.isInitial`
  - `state.errorMessage`
  - `state.data`
* **قاعدة هامة:** لا نقوم بإنشاء ملفات حالات منفصلة (`*_state.dart`) لكل شاشة، بل نعتمد على `Cubit<ResourceState>` أو `Cubit<ResourceState<Model>>` مباشرة لتوحيد وتسهيل الكود.

---

### ب. طبقة الشبكة والبيانات (Networking & Data Layer)
* **`ApiResult<T>`:** كلاس sealed يمثل نتيجة استدعاء الـ API من طبقة الـ Data والـ UseCases:
  - `SuccessApiResult<T>` (يحتوي على `data`)
  - `ErrorApiResult<T>` (يحتوي على `AppErrors`)
  - يوفر `isSuccess` و `isError` و `getError` و `getData`.
* **معالجة الأخطاء:** تدار مركزياً وبذكاء عبر `handle_dio_error.dart`، حيث تفحص كافة أشكال الـ JSON المرتجعة من السيرفر (message, errors list, errors map, statusMsg) والـ Status Codes لضمان وضوح رسائل الخطأ دائماً.
* **حقن التبعيات (DI):** استخدام `@injectable` للـ ViewModels و `@LazySingleton()` للـ UseCases / Repositories.

---

## 📁 3. خريطة مجلدات المشروع (Project Structure)

```text
lib/
├── core/
│   ├── di/                 # إعدادات GetIt و Injectable (di.dart, di.config.dart, network_module.dart)
│   ├── errors/             # تعريفات الأخطاء (app_errors.dart)
│   ├── extension/          # Extensions مفيدة
│   └── utils/              # الأدوات المساعدة (AppAssets, AppColors, AppRoutes, AppStyles, AppTheme, DialogUtils, AppValidators)
├── features/
│   ├── auth/               # ميزة المصادقة (Login & Register)
│   │   ├── data/           # DataSource (Remote) & Repository Implementation
│   │   ├── domain/         # Repository Interface & UseCases (LoginUseCase, RegisterUseCase)
│   │   └── ui/screens/     # شاشات الواجهة والـ Cubit
│   │       ├── login/      # LoginScreen + LoginViewModel
│   │       └── register/   # RegisterScreen + RegisterViewModel
│   ├── cart/               # ميزة السلة (قيد التطوير)
│   ├── commerce/           # ميزة المنتجات والتسوق (قيد التطوير)
│   ├── common/             # الأدوات والمكونات المشتركة
│   │   ├── resource_state.dart # الكلاس العام للحالات
│   │   └── widgets/        # CustomTextFormField, CustomElevatedButton, etc.
│   └── network/            # نماذج الشبكة والـ API
│       ├── api/            # ApiServices (Retrofit), ApiEndpoints, ApiResult
│       ├── models/         # Request & Response models (LoginRequest, RegisterRequest, ...)
│       └── handle_dio_error.dart
└── main.dart               # نقطة الانطلاق + تهيئة ScreenUtil والـ Routes والـ DI
```

---

## 📝 4. سجل التحديثات وحالة الشاشات (Changelog & Status)

| الميزة / الشاشة | الحالة | الملاحظات والتفاصيل |
|----------------|--------|---------------------|
| **Core / DI / Network** | مكتمل ✅ | إعداد Dio و Retrofit و GetIt و AppTheme. تصحيح تمرير الـ Dio المحقون لـ `ApiServices` في NetworkModule. |
| **Common / ResourceState** | مكتمل ✅ | كلاس موحد لكافة حالات التطبيق (`ResourceState<T>`). |
| **Data & Auth Flow** | مكتمل ✅ | تمرير `AuthResponseDto` بكامل بياناتها (بما فيها الـ Token) عبر الـ DataSource والـ Repository والـ UseCase حتى الـ ViewModel. |
| **Login Screen** | مكتمل ✅ | ربط `LoginViewModel` بـ `ResourceState<AuthResponseDto>`، وتفعيل `dispose()` لإغلاق الـ Controllers والـ ViewModel لمنع أي تسريب ذاكرة. |
| **Register Screen** | مكتمل ✅ | ربط `RegisterViewModel` بـ `ResourceState<AuthResponseDto>`، إضافة `dispose()` لكافة الـ Controllers والـ ViewModel، فصل أيقونة إظهار الباسورد عن تأكيد الباسورد (`isRePasswordObscured`)، وتحسين التحقق والتوجيه بعد النجاح. |
| **Validators** | مكتمل ✅ | تحسين فحص رقم الهاتف في `AppValidators` عند الحقول الفارغة. |
| **Home Screen** | التالي ⏳ | الشاشة الرئيسية والتصنيفات والمنتجات المعروضة. |
| **Cart & Products** | مستقبلي ⏳ | تفاصيل المنتج والسلة وعملية الشراء. |
| **Token Storage** | مستقبلي ⏳ | حفظ الـ Token (باستخدام flutter_secure_storage أو shared_preferences) بعد نجاح تسجيل الدخول. |

---

## 💡 5. تعليمات للمساعد الذكي في كل محادثة قادمة:
1. اقرأ هذا الملف أولاً قبل اقتراح أو كتابة أي كود جديد.
2. لا تنشئ ملفات State منفصلة لكل ميزة؛ استخدم دائماً `ResourceState`.
3. حافظ على التسميات ونمط الحقن المتبع عبر `getIt` و `@injectable`.
4. بعد إتمام أي مهمة أو إضافة شاشة جديدة، قم بتحديث هذا الملف مباشرة.
