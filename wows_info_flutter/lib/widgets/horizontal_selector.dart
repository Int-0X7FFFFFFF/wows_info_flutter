import 'package:flutter/material.dart';

class HorizontalSelector extends StatefulWidget {
  final int selectedIndex;
  final List<String> items;
  final Function(int) onSelect;

  const HorizontalSelector({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onSelect,
  });
  @override
  State<HorizontalSelector> createState() => _HorizontalSelectorState();
}

class _HorizontalSelectorState extends State<HorizontalSelector>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.items.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      widget.onSelect(_tabController.index);
    }
  }

  @override
  void didUpdateWidget(covariant HorizontalSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.items.length,
        vsync: this,
        initialIndex: widget.selectedIndex,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Theme.of(context).textTheme.bodyLarge?.color,
      dividerColor: Colors.transparent,
      controller: _tabController,
      tabs: widget.items.map((item) => Tab(text: item)).toList(),
    );
  }
}
