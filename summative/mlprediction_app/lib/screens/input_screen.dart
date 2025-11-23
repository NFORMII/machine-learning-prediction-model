// ...existing code...
import 'package:flutter/material.dart';
import '../models/startup_data.dart';
import '../services/prediction_service.dart';
import 'result_screen.dart';

const Color deepPurple = Color(0xFF6A0DAD); // deep bright purple
const Color midPurple = Color(0xFF9F7AEA);  // lighter purple for controls

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = StartupData();
  bool _isLoading = false;

  void _handlePredict() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() {
        _isLoading = true;
      });

      try {
        final predictionResult = await PredictionService.getPrediction(_formData);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              predictionResult: predictionResult,
              formData: _formData,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // overall background explicitly set to deep bright purple
      backgroundColor: deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App header
                const Center(
                  child: Text(
                    'Entrepreneurial Success Gauge',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Fill in your venture details to evaluate its potential.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Form Fields
                _buildTextFormField(
                  label: 'Team Size',
                  icon: Icons.people_outline,
                  onSaved: (value) => _formData.relationships = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Total Funding (USD)',
                  icon: Icons.attach_money,
                  onSaved: (value) => _formData.funding_total_usd = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  label: 'Number of Funding Rounds',
                  icon: Icons.replay_circle_filled_outlined,
                  onSaved: (value) => _formData.funding_rounds = int.tryParse(value!) ?? 0,
                ),
                const SizedBox(height: 24),
                _buildFundingRoundSwitch(
                  label: 'Has Series A Investment?',
                  value: _formData.has_roundA == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundA = newValue ? 1 : 0);
                  },
                ),
                _buildFundingRoundSwitch(
                  label: 'Has Series B Investment?',
                  value: _formData.has_roundB == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundB = newValue ? 1 : 0);
                  },
                ),
                _buildFundingRoundSwitch(
                  label: 'Has Series C Investment?',
                  value: _formData.has_roundC == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundC = newValue ? 1 : 0);
                  },
                ),
                _buildFundingRoundSwitch(
                  label: 'Has Series D Investment?',
                  value: _formData.has_roundD == 1,
                  onChanged: (newValue) {
                    setState(() => _formData.has_roundD = newValue ? 1 : 0);
                  },
                ),
                const SizedBox(height: 40),

                // Predict Button
                if (_isLoading)
                  const Center(child: CircularProgressIndicator(color: Colors.white))
                else
                  ElevatedButton.icon(
                    icon: const Icon(Icons.insights, color: Colors.white),
                    label: const Text('Evaluate Venture'),
                    onPressed: _handlePredict,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: midPurple, // button = lighter purple
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({required String label, required IconData icon, required FormFieldSetter<String> onSaved}) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: midPurple.withOpacity(0.16), // input background = lighter purple tint
      ),
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
  
  Widget _buildFundingRoundSwitch({required String label, required bool value, required ValueChanged<bool> onChanged}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: midPurple.withOpacity(0.12), // control background = lighter purple tint
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: midPurple.withOpacity(0.7),
            inactiveTrackColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}
// ...existing code...
// ```/ filepath: c:\Users\HP\New folder (3)\machine-learning-prediction-model\summative\mlprediction_app\lib\screens\input_screen.dart
// ...existing code...