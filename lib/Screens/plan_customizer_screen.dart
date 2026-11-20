import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class PlanCustomizerScreen extends StatefulWidget {
  final String planName;
  final String initialPriceText;
  final String billingType; // 'One-Time' ya 'Monthly'

  const PlanCustomizerScreen({
    super.key,
    required this.planName,
    required this.initialPriceText,
    required this.billingType,
  });

  @override
  State<PlanCustomizerScreen> createState() => _PlanCustomizerScreenState();
}

class _PlanCustomizerScreenState extends State<PlanCustomizerScreen> {
  late double _currentPrice;
  final TextEditingController _projectNoteController = TextEditingController();

  double _extractNumericPrice(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    final parsed = double.tryParse(cleaned);
    if (parsed == null || parsed <= 0) {
      return 149;
    }
    return parsed;
  }

  @override
  void initState() {
    super.initState();
    _currentPrice = _extractNumericPrice(widget.initialPriceText)
        .clamp(25, 1000);
  }

  @override
  void dispose() {
    _projectNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;
    final String suffix = widget.billingType == 'Monthly' ? '/mo' : '';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1523),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Plan Details — ${widget.planName}',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 20,
          vertical: 32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Plan & Price Summary Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B)
                              .withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.planName.toUpperCase()} • ${widget.billingType.toUpperCase()}',
                          style: const TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '\$${_currentPrice.round()}$suffix',
                            style: const TextStyle(
                              color: Color(0xFFF59E0B),
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Estimated Budget',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Price Slider
                      const Text(
                        'Adjust Estimated Price (Slider)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFFF59E0B),
                          inactiveTrackColor: Colors.white12,
                          thumbColor: const Color(0xFFF59E0B),
                          overlayColor: const Color(0xFFF59E0B)
                              .withValues(alpha: 0.2),
                          valueIndicatorColor: const Color(0xFFF59E0B),
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Slider(
                          value: _currentPrice,
                          min: 25,
                          max: 1000,
                          divisions: 195,
                          label: '\$${_currentPrice.round()}',
                          onChanged: (val) {
                            setState(() {
                              _currentPrice = val;
                            });
                          },
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$25',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '\$1,000',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Projects Overview & Important Notes
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Projects & Delivery Notes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Scope or extra sheets/screens badhne par final price slider ke mutabik adjust kiya ja sakta hai.\n'
                        '• Har project me clean structure, clear communication, aur timely delivery par focus rehta hai.',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Sample / Featured Projects Reference',
                        style: TextStyle(
                          color: Color(0xFFF59E0B),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _projectRefTile(SiteData.projectsTitle, 'Featured'),
                      const SizedBox(height: 8),
                      _projectRefTile(SiteData.projectsTitle, 'Featured'),
                      const SizedBox(height: 8),
                      _projectRefTile(SiteData.projectsTitle, 'Featured'),
                      const SizedBox(height: 20),

                      // Custom Note Input
                      const Text(
                        'Apna Project Note / Requirement Likhein',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _projectNoteController,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'e.g. Mujhe sales sheet me automated formulas aur clean summary chahiye...',
                          hintStyle: const TextStyle(color: Colors.white30),
                          filled: true,
                          fillColor: const Color(0xFF0B0F19),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFF59E0B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Bottom Action Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        final note = _projectNoteController.text.trim();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF1F2937),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              note.isEmpty
                                  ? 'Selected ${widget.planName} at \$${_currentPrice.round()}$suffix'
                                  : 'Saved note & estimate \$${_currentPrice.round()}$suffix',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      label: const Text(
                        'Confirm Estimate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectRefTile(String title, String tag) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F19),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            tag,
            style: const TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
