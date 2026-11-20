import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class AdminProjectsTab extends StatefulWidget {
  final TextEditingController badgeController;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final List<ProjectItem> projects;
  final ValueChanged<ProjectItem> onAddProjectTop;
  final ValueChanged<int> onRemoveProjectAt;

  const AdminProjectsTab({
    super.key,
    required this.badgeController,
    required this.titleController,
    required this.subtitleController,
    required this.projects,
    required this.onAddProjectTop,
    required this.onRemoveProjectAt,
  });

  @override
  State<AdminProjectsTab> createState() => _AdminProjectsTabState();
}

class _AdminProjectsTabState extends State<AdminProjectsTab> {
  final TextEditingController _tagCtrl = TextEditingController();
  final TextEditingController _projTitleCtrl = TextEditingController();
  final TextEditingController _shortDescCtrl = TextEditingController();
  final TextEditingController _fullDetailsCtrl = TextEditingController();
  final TextEditingController _toolsCtrl = TextEditingController();
  final TextEditingController _outcomeCtrl = TextEditingController();

  Uint8List? _sampleBytes;
  String? _sampleName;
  bool _isDragging = false;

  @override
  void dispose() {
    _tagCtrl.dispose();
    _projTitleCtrl.dispose();
    _shortDescCtrl.dispose();
    _fullDetailsCtrl.dispose();
    _toolsCtrl.dispose();
    _outcomeCtrl.dispose();
    super.dispose();
  }

  void _addNewProject() {
    final title = _projTitleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF1F2937),
          content: Text(
            'Please enter a project title first.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    final newItem = ProjectItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      tag: _tagCtrl.text.trim().isEmpty
          ? 'SPREADSHEET'
          : _tagCtrl.text.trim().toUpperCase(),
      shortDesc: _shortDescCtrl.text.trim().isEmpty
          ? 'Clean structured project delivery.'
          : _shortDescCtrl.text.trim(),
      fullDetails: _fullDetailsCtrl.text.trim(),
      toolsUsed: _toolsCtrl.text.trim().isEmpty
          ? 'Excel • Google Sheets'
          : _toolsCtrl.text.trim(),
      outcome: _outcomeCtrl.text.trim().isEmpty
          ? 'Accurate & fast workflow'
          : _outcomeCtrl.text.trim(),
      sampleImageBytes: _sampleBytes,
    );

    widget.onAddProjectTop(newItem);

    _tagCtrl.clear();
    _projTitleCtrl.clear();
    _shortDescCtrl.clear();
    _fullDetailsCtrl.clear();
    _toolsCtrl.clear();
    _outcomeCtrl.clear();
    setState(() {
      _sampleBytes = null;
      _sampleName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Projects Section & Grid Manager',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Naya project add karte hi woh grid ki top row me dikhega. "Save Changes" dabana na bhulein.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),

          _field(widget.badgeController, 'Section Badge', 'e.g. PROJECTS'),
          const SizedBox(height: 14),
          _field(
            widget.titleController,
            'Section Heading',
            'e.g. Selected Work & Case Studies',
          ),
          const SizedBox(height: 14),
          _field(
            widget.subtitleController,
            'Section Subtitle',
            'Short description...',
            maxLines: 2,
          ),

          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          const Text(
            'Add New Project (Top Row)',
            style: TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),

          _field(
            _projTitleCtrl,
            'Project Title *',
            'e.g. Automated Inventory Dashboard',
          ),
          const SizedBox(height: 12),
          _field(_tagCtrl, 'Category Tag', 'e.g. EXCEL DASHBOARD'),
          const SizedBox(height: 12),
          _field(
            _shortDescCtrl,
            'Short Card Summary',
            '2-3 line summary for grid card...',
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          _field(
            _fullDetailsCtrl,
            'Full Project Details (Shown on View More Details)',
            'Explain problem, solution, formulas/structure, and how it works...',
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _field(
                  _toolsCtrl,
                  'Tools Used',
                  'e.g. Excel, XLOOKUP, Pivot',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  _outcomeCtrl,
                  'Result / Outcome',
                  'e.g. Saved 6 hrs/week',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sample Image Drop Box
          const Text(
            'Sample Image (Drag & Drop)',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          DropTarget(
            onDragEntered: (_) => setState(() => _isDragging = true),
            onDragExited: (_) => setState(() => _isDragging = false),
            onDragDone: (detail) async {
              setState(() => _isDragging = false);
              if (detail.files.isNotEmpty) {
                final f = detail.files.first;
                final b = await f.readAsBytes();
                setState(() {
                  _sampleBytes = b;
                  _sampleName = f.name;
                });
              }
            },
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _isDragging
                    ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
                    : const Color(0xFF0B0F19),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isDragging ? const Color(0xFFF59E0B) : Colors.white24,
                ),
              ),
              child: _sampleBytes != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Image.memory(
                            _sampleBytes!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black87,
                            ),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () => setState(() {
                              _sampleBytes = null;
                              _sampleName = null;
                            }),
                          ),
                        ),
                        if (_sampleName != null)
                          Positioned(
                            bottom: 6,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _sampleName!,
                                style: const TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Color(0xFFF59E0B),
                            size: 32,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Drag & drop sample image here',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _addNewProject,
            icon: const Icon(Icons.add, size: 18),
            label: const Text(
              'Add Project to Top Row',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),

          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 14),
          Text(
            'Current Projects Order (${widget.projects.length}) — Top item shows first',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          ...List.generate(widget.projects.length, (idx) {
            final p = widget.projects[idx];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF0B0F19),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: idx == 0
                      ? const Color(0xFFF59E0B).withValues(alpha: 0.4)
                      : Colors.white10,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '#${idx + 1}',
                    style: const TextStyle(
                      color: Color(0xFFF59E0B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${p.title} (${p.tag})',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white54,
                      size: 18,
                    ),
                    onPressed: () => widget.onRemoveProjectAt(idx),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    String hint, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30),
            filled: true,
            fillColor: const Color(0xFF0B0F19),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFF59E0B)),
            ),
          ),
        ),
      ],
    );
  }
}
