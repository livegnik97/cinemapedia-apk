import 'package:flutter/material.dart';

class ImageLoading {
  static Widget isLoading(ImageChunkEvent loadingProgress) => Container(
    color: Colors.black12,
    child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            value: (loadingProgress.expectedTotalBytes != null)
                ? (loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!.toDouble())
                    .toDouble()
                : null,
          ),
        ),
  );

  static Widget isError() => Container(color: Colors.black12, child: Center(child: Text('Ha ocurrido un error')));
}
