import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/family_member.dart';
import '../../theme/app_theme.dart';

class FamilyMemberFormScreen extends StatefulWidget {
  final FamilyMember? existingMember;

  const FamilyMemberFormScreen({super.key, this.existingMember});

  @override
  State<FamilyMemberFormScreen> createState() => _FamilyMemberFormScreenState();
}

class _FamilyMemberFormScreenState extends State<FamilyMemberFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  String _selectedGender = 'Female';
  late final TextEditingController _goalController;

  final List<String> _genders = ['Female', 'Male', 'Non-binary'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.existingMember?.name ?? '',
    );
    _ageController = TextEditingController(
      text: widget.existingMember != null
          ? widget.existingMember!.age.toString()
          : '',
    );
    _selectedGender = widget.existingMember?.gender ?? 'Female';
    _goalController = TextEditingController(
      text: widget.existingMember?.fitnessGoal ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _saveMember() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final age = int.tryParse(_ageController.text.trim()) ?? 25;
      final goal = _goalController.text.trim();

      if (widget.existingMember != null) {
        final updated = widget.existingMember!.copyWith(
          name: name,
          age: age,
          gender: _selectedGender,
          fitnessGoal: goal,
        );
        appState.updateFamilyMember(updated);
      } else {
        final newMember = FamilyMember(
          id: 'fam_${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          age: age,
          gender: _selectedGender,
          fitnessGoal: goal,
          membershipStatus: 'Active Family Pass',
        );
        appState.addFamilyMember(newMember);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingMember != null;

    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Family Member' : 'Add Family Member',
          style: AppTextStyles.subtitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name field
                const Text('Full name', style: AppTextStyles.label),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  style: AppTextStyles.body,
                  decoration: const InputDecoration(
                    hintText: 'Enter family member name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Age field
                const Text('Age', style: AppTextStyles.label),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.body,
                  decoration: const InputDecoration(
                    hintText: 'Enter age in years',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter age.';
                    }
                    final age = int.tryParse(value.trim());
                    if (age == null || age < 5 || age > 100) {
                      return 'Please enter a valid age between 5 and 100.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Gender selector
                const Text('Gender', style: AppTextStyles.label),
                const SizedBox(height: 6),
                Row(
                  children: _genders.map((g) {
                    final isSelected = _selectedGender == g;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = g;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                          alignment: Alignment.center,
                          child: Text(
                            g,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.softBone
                                  : AppColors.deepForest,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Fitness Goal field
                const Text('Fitness goal', style: AppTextStyles.label),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _goalController,
                  style: AppTextStyles.body,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Flexibility, Yoga, Strength',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a fitness goal.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _saveMember,
                    child: Text(isEditing ? 'Save changes' : 'Add member'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
