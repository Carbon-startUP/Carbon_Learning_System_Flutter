import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/core/navigation/app_router.dart';
import 'package:pasos/features/curricula/presentation/cubit/curricula_cubit.dart';
import 'package:pasos/features/curricula/presentation/cubit/curricula_state.dart';
import 'package:pasos/features/curricula/presentation/widgets/curriculum_list_item.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class CurriculaPage extends StatefulWidget {
  const CurriculaPage({super.key});

  @override
  State<CurriculaPage> createState() => _CurriculaPageState();
}

class _CurriculaPageState extends State<CurriculaPage> {
  @override
  void initState() {
    super.initState();
    context.read<CurriculaCubit>().fetchCurricula();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المناهج الدراسية', style: AppTextStyles.titleLarge),
        centerTitle: true,
      ),
      body: BlocBuilder<CurriculaCubit, CurriculaState>(
        builder: (context, state) {
          if (state is CurriculaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurriculaLoaded) {
            return ListView.builder(
              itemCount: state.curricula.length,
              itemBuilder: (context, index) {
                final curriculum = state.curricula[index];
                return CurriculumListItem(
                  curriculum: curriculum,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.curriculumDetails,
                      arguments: curriculum,
                    );
                  },
                );
              },
            );
          } else if (state is CurriculaError) {
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          }
          return Center(
            child: Text('ابدأ بتحميل المناهج', style: AppTextStyles.arabicBody),
          );
        },
      ),
    );
  }
}
