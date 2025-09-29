import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pasos/features/tracking/presentation/cubit/tracking_cubit.dart';
import 'package:pasos/features/tracking/presentation/cubit/tracking_state.dart';
import 'package:pasos/features/tracking/presentation/widgets/map_widget.dart';
import 'package:pasos/features/tracking/presentation/widgets/tracking_control_panel.dart';
import 'package:pasos/features/tracking/presentation/widgets/tracking_info_card.dart';
import 'package:pasos/shared/theme/app_text_styles.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  void initState() {
    super.initState();
    context.read<TrackingCubit>().fetchTrackingInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تتبع الطالب', style: AppTextStyles.titleLarge),
      ),
      body: BlocBuilder<TrackingCubit, TrackingState>(
        builder: (context, state) {
          if (state is TrackingLoading || state is TrackingInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TrackingError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.bodyLarge.copyWith(color: Colors.red),
              ),
            );
          }
          if (state is TrackingLoaded) {
            return SafeArea(
              child: Stack(
                children: [
                  MapWidget(trackingData: state.data),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: TrackingInfoCard(status: state.status),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TrackingControlPanel(
                      isTrackingActive: state.status.isTrackingActive,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
