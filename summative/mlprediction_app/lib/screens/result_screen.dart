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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrepreneurial Success Gauge'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
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
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: resultColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Prediction Confidence Score: ${rawScore.toStringAsFixed(3)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 48),
      
            _buildSummaryCard(context),
            const Spacer(),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Evaluate Another Venture'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).colorScheme.primary,
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

  Widget _buildSummaryCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Venture Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 24, color: Colors.white24),
            _buildSummaryRow('Team Size:', formData.relationships.toString()),
            _buildSummaryRow('Total Funding:', '\$${formData.funding_total_usd}'),
            _buildSummaryRow('Funding Rounds:', formData.funding_rounds.toString()),
            _buildSummaryRow('Series A Investment:', formData.has_roundA == 1 ? 'Yes' : 'No'),
            _buildSummaryRow('Series B Investment:', formData.has_roundB == 1 ? 'Yes' : 'No'),
            _buildSummaryRow('Series C Investment:', formData.has_roundC == 1 ? 'Yes' : 'No'),
            _buildSummaryRow('Series D Investment:', formData.has_roundD == 1 ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
