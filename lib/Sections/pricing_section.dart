import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';
import 'package:my_practice_app/Screens/plan_customizer_screen.dart';

class PricingSection extends StatefulWidget {
  final void Function(String planSummary)? onSelectPlan;

  const PricingSection({super.key, this.onSelectPlan});

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  bool _isMonthly = false;
  int _selectedProjectIndex = 0; // 0, 1, or 2
  int _selectedRows = 1000;

  List<String> _parseFeatures(String raw) {
    return raw
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  int _minRowsForProject(int index) {
    if (index == 1) return SiteData.sliderProj2MinRows;
    if (index == 2) return SiteData.sliderProj3MinRows;
    return SiteData.sliderProj1MinRows;
  }

  int _maxRowsForProject(int index) {
    if (index == 1) return SiteData.sliderProj2MaxRows;
    if (index == 2) return SiteData.sliderProj3MaxRows;
    return SiteData.sliderProj1MaxRows;
  }

  String _labelForProject(int index) {
    if (index == 1) return SiteData.sliderProj2Label;
    if (index == 2) return SiteData.sliderProj3Label;
    return SiteData.sliderProj1Label;
  }

  double _rateForProject(int index) {
    if (index == 1) return SiteData.sliderProj2RatePerRow;
    if (index == 2) return SiteData.sliderProj3RatePerRow;
    return SiteData.sliderProj1RatePerRow;
  }

  double _baseFeeForProject(int index) {
    if (index == 2) return SiteData.sliderProj3BaseFee;
    return 0.0;
  }

  String _noteForProject(int index) {
    if (index == 1) return SiteData.sliderProj2Note;
    if (index == 2) return SiteData.sliderProj3Note;
    return SiteData.sliderProj1Note;
  }

  double _calculateTotalPrice() {
    final rate = _rateForProject(_selectedProjectIndex);
    final base = _baseFeeForProject(_selectedProjectIndex);
    final rawTotal = base + (_selectedRows * rate);
    return _isMonthly ? rawTotal * 1.25 : rawTotal;
  }

  List<int> _presetRowOptions(int minR, int maxR) {
    final candidates = [100, 250, 500, 1000, 2500, 5000, 10000, 20000, 50000];
    final filtered = candidates.where((r) => r >= minR && r <= maxR).toList();
    if (!filtered.contains(minR)) filtered.insert(0, minR);
    if (!filtered.contains(maxR)) filtered.add(maxR);
    return filtered;
  }

  void _onProjectChanged(int newIndex) {
    final minR = _minRowsForProject(newIndex);
    final maxR = _maxRowsForProject(newIndex);
    setState(() {
      _selectedProjectIndex = newIndex;
      _selectedRows = _selectedRows.clamp(minR, maxR);
    });
  }

  void _openCustomizer({required String planName, required String priceText}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanCustomizerScreen(
          planName: planName,
          initialPriceText: priceText,
          billingType: _isMonthly ? 'Monthly' : 'One-Time',
        ),
      ),
    );
    widget.onSelectPlan?.call(
      '$planName ($priceText - ${_isMonthly ? "Monthly" : "One-Time"})',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 950;

    final cards = [
      _buildPricingCard(
        index: 0,
        name: SiteData.plan1Name,
        price: _isMonthly
            ? SiteData.plan1MonthlyPrice
            : SiteData.plan1OneTimePrice,
        description: SiteData.plan1Desc,
        features: _parseFeatures(SiteData.plan1Features),
        isPopular: SiteData.popularPlanIndex == 0,
      ),
      _buildPricingCard(
        index: 1,
        name: SiteData.plan2Name,
        price: _isMonthly
            ? SiteData.plan2MonthlyPrice
            : SiteData.plan2OneTimePrice,
        description: SiteData.plan2Desc,
        features: _parseFeatures(SiteData.plan2Features),
        isPopular: SiteData.popularPlanIndex == 1,
      ),
      _buildPricingCard(
        index: 2,
        name: SiteData.plan3Name,
        price: _isMonthly
            ? SiteData.plan3MonthlyPrice
            : SiteData.plan3OneTimePrice,
        description: SiteData.plan3Desc,
        features: _parseFeatures(SiteData.plan3Features),
        isPopular: SiteData.popularPlanIndex == 2,
      ),
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFF0B0F19),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: isDesktop ? 76.0 : 48.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(flex: 7, child: _buildHeaderTexts()),
                    const SizedBox(width: 24),
                    _buildBillingToggle(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderTexts(),
                    const SizedBox(height: 24),
                    _buildBillingToggle(),
                  ],
                ),

