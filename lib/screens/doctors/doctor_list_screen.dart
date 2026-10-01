import 'package:flutter/material.dart';

import '../../data/doctor_data.dart';
import '../../models/doctor.dart';
import '../../theme/app_theme.dart';
import '../../widgets/doctor_card.dart';
import '../../widgets/skeleton_box.dart';
import 'doctor_profile_screen.dart';

class DoctorListScreen extends StatefulWidget {
  final String? initialSpecialty;

  const DoctorListScreen({super.key, this.initialSpecialty});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  bool _isLoading = true;
  late String _selectedSpecialty;

  @override
  void initState() {
    super.initState();
    _selectedSpecialty = widget.initialSpecialty ?? 'All';

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  List<Doctor> get _filteredDoctors {
    if (_selectedSpecialty == 'All') {
      return mockDoctors;
    }
    return mockDoctors.where((d) => d.specialty == _selectedSpecialty).toList();
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SkeletonBox(width: double.infinity, height: 40),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 110),
        SizedBox(height: 12),
        SkeletonBox(width: double.infinity, height: 110),
        SizedBox(height: 12),
        SkeletonBox(width: double.infinity, height: 110),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Doctor Consultations', style: AppTextStyles.title),
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : Column(
              children: [
                // Specialties Chips
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: mockSpecialties.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final specialty = mockSpecialties[index];
                      final isSelected = _selectedSpecialty == specialty;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSpecialty = specialty;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.deepForest
                                : AppColors.warmOat,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            specialty,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.softBone
                                  : AppColors.deepForest,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),

                // Doctor list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = _filteredDoctors[index];
                      return DoctorCard(
                        doctor: doctor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoctorProfileScreen(doctor: doctor),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
