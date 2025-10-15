import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';

class RepresentativProfileImage extends StatelessWidget {
  const RepresentativProfileImage({super.key, required this.logoPath});

  final String logoPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ProfileConstants.profileImageSize,
      height: ProfileConstants.profileImageSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF4CAF50), width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(6),
          child: Image.asset(
            logoPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person,
                size: 70,
                color: Color(0xFF4CAF50),
              );
            },
          ),
        ),
      ),
    );
  }
}
