import 'package:flutter/material.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';

class MealForm extends StatefulWidget {
  final String planId;
  final Meal? meal;
  final NutritionRepository repo;

  const MealForm({
    super.key,
    required this.planId,
    this.meal,
    required this.repo,
  });

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.meal != null) {
      _nameController.text = widget.meal!.name;
      _selectedTime = widget.meal!.time;
    }
  }

  Future<void> _saveMeal() async {
    if (!_formKey.currentState!.validate()) return;

    final isNew = widget.meal == null;
    final mealData = Meal(
      id: isNew ? '' : widget.meal!.id,
      planId: widget.planId,
      name: _nameController.text,
      time: _selectedTime,
      order: widget.meal?.order ?? 1,
      mealItems: widget.meal?.mealItems ?? const [],
    );

    if (isNew) {
      await widget.repo.insertMeal(mealData);
    } else {
      await widget.repo.updateMeal(mealData);
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (t != null) {
      setState(() => _selectedTime = t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal == null ? 'Add Meal' : 'Edit Meal'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Meal Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.access_time),
                label: Text(
                  _selectedTime != null
                      ? 'Time: ${_selectedTime!.format(context)}'
                      : 'Set Meal Time',
                ),
                onPressed: _pickTime,
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Save Meal',
                onPressed: _saveMeal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}