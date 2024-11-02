import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot_movie/core/constants/constants.dart';

import '../../../../core/theme/app_colors.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    this.onMapCreated,
    this.markers,
    this.onMyLocationTap,
    super.key,
  });

  final void Function(GoogleMapController)? onMapCreated;
  final Set<Marker>? markers;
  final VoidCallback? onMyLocationTap;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        GoogleMap(
          style: isDarkMode ? MapConstants.mapStyle : null,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
          ),
          zoomControlsEnabled: false,
          onMapCreated: widget.onMapCreated,
          tiltGesturesEnabled: false,
          myLocationButtonEnabled: false,
          markers: widget.markers ?? {},
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: SafeArea(
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                  },
                  icon: Switch(
                    value: !isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = !isDarkMode;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: widget.onMyLocationTap,
                  icon: CircleAvatar(
                    backgroundColor: AppColors.elementBackgroundColorLight,
                    radius: 25,
                    child: Icon(
                      Icons.my_location_outlined,
                      size: 40,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
