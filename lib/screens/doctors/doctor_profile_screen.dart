import 'package:flutter/material.dart';

import '../../data/legal_text.dart';
import '../../models/doctor.dart';
import '../../theme/app_theme.dart';
import '../profile/privacy_screen.dart';
import '../profile/terms_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late String _selectedDate;
  late String _selectedSlot;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.doctor.availableDates.first;
    _selectedSlot = widget.doctor.availableSlots.first;
  }

  void _showBookingSummary() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.softBone,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.warmOat,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Booking summary', style: AppTextStyles.title),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Consultant', style: AppTextStyles.label),
                          Text(
                            widget.doctor.name,
                            style: AppTextStyles.subtitle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Specialty', style: AppTextStyles.label),
                          Text(
                            widget.doctor.specialty,
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date and time',
                            style: AppTextStyles.label,
                          ),
                          Text(
                            '$_selectedDate at $_selectedSlot',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Consultation fee',
                            style: AppTextStyles.label,
                          ),
                          Text(
                            '₹${widget.doctor.fee}',
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Medical demo disclaimer note per Section 7.16 & 9
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warmOat.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: const Text(
                    LegalText.doctorConsultationNotice,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 12,
                      color: AppColors.deepForest,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Legal links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          color: AppColors.deepForest,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(
                      ' · ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          color: AppColors.deepForest,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Confirm booking button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close bottom sheet
                      _showBookingConfirmation();
                    },
                    child: const Text('Confirm booking'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBookingConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.softBone,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.deepForest,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Booking confirmed', style: AppTextStyles.title),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your appointment with ${widget.doctor.name} is scheduled for $_selectedDate at $_selectedSlot.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 12),
                Text(
                  'A secure simulated consultation link will be available in your dashboard 10 minutes before the call.',
                  style: AppTextStyles.label,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // back to doctor list
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: Text(widget.doctor.name, style: AppTextStyles.subtitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset(
                                widget.doctor.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: AppColors.warmOat,
                                      child: const Icon(Icons.person_outline),
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.warmOat,
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusSmall,
                                    ),
                                  ),
                                  child: Text(
                                    widget.doctor.specialty,
                                    style: const TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.deepForest,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.doctor.name,
                                  style: AppTextStyles.subtitle,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${widget.doctor.experienceYears} years clinical experience',
                                  style: AppTextStyles.label,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_outline,
                                      size: 16,
                                      color: AppColors.deepForest,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${widget.doctor.rating} rating',
                                      style: const TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.deepForest,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Biography / Description
                    const Text('About doctor', style: AppTextStyles.subtitle),
                    const SizedBox(height: 6),
                    Text(widget.doctor.description, style: AppTextStyles.body),
                    const SizedBox(height: 24),

                    // Date Selection
                    const Text(
                      'Select consultation date',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: widget.doctor.availableDates.map((date) {
                        final isSelected = _selectedDate == date;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDate = date;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.teal
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSmall,
                                ),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.teal
                                      : AppColors.border,
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: AppColors.deepForest,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Time Slot Selection
                    const Text(
                      'Select available slot',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: widget.doctor.availableSlots.map((slot) {
                        final isSelected = _selectedSlot == slot;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSlot = slot;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.deepForest
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSmall,
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.deepForest
                                    : AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              slot,
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 13,
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
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Booking Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.softBone,
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Fee per session', style: AppTextStyles.label),
                      Text(
                        '₹${widget.doctor.fee}',
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _showBookingSummary,
                      child: const Text('Book consultation'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
