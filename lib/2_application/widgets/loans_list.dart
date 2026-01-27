import 'package:flutter/material.dart';
import 'package:loans/0_domain/entities/loan_entity.dart';
import 'package:loans/2_application/screens/loans_home_screen.dart';
import 'package:loans/2_application/widgets/loans_card.dart';
import 'package:loans/3_utils/config/theme.dart';

class LoansListWidget extends StatefulWidget {
  final List<LoanEntity> loans;
  final LoansType type;
  final Function(String)? onReturn;

  const LoansListWidget({
    super.key,
    required this.loans,
    required this.type,
    this.onReturn,
  });

  @override
  State<LoansListWidget> createState() => _LoansListWidgetState();
}

class _LoansListWidgetState extends State<LoansListWidget> {
  String? _expandedLoanId;

  List<LoanEntity> get _filteredLoans {
    return widget.loans.where((loan) {
      final isOut = widget.type == LoansType.outgoing;
      final isOutLoan = loan.lenderId == 'current_user';
      return isOut ? isOutLoan : !isOutLoan;
    }).toList();
  }

  bool get _isEmpty => _filteredLoans.isEmpty;
  bool get _isOut => widget.type == LoansType.outgoing;
  String get _sectionTitle => _isOut ? 'ITEMS PRESTADOS' : 'ME DEBEN';

