import 'package:flutter/material.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  // Sample user data - replace with your actual data source
  String userName = "Ahmed Ali";
  String userEmail = "ahmed@example.com";
  String userPhone = "+20 123 456 7890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Gradient
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(
                gradient: kGradientContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Back Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            "تعديل الملف الشخصي",
                            style: AppStyles.styleSemiBold18(
                              context,
                            ).copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 40), // For symmetry
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Profile Picture with Edit Button
                    Stack(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(75),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.asset(
                              'assets/images/default_avatar.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              _showImagePickerDialog();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Profile Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Personal Information Card
                  _buildInfoCard(
                    title: "المعلومات الشخصية",
                    children: [
                      _buildInfoTile(
                        icon: Icons.person,
                        title: "الاسم",
                        subtitle: userName,
                        onTap: () => _editField("الاسم", userName),
                      ),
                      _buildInfoTile(
                        icon: Icons.email,
                        title: "البريد الإلكتروني",
                        subtitle: userEmail,
                        onTap: () => _editField("البريد الإلكتروني", userEmail),
                      ),
                      _buildInfoTile(
                        icon: Icons.phone,
                        title: "رقم الهاتف",
                        subtitle: userPhone,
                        onTap: () => _editField("رقم الهاتف", userPhone),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Settings Card
                  _buildInfoCard(
                    title: "الإعدادات",
                    children: [
                      _buildInfoTile(
                        icon: Icons.notifications,
                        title: "الإشعارات",
                        subtitle: "تفعيل الإشعارات",
                        trailing: Switch(
                          value: true,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            // Handle notification toggle
                          },
                        ),
                      ),
                      _buildInfoTile(
                        icon: Icons.language,
                        title: "اللغة",
                        subtitle: "العربية",
                        onTap: () => _showLanguageDialog(),
                      ),
                      _buildInfoTile(
                        icon: Icons.security,
                        title: "الأمان والخصوصية",
                        subtitle: "إدارة كلمة المرور",
                        onTap: () => _navigateToSecurity(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Account Actions Card
                  _buildInfoCard(
                    title: "إجراءات الحساب",
                    children: [
                      _buildInfoTile(
                        icon: Icons.help,
                        title: "المساعدة والدعم",
                        subtitle: "احصل على المساعدة",
                        onTap: () => _navigateToHelp(),
                      ),
                      _buildInfoTile(
                        icon: Icons.info,
                        title: "حول التطبيق",
                        subtitle: "الإصدار 1.0.0",
                        onTap: () => _showAboutDialog(),
                      ),
                      _buildInfoTile(
                        icon: Icons.logout,
                        title: "تسجيل الخروج",
                        subtitle: "الخروج من الحساب",
                        textColor: Colors.red,
                        onTap: () => _showLogoutDialog(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Info Card Widget
  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppStyles.styleSemiBold18(context)),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  // Build Info Tile Widget
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (textColor ?? AppColors.primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: textColor ?? AppColors.primaryColor, size: 24),
      ),
      title: Text(
        title,
        style: AppStyles.styleSemiBold14(
          context,
        ).copyWith(color: textColor ?? Colors.black87),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyles.styleSemiBold12(context).copyWith(
          color: textColor?.withOpacity(0.7) ?? AppColors.subTextColor,
        ),
      ),
      trailing:
          trailing ??
          (onTap != null
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: textColor ?? Colors.grey,
                )
              : null),
      onTap: onTap,
    );
  }

  // Show Image Picker Dialog
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "تغيير الصورة الشخصية",
            style: AppStyles.styleSemiBold18(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera, color: AppColors.primaryColor),
                title: const Text("التقاط صورة"),
                onTap: () {
                  Navigator.pop(context);
                  // Handle camera capture
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppColors.primaryColor,
                ),
                title: const Text("اختيار من المعرض"),
                onTap: () {
                  Navigator.pop(context);
                  // Handle gallery selection
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Edit Field Dialog
  void _editField(String fieldName, String currentValue) {
    TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "تعديل $fieldName",
            style: AppStyles.styleSemiBold18(context),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: fieldName,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                // Update the field value
                setState(() {
                  if (fieldName == "الاسم") {
                    userName = controller.text;
                  } else if (fieldName == "البريد الإلكتروني") {
                    userEmail = controller.text;
                  } else if (fieldName == "رقم الهاتف") {
                    userPhone = controller.text;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text("حفظ"),
            ),
          ],
        );
      },
    );
  }

  // Show Language Selection Dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text("اختر اللغة", style: AppStyles.styleSemiBold18(context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("العربية"),
                leading: Radio(
                  value: "ar",
                  groupValue: "ar",
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text("English"),
                leading: Radio(
                  value: "en",
                  groupValue: "ar",
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show Logout Confirmation Dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "تسجيل الخروج",
            style: AppStyles.styleSemiBold18(context),
          ),
          content: const Text("هل أنت متأكد من أنك تريد تسجيل الخروج؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                // Handle logout
              },
              child: const Text("تسجيل الخروج"),
            ),
          ],
        );
      },
    );
  }

  // Show About Dialog
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text("حول التطبيق", style: AppStyles.styleSemiBold18(context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SuperCycle App", style: AppStyles.styleSemiBold14(context)),
              Text("الإصدار: 1.0.0", style: AppStyles.styleSemiBold12(context)),
              const SizedBox(height: 10),
              Text(
                "تطبيق إدارة إعادة التدوير",
                style: AppStyles.styleSemiBold12(context),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("حسناً"),
            ),
          ],
        );
      },
    );
  }

  // Navigation Methods
  void _navigateToSecurity() {
    // Navigate to security settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("سيتم فتح صفحة الأمان والخصوصية"),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  void _navigateToHelp() {
    // Navigate to help page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("سيتم فتح صفحة المساعدة"),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
