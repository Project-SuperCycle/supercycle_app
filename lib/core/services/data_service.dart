// services/data_service.dart
import 'package:supercycle_app/features/shipment_details/data/models/product.dart';

class DataService {
  static List<Product> getSampleProducts() {
    return [
      Product(
        type: 'ورق أبيض A4',
        quantity: '1500 كجم',
        averagePrice: '45 جنيه/كجم',
      ),
      Product(
        type: 'ورق ملون',
        quantity: '800 كجم',
        averagePrice: '55 جنيه/كجم',
      ),
      Product(
        type: 'كرتون مضلع',
        quantity: '600 كجم',
        averagePrice: '35 جنيه/كجم',
      ),
      Product(
        type: 'ورق جرائد',
        quantity: '1200 كجم',
        averagePrice: '25 جنيه/كجم',
      ),
      Product(
        type: 'علب كرتون مستعملة',
        quantity: '900 كجم',
        averagePrice: '30 جنيه/كجم',
      ),
    ];
  }

  // بيانات الملاحظات التجريبية
  static List<String> getSampleNotes() {
    return [
      'تم فحص المنتجات والتأكد من جودتها',
      'العميل طلب تأجيل التسليم ليوم الأحد القادم',
      'يفضل التعامل مع هذا العميل نقداً فقط',
      'المنتجات في حالة ممتازة وجاهزة للشحن',
      'تم الاتفاق على خصم 5% للكميات الكبيرة',
    ];
  }

  // قائمة فارغة من الملاحظات (للاختبار)
  static List<String> getEmptyNotes() {
    return [];
  }
}
