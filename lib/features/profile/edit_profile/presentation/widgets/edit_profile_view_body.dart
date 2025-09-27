import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_header_logo.dart';

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

                    // Header Logo
                    ProfileHeaderLogo(),

                    const SizedBox(height: 30),

                    // User Name
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

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
                                color: Colors.blue,
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

            const SizedBox(height: 70),

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
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
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: textColor ?? Colors.blue,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: textColor?.withOpacity(0.7) ?? Colors.grey[600],
        ),
      ),
      trailing: trailing ??
          (onTap != null
              ? Icon(Icons.arrow_forward_ios,
              size: 16,
              color: textColor ?? Colors.grey)
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
          title: const Text("تغيير الصورة الشخصية"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("التقاط صورة"),
                onTap: () {
                  Navigator.pop(context);
                  // Handle camera capture
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
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
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تعديل $fieldName"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: fieldName,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
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
          title: const Text("اختر اللغة"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("العربية"),
                leading: Radio(
                  value: "ar",
                  groupValue: "ar",
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
          title: const Text("تسجيل الخروج"),
          content: const Text("هل أنت متأكد من أنك تريد تسجيل الخروج؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
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
          title: const Text("حول التطبيق"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SuperCycle App"),
              Text("الإصدار: 1.0.0"),
              SizedBox(height: 10),
              Text("تطبيق إدارة الدراجات الهوائية"),
            ],
          ),
          actions: [
            TextButton(
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
      const SnackBar(content: Text("سيتم فتح صفحة الأمان والخصوصية")),
    );
  }

  void _navigateToHelp() {
    // Navigate to help page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("سيتم فتح صفحة المساعدة")),
    );
  }
}