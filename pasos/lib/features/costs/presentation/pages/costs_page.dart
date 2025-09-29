import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/shared/theme/app_colors.dart';
import 'package:pasos/shared/theme/app_spacing.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';
import '../cubit/costs_cubit.dart';
import '../cubit/costs_state.dart';
import '../widgets/costs_summary_card.dart';
import '../widgets/installment_item_widget.dart';
import '../widgets/expense_item_widget.dart';

class CostsPage extends StatefulWidget {
  const CostsPage({super.key});

  @override
  State<CostsPage> createState() => _CostsPageState();
}

class _CostsPageState extends State<CostsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<CostsCubit>().loadCosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'المصروفات والأقساط',
          style: AppTextStyles.arabicHeadline.copyWith(fontSize: 24),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.secondary,
          labelStyle: AppTextStyles.arabicBody,
          unselectedLabelColor: AppColors.black.withValues(alpha: 0.6),
          tabs: const [
            Tab(text: 'الأقساط'),
            Tab(text: 'المصروفات الأخرى'),
          ],
        ),
      ),
      body: BlocBuilder<CostsCubit, CostsState>(
        builder: (context, state) {
          if (state is CostsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            );
          }

          if (state is CostsError) {
            return Center(
              child: Text(state.message, style: AppTextStyles.arabicBody),
            );
          }

          if (state is CostsLoaded) {
            return SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    CostsSummaryCard(
                      totalFees: state.totalFees,
                      totalPaid: state.totalPaid,
                      totalRemaining: state.totalRemaining,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildInstallmentsList(state),
                          _buildExpensesList(state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInstallmentsList(CostsLoaded state) {
    if (state.installments.isEmpty) {
      return Center(
        child: Text('لا توجد أقساط مسجلة', style: AppTextStyles.arabicBody),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.installments.length,
      itemBuilder: (context, index) {
        final installment = state.installments[index];
        return InstallmentItemWidget(installment: installment);
      },
    );
  }

  Widget _buildExpensesList(CostsLoaded state) {
    if (state.expenses.isEmpty) {
      return Center(
        child: Text(
          'لا توجد مصروفات أخرى مسجلة',
          style: AppTextStyles.arabicBody,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.expenses.length,
      itemBuilder: (context, index) {
        final expense = state.expenses[index];
        return ExpenseItemWidget(expense: expense);
      },
    );
  }
}
