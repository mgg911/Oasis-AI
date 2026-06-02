import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class AIService {
  static const String _apiKey = 'YOUR_OPENROUTER_API_KEY_HERE';

  
  static Future<Map<String, dynamic>?> generateCarePlan(String plantName) async {
    final prompt = '''
Ты — система автоматизированной станции ухода за растениями Oasis AI.
Пользователь хочет вырастить: $plantName

Верни ТОЛЬКО валидный JSON без какого-либо текста до или после него:
{
  "plant": "название растения",
  "watering_times_per_day": 2,
  "watering_amount_ml": 200,
  "uv_lamp_hours": 8,
  "target_moisture_min": 40,
  "target_moisture_max": 60,
  "target_temp_min": 18,
  "target_temp_max": 25,
  "target_light_lx": 500,
  "summary": "краткое описание ухода без markdown"
}
''';

    final raw = await _callAI(prompt);

print('RAW RESPONSE: $raw');

    try {
      final start = raw.indexOf('{');
      final end = raw.lastIndexOf('}');
      if (start == -1 || end == -1) return null;

      final jsonStr = raw.substring(start, end + 1);
      final plan = jsonDecode(jsonStr) as Map<String, dynamic>;
      await _savePlanToFirebase(plan);
      return plan;
    } catch (e) {
      return null;
    }
  }

  
  static Future<String> analyzePlantData({
    required int moisture,
    required int temp,
    required int light,
    required bool isUvOn,
  }) async {
    return await _callAI('''
Ты — умная система Oasis AI для ухода за растениями.
Проанализируй показатели датчиков:
- Влажность почвы: $moisture% (норма 40-60%)
- Температура: $temp°C (норма 18-25°C)
- Освещенность: $light Lx (норма 300-600 Lx)
- УФ-лампа: ${isUvOn ? 'Включена' : 'Выключена'}
Дай короткую рекомендацию. Без markdown-символов.
''');
  }

  
  static Future<void> _savePlanToFirebase(Map<String, dynamic> plan) async {
    try {
      final db = FirebaseDatabase.instance.ref();
      await db.child('care_plan').set(plan);
      await db.child('device_status').set('plan_active');
    } catch (e) {
      
    }
  }

  
  static Future<String> _callAI(String prompt) async {
    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'HTTP-Referer': 'https://oasis-ai.app',
        },
        body: jsonEncode({
          'model': 'openrouter/auto',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices']?[0]?['message']?['content'] ?? 'Нет ответа';
      } else {
        final error = jsonDecode(response.body);
        return 'Ошибка API (${response.statusCode}): ${error['error']?['message']}';
      }
    } catch (e) {
      return 'Ошибка подключения: $e';
    }
  }
}