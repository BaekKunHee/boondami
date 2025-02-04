import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BMImage extends StatelessWidget {
  final String imageUrl; // 이미지 URL 또는 경로
  final double? width; // 이미지 너비
  final double? height; // 이미지 높이
  final BoxFit? fit; // 이미지 비율 조정 옵션
  final ImageType imageType; // 이미지 타입 지정

  const BMImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    required this.imageType,
  });

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.svg:
        return SvgPicture.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          placeholderBuilder: (BuildContext context) =>
              const CircularProgressIndicator(), // 로딩 중 표시
        );
      case ImageType.asset:
        return Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
        );
      case ImageType.network:
      default:
        return Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
        );
    }
  }
}

// 이미지 타입을 정의
enum ImageType {
  svg,
  asset,
  network,
}
