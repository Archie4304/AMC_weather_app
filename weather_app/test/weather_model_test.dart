import 'package:flutter_test/flutter_test.dart';
// Ensure this path matches your actual project structure
import 'package:weather_app/models/weather.dart';

void main() {
  group('Weather Model - fromJson', () {
    test('should return a valid Weather object when given a realistic Manila API response', () {
      // 1. Arrange: A realistic JSON payload from OpenWeatherMap for Manila, Philippines
      final Map<String, dynamic> jsonResponse = {
        "coord": {"lon": 120.9822, "lat": 14.6042},
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 31.2,
          "feels_like": 35.5,
          "temp_min": 30.0,
          "temp_max": 32.5,
          "pressure": 1010,
          "humidity": 65
        },
        "visibility": 10000,
        "wind": {"speed": 4.63, "deg": 70},
        "clouds": {"all": 75},
        "dt": 1705052400,
        "sys": {
          "type": 1,
          "id": 7905,
          "country": "PH",
          "sunrise": 1705011845,
          "sunset": 1705052642
        },
        "timezone": 28800,
        "id": 1701668,
        "name": "Manila",
        "cod": 200
      };

      // 2. Act: Call the fromJson method
      final weather = Weather.fromJson(jsonResponse);

      // 3. Assert: Check that the model fields match the JSON values
      // Note: If your model uses different field names (e.g., 'mainCondition' instead of 'description'),
      // update these lines to match your model.
      expect(weather.cityName, 'Manila');
      expect(weather.temperature, 31.2);
      expect(weather.mainCondition, 'Clouds');
    });

    test('should handle temperature if it comes as an integer', () {
      // OpenWeatherMap sometimes returns whole numbers (e.g., 30 instead of 30.0)
      // This test ensures your model uses .toDouble()
      final Map<String, dynamic> intTempJson = {
        "weather": [{"main": "Clear"}],
        "main": {"temp": 30},
        "name": "Manila"
      };

      final weather = Weather.fromJson(intTempJson);
      expect(weather.temperature, 30.0);
    });
  });
}
