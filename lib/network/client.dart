import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter_grpc_client/network/proto/generated/greeter.pbgrpc.dart';

class GrpcClient {
  const GrpcClient._({
    required ClientChannel channel,
    required GreeterClient greeter,
  })  : _channel = channel,
        _greeter = greeter;

  final ClientChannel _channel;
  final GreeterClient _greeter;

  /// Creates GrpcClient instance with loaded channel and greeter.
  factory GrpcClient.create() {
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    final greeter = GreeterClient(channel);

    return GrpcClient._(channel: channel, greeter: greeter);
  }

  /// Call the 'SayHello' method from the server.
  Future<String> greetServer({required String cleintName}) async {
    try {
      final request = HelloRequest(name: cleintName);
      final response = await _greeter.greetSomeone(request);
      return response.message;
    } catch (e) {
      if (kDebugMode) print('Caught error: $e');
      return '';
    }
  }

  // Close the channel when done
  Future<void> close() async {
    await _channel.shutdown();
  }
}
