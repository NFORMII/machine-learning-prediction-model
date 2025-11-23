// ...existing code...
import 'package:flutter/material.dart';
import '../models/startup_data.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> predictionResult;
  final StartupData formData;

  const ResultScreen({super.key, required this.predictionResult, required this.formData});

  @override
  Widget build(BuildContext context) {
    final int predictedStatus = predictionResult['predicted_status'];
    final double rawScore = predictionResult['raw_score'];
    
    final bool isSuccess = predictedStatus == 1;
    final String predictionText = isSuccess ? 'High Potential for Success' : 'At Risk of Failure';
    final Color resultColor = isSuccess ? Colors.green.shade400 : Colors.red.shade400;
    final IconData resultIcon = isSuccess ? Icons.check_circle_outline : Icons.highlight_off;

    final Color primaryPurple = Theme.of(context).colorScheme.primary;
    final Color midPurple = Theme.of(context).colorScheme.secondary;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color surface = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: primaryPurple,
      appBar: AppBar(
        title: const Text('Entrepreneurial Success Gauge'),
        backgroundColor: primaryPurple,
        elevation: 0,
        foregroundColor: onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(resultIcon, size: 120, color: resultColor),
            const SizedBox(height: 24),
            Text(
              predictionText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: onPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'Prediction Confidence Score: ${rawScore.toStringAsFixed(3)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: onPrimary.withOpacity(0.85)),
            ),
            const SizedBox(height: 48),
            _buildSummaryCard(context, surface, onPrimary),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Evaluate Another Venture'),
              style: ElevatedButton.styleFrom(
                backgroundColor: midPurple, // button uses secondary (lighter purple)
                foregroundColor: onPrimary,
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
    );
  }

  Widget _buildSummaryCard(BuildContext context, Color cardColor, Color textColor) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Venture Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
            const Divider(height: 24, color: Colors.white24),
            _buildSummaryRow('Team Size:', formData.relationships.toString(), textColor),
            _buildSummaryRow('Total Funding:', '\$${formData.funding_total_usd}', textColor),
            _buildSummaryRow('Funding Rounds:', formData.funding_rounds.toString(), textColor),
            _buildSummaryRow('Series A Investment:', formData.has_roundA == 1 ? 'Yes' : 'No', textColor),
            _buildSummaryRow('Series B Investment:', formData.has_roundB == 1 ? 'Yes' : 'No', textColor),
            _buildSummaryRow('Series C Investment:', formData.has_roundC == 1 ? 'Yes' : 'No', textColor),
            _buildSummaryRow('Series D Investment:', formData.has_roundD == 1 ? 'Yes' : 'No', textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: textColor.withOpacity(0.9))),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
// ...existing code...