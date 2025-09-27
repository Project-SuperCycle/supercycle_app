class DataService {
  static List<String> getSampleNotes() {
    return [
      'تم فحص المنتجات والتأكد من جودتها',
      'العميل طلب تأجيل التسليم ليوم الأحد القادم',
      'يفضل التعامل مع هذا العميل نقداً فقط',
      'المنتجات في حالة ممتازة وجاهزة للشحن',
      'تم الاتفاق على خصم 5% للكميات الكبيرة',
    ];
  }
  static List<String> getEmptyNotes() {
    return [];
  }
}