  void _toggleExpand(String loanId) {
    setState(() {
      _expandedLoanId = _expandedLoanId == loanId ? null : loanId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _sectionTitle,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.lightPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${_filteredLoans.length} items',
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark
                      ? AppColors.textDarkSecondary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!_isEmpty)
            _CssGridSimulator(
              key: ValueKey(_expandedLoanId),
              loans: _filteredLoans,
              expandedLoanId: _expandedLoanId,
              onToggleExpand: _toggleExpand,
              onReturn: widget.onReturn,
            ),
          if (_isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'No hay préstamos ${_isOut ? 'realizados' : 'recibidos'}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CssGridSimulator extends StatefulWidget {
  final List<LoanEntity> loans;
  final String? expandedLoanId;
  final Function(String) onToggleExpand;
  final Function(String)? onReturn;

  const _CssGridSimulator({
    super.key,
    required this.loans,
    required this.expandedLoanId,
    required this.onToggleExpand,
    this.onReturn,
  });

  @override
  State<_CssGridSimulator> createState() => _CssGridSimulatorState();
}

class _CssGridSimulatorState extends State<_CssGridSimulator> {
  final Map<String, GlobalKey> _cardKeys = {};
  final Map<String, double> _measuredHeights = {};
  bool _isFirstBuild = true;
  int _numCols = 2;

  @override
  void initState() {
    super.initState();
    _initializeKeys();
  }

  @override
  void didUpdateWidget(_CssGridSimulator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loans.length != widget.loans.length) {
      _initializeKeys();
    }

    if (oldWidget.expandedLoanId != widget.expandedLoanId &&
        widget.expandedLoanId != null) {
      _scrollToExpandedCard();
    }
  }

  void _initializeKeys() {
    for (final loan in widget.loans) {
      if (!_cardKeys.containsKey(loan.id)) {
        _cardKeys[loan.id] = GlobalKey();
      }
    }
  }

  int _calculateNumCols(double width) {
    if (width >= 1280) return 6;
    if (width >= 1024) return 5;
    if (width >= 768) return 4;
    if (width >= 640) return 3;
    return 2;
  }

  void _scrollToExpandedCard() {
    if (widget.expandedLoanId == null) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      final key = _cardKeys[widget.expandedLoanId];
      if (key?.currentContext != null && mounted) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      }
    });
  }

  void _measureHeights() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool needsRebuild = false;

      for (final loan in widget.loans) {
        final key = _cardKeys[loan.id];
        final context = key?.currentContext;

        if (context != null) {
          final renderBox = context.findRenderObject() as RenderBox?;
          if (renderBox != null && renderBox.hasSize) {
            final height = renderBox.size.height;
            if (_measuredHeights[loan.id] != height) {
              _measuredHeights[loan.id] = height;
              needsRebuild = true;
            }
          }
        }
      }

      if (needsRebuild && mounted) {
        setState(() {
          _isFirstBuild = false;
        });
      }
    });
  }

  List<_GridItem> _calculateOrderedItems(int numCols) {
    final items = <_GridItem>[];

    for (int i = 0; i < widget.loans.length; i++) {
      final loan = widget.loans[i];
      final isExpanded = widget.expandedLoanId == loan.id;
      final colPosition = i % numCols;
      final isLastColumn = colPosition == numCols - 1;

      int order;
      int colSpan;
      int rowSpan;

      if (!isExpanded) {
        order = i * 10;
        colSpan = 1;
        rowSpan = 1;
      } else {
        order = isLastColumn ? ((i - 1) * 10) - 5 : i * 10;
        colSpan = 2;
        rowSpan = 2;
      }

      items.add(_GridItem(
        index: i,
        loan: loan,
        order: order,
        colSpan: colSpan,
        rowSpan: rowSpan,
        isExpanded: isExpanded,
      ));
    }

    items.sort((a, b) => a.order.compareTo(b.order));

    return items;
  }

  List<_GridPosition> _calculateDensePositions(
      List<_GridItem> orderedItems, int numCols) {
    final positions = <_GridPosition>[];
    final occupiedCells = <String>{};

    for (final item in orderedItems) {
      var placed = false;
      var row = 0;

      while (!placed) {
        for (int col = 0; col <= numCols - item.colSpan; col++) {
          if (_canPlaceAt(
              row, col, item.rowSpan, item.colSpan, occupiedCells)) {
            positions.add(_GridPosition(
              itemIndex: item.index,
              row: row,
              col: col,
              rowSpan: item.rowSpan,
              colSpan: item.colSpan,
            ));

            for (int r = row; r < row + item.rowSpan; r++) {
              for (int c = col; c < col + item.colSpan; c++) {
                occupiedCells.add('$r-$c');
              }
            }

            placed = true;
            break;
          }
        }
        if (!placed) row++;
      }
    }

    return positions;
  }

  bool _canPlaceAt(
      int row, int col, int rowSpan, int colSpan, Set<String> occupiedCells) {
    for (int r = row; r < row + rowSpan; r++) {
      for (int c = col; c < col + colSpan; c++) {
        if (occupiedCells.contains('$r-$c')) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _measureHeights();

    final screenWidth = MediaQuery.of(context).size.width - 32;
    _numCols = _calculateNumCols(screenWidth + 32);

    const spacing = 12.0;

    if (_isFirstBuild || _measuredHeights.isEmpty) {
      return Opacity(
        opacity: 0.0,
        child: Column(
          children: widget.loans.map((loan) {
            final isExpanded = widget.expandedLoanId == loan.id;
            return Container(
              key: _cardKeys[loan.id],
              width: isExpanded ? screenWidth : (screenWidth - spacing) / 2,
              child: LoansCard(
                loan: loan,
                isExpanded: isExpanded,
                onTap: () => widget.onToggleExpand(loan.id),
                onReturn: widget.onReturn,
              ),
            );
          }).toList(),
        ),
      );
    }

    final orderedItems = _calculateOrderedItems(_numCols);
    final positions = _calculateDensePositions(orderedItems, _numCols);

    final rowHeights = <int, double>{};
    for (final position in positions) {
      final height =
          _measuredHeights[widget.loans[position.itemIndex].id] ?? 40.0;

      for (int r = position.row; r < position.row + position.rowSpan; r++) {
        final heightPerRow = height / position.rowSpan;
        rowHeights[r] =
            (rowHeights[r] ?? 0) > heightPerRow ? rowHeights[r]! : heightPerRow;
      }
    }

    double totalHeight = 0;
    if (rowHeights.isNotEmpty) {
      totalHeight = rowHeights.values.reduce((a, b) => a + b) +
          (rowHeights.length - 1) * spacing;
    }

    return SizedBox(
      height: totalHeight,
      child: Stack(
        children: positions.map((position) {
          final loan = widget.loans[position.itemIndex];
          final isExpanded = widget.expandedLoanId == loan.id;

          final left =
              position.col * ((screenWidth - spacing) / _numCols + spacing);

          double top = 0;
          for (int r = 0; r < position.row; r++) {
            top += (rowHeights[r] ?? 0) + spacing;
          }

          final width =
              position.colSpan * ((screenWidth - spacing) / _numCols) +
                  (position.colSpan - 1) * spacing;

          double height = 0;
          for (int r = position.row; r < position.row + position.rowSpan; r++) {
            height += (rowHeights[r] ?? 0);
            if (r < position.row + position.rowSpan - 1) {
              height += spacing;
            }
          }

          return AnimatedPositioned(
            key: ValueKey(loan.id),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: left,
            top: top,
            width: width,
            height: height,
            child: Container(
              key: _cardKeys[loan.id],
              child: LoansCard(
                loan: loan,
                isExpanded: isExpanded,
                onTap: () => widget.onToggleExpand(loan.id),
                onReturn: widget.onReturn,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GridItem {
  final int index;
  final LoanEntity loan;
  final int order;
  final int colSpan;
  final int rowSpan;
  final bool isExpanded;

  _GridItem({
    required this.index,
    required this.loan,
    required this.order,
    required this.colSpan,
    required this.rowSpan,
    required this.isExpanded,
  });
}

class _GridPosition {
  final int itemIndex;
  final int row;
  final int col;
  final int rowSpan;
  final int colSpan;

  _GridPosition({
    required this.itemIndex,
    required this.row,
    required this.col,
    required this.rowSpan,
    required this.colSpan,
  });
}
