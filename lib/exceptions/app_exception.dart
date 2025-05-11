import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException implements Exception {
  // 타임아웃
  const factory AppException.timeout() = _Timeout;

  // 네트워크 예외
  const factory AppException.network(String message) = _Network;

  // 잘못된 요청
  const factory AppException.unknown(String message) = _Unknown;
  const factory AppException.badRequest(String message) = _BadRequest;
  const factory AppException.unauthorized() = _Unauthorized;
  const factory AppException.forbidden() = _Forbidden;
  const factory AppException.notFound() = _NotFound;
  const factory AppException.server(String message) = _Server;
  const factory AppException.cancelled() = _Cancelled;
}

extension AppExceptionMessage on AppException {
  String get message => when(
        unknown: (message) => message,
        timeout: () => '요청 시간이 초과되었습니다.',
        network: (message) => message,
        badRequest: (message) => message,
        unauthorized: () => '인증이 필요합니다.',
        forbidden: () => '접근이 금지되었습니다.',
        notFound: () => '요청한 리소스를 찾을 수 없습니다.',
        server: (message) => message,
        cancelled: () => '요청이 취소되었습니다.',
      );
}