          const SizedBox(height: 40),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: cards[0]),
                    const SizedBox(width: 24),
                    Expanded(child: cards[1]),
                    const SizedBox(width: 24),
                    Expanded(child: cards[2]),
                  ],
                )
              : Column(
                  children: [
                    cards[0],
                    const SizedBox(height: 20),
                    cards[1],
                    const SizedBox(height: 20),
                    cards[2],
                  ],
                ),

          const SizedBox(height: 32),

          // Row & Project Based Calculator + Notes
          _buildRowCalculatorBox(isDesktop),
        ],
      ),
    );
  }

  Widget _buildRowCalculatorBox(bool isDesktop) {
    final int minR = _minRowsForProject(_selectedProjectIndex);
    final int maxR = _maxRowsForProject(_selectedProjectIndex);
    final int safeRows = _selectedRows.clamp(minR, maxR);
    final double total = _calculateTotalPrice();
    final double rate = _rateForProject(_selectedProjectIndex);
    final double baseFee = _baseFeeForProject(_selectedProjectIndex);
    final String suffix = _isMonthly ? '/mo' : '';
    final presetRows = _presetRowOptions(minR, maxR);
    final int dropdownValue = presetRows.contains(safeRows)
        ? safeRows
        : presetRows.first;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildCalculatorControls(
                    minR: minR,
                    maxR: maxR,
                    safeRows: safeRows,
                    total: total,
                    rate: rate,
                    baseFee: baseFee,
                    suffix: suffix,
                    presetRows: presetRows,
                    dropdownValue: dropdownValue,
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(flex: 4, child: _buildProjectPricingNotes()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCalculatorControls(
                  minR: minR,
                  maxR: maxR,
                  safeRows: safeRows,
                  total: total,
                  rate: rate,
                  baseFee: baseFee,
                  suffix: suffix,
                  presetRows: presetRows,
                  dropdownValue: dropdownValue,
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white10),
                const SizedBox(height: 20),
                _buildProjectPricingNotes(),
              ],
            ),
    );
  }

  Widget _buildCalculatorControls({
    required int minR,
    required int maxR,
    required int safeRows,
    required double total,
    required double rate,
    required double baseFee,
    required String suffix,
    required List<int> presetRows,
    required int dropdownValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Project & Row-Based Price Calculator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '₹${total.toStringAsFixed(0)}$suffix',
              style: const TextStyle(
                color: Color(0xFFF59E0B),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          baseFee > 0
              ? 'Base Setup: ₹${baseFee.toStringAsFixed(0)} + ₹${rate.toStringAsFixed(2)} / row'
              : 'Rate: ₹${rate.toStringAsFixed(2)} / row • Selected: $safeRows rows',
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        const SizedBox(height: 16),

        // Project Dropdown + Rows Dropdown
        Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0F19),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                child: DropdownButton<int>(
                  value: _selectedProjectIndex,
                  dropdownColor: const Color(0xFF111827),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        _labelForProject(0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        _labelForProject(1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(
                        _labelForProject(2),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) _onProjectChanged(val);
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0F19),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                child: DropdownButton<int>(
                  value: dropdownValue,
                  dropdownColor: const Color(0xFF111827),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: presetRows
                      .map(
                        (r) => DropdownMenuItem<int>(
                          value: r,
                          child: Text('$r rows'),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedRows = val);
                    }
                  },
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Synced Row Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFFF59E0B),
            inactiveTrackColor: Colors.white12,
            thumbColor: const Color(0xFFF59E0B),
            overlayColor: const Color(0xFFF59E0B).withValues(alpha: 0.2),
            valueIndicatorColor: const Color(0xFFF59E0B),
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Slider(
            value: safeRows.toDouble(),
            min: minR.toDouble(),
            max: maxR.toDouble(),
            divisions: ((maxR - minR) ~/ 100).clamp(1, 200),
            label: '$safeRows rows',
            onChanged: (val) {
              setState(() {
                _selectedRows = (val.round() ~/ 50) * 50;
                if (_selectedRows < minR) _selectedRows = minR;
                if (_selectedRows > maxR) _selectedRows = maxR;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$minR rows',
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
            Text(
              '$maxR rows',
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),

        const SizedBox(height: 14),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF59E0B),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            _openCustomizer(
              planName:
                  '${_labelForProject(_selectedProjectIndex)} ($safeRows rows)',
              priceText: '₹${total.toStringAsFixed(0)}$suffix',
            );
          },
          icon: const Icon(Icons.calculate_outlined, size: 16),
          label: const Text(
            'Proceed With This Estimate',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectPricingNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Project Pricing & Notes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _noteLine('• ${_noteForProject(_selectedProjectIndex)}'),
        const SizedBox(height: 8),
        _noteLine(
          '• Slider aur Rows Dropdown dono live connected hain—kisi bhi ek se rows badlein.',
        ),
        const SizedBox(height: 8),
        _noteLine(
          '• Admin Panel se har project ka per-row rate aur limits kabhi bhi update kiye ja sakte hain.',
        ),
      ],
    );
  }

  Widget _noteLine(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 13.5,
        height: 1.5,
      ),
    );
  }

  Widget _buildHeaderTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF59E0B), width: 0.6),
          ),
          child: Text(
            '⚡ ${SiteData.pricingBadge}',
            style: const TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          SiteData.pricingTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.2,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          SiteData.pricingSubtitle,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleButton(
            label: 'One-Time',
            selected: !_isMonthly,
            onTap: () => setState(() => _isMonthly = false),
          ),
          const SizedBox(width: 4),
          _toggleButton(
            label: 'Monthly',
            selected: _isMonthly,
            onTap: () => setState(() => _isMonthly = true),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF59E0B) : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard({
    required int index,
    required String name,
    required String price,
    required String description,
    required List<String> features,
    required bool isPopular,
  }) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isPopular ? const Color(0xFFF59E0B) : Colors.white10,
          width: isPopular ? 1.6 : 1.0,
        ),
        boxShadow: isPopular
            ? [
                BoxShadow(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'POPULAR',
                    style: TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFFF59E0B),
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _isMonthly ? 'per month' : 'per project',
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),

          ...features.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFFF59E0B),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: isPopular
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _openCustomizer(planName: name, priceText: price);
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _openCustomizer(planName: name, priceText: price);
                    },
                    child: const Text(
                      'Select Plan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
