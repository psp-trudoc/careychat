import 'dart:io';
import 'dart:typed_data';

import 'package:carey/core/constants/image_assets.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class MQTTService {
  MqttServerClient? client;
  final String mqttEndpoint = "am8hbq0e8x6ij-ats.iot.ap-south-1.amazonaws.com";
  final int mqttPort = 8883;
  final String clientId = "satpal-test";
  //TODO change clientId to something like:
  // mqttClientId = "$userId-$deviceId"

  final String mqttTopic = "/v3/dev/user/U78853";
  final String willMessage = "your-will-message";

  Future<void> connectChat() async {
    if (client != null && client!.connectionStatus!.state == MqttConnectionState.connected) {
      print("Already connected");
      return;
    }

    try {
      // Initialize MQTT Client
      client = MqttServerClient.withPort(mqttEndpoint, clientId, mqttPort);
      client!.secure = true;
      client!.keepAlivePeriod = 10;
      client!.logging(on: true);

      final SecurityContext securityContext = SecurityContext.defaultContext;

      try {

        ByteData rootCA = await rootBundle.load("packages/carey/assets/aws/AmazonRootCA1.pem");
        ByteData deviceCert = await rootBundle.load("packages/carey/assets/aws/aws-iot-certificate.pem.crt");
        ByteData privateKey = await rootBundle.load("packages/carey/assets/aws/aws-iot-private.pem.key");

        securityContext.setTrustedCertificatesBytes(rootCA.buffer.asUint8List());
        securityContext.useCertificateChainBytes(deviceCert.buffer.asUint8List());
        securityContext.usePrivateKeyBytes(privateKey.buffer.asUint8List());

        client?.securityContext = securityContext;
        print("Security context set successfully.");

      } catch (e) {
        print("Error loading certificates: $e");
        return;
      }

      // Set LWT and connection message
      client!.setProtocolV311();
      client!.connectionMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
          .withWillTopic(mqttTopic)
          .withWillMessage(willMessage)
          .startClean();

      client!.onConnected = () {
        subscribe(mqttTopic);
      };

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
