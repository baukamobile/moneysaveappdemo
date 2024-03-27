import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация плагина для уведомлений
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  // Настройка настроек уведомлений для Android
  var initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}
Future<void> _showAndroidNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  // Настройка параметров уведомления для Android
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channelId', // ID канала уведомлений
    'Channel Name', // Название канала уведомлений
    // 'Channel Description', // Описание канала уведомлений
    importance: Importance.high,
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Отправка уведомления на Android
  await flutterLocalNotificationsPlugin.show(
      0, // Уникальный ID уведомления
      'Заголовок уведомления',
      'Текст уведомления',
      platformChannelSpecifics,
      payload: 'Уведомление payload');
}
void startNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  Timer.periodic(Duration(seconds: 5), (Timer timer) {
    _showAndroidNotification(flutterLocalNotificationsPlugin);
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Уведомления каждые 5 часов (Android)')),
        body: Center(
          child: Text('Пример уведомлений для Android'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    startNotifications(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 186, 130),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text('Уведомления')),
          
          
        body: Center(
          child: Text('Пример уведомлений для Android'),
        ),
      ),
    );
  }
}
