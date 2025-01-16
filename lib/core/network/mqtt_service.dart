import 'package:carey/core/constants/amplifyconfiguration.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:amplify_flutter/amplify_flutter.dart';


class MQTTService {
  MqttServerClient? client;
  final String mqttEndpoint = "https://am8hbq0e8x6ij-ats.iot.ap-south-1.amazonaws.com";
  final String region = "APSouth1";
  final String clientId = "U78853-E970F891-096A-4ECD-B0E3-08FB2C787FA3";
  final String mqttTopic = "/v3/dev/user/U78853";
  final String willMessage = "your-will-message";

  Future<void> connectChat() async {
    if (client != null && client!.connectionStatus!.state == MqttConnectionState.connected) {
      print("Already connected");
      return;
    }

    try {
      // Initialize AWS Amplify
      // await Amplify.configure(amplifyconfig);
      print("try 00");

      // final credentials = await Amplify.Auth.fetchAuthSession();

      // Create MQTT Client
      client = MqttServerClient.withPort(mqttEndpoint, clientId, 8883);
      client!.secure = true;
      client!.keepAlivePeriod = 10;
      client!.logging(on: true);
      print("try 1");

      // Set LWT
      client!.setProtocolV311();
      client!.connectionMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
      .authenticateAs("AKIAX7L3DOJ4MJENOKPZ", "SrZyq/X8Mf+2K2TR9XMXCiTC26dzDqG57YToAG0p")
          .withWillTopic(mqttTopic)
          .withWillMessage(willMessage)
          .startClean();
      print("try 2");

      // Connect to MQTT broker
      await client!.connect();
      print("Connected to MQTT");
    } catch (e) {
      print("Error connecting to MQTT: $e");
    }
  }

  Future<void> subscribe(String topic) async {
    if (client == null || client!.connectionStatus!.state != MqttConnectionState.connected) {
      print("Client not connected. Call connectChat() first.");
      return;
    }

    client!.subscribe(topic, MqttQos.atLeastOnce);
    print("Subscribed to $topic");

    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> events) {
      final MqttPublishMessage message = events[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      print("Received message: $payload from topic: ${events[0].topic}");
    });
  }

  void disconnect() {
    client?.disconnect();
    print("Disconnected from MQTT");
  }
}
