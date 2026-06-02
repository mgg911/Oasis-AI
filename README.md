# 🌱 Oasis AI — Autonomous Greenhouse Intelligence

<p align="center">
  <a href="#русский">Русский</a> • 
  <a href="#english">English</a>
</p>

---

## Русский

**Oasis AI** — умная автоматизированная система ухода за растениями на базе IoT и искусственного интеллекта. Проект представляет собой комплекс из аппаратной части (микроконтроллер ESP32, датчики, реле) и кроссплатформенного мобильного приложения, разработанного на Flutter.

Система способна самостоятельно отслеживать состояние микроклимата, управлять поливом и освещением, а интегрированная нейросетевая модель анализирует входящие показатели и генерирует индивидуальные рекомендации и оптимальные планы ухода для любого типа растений.

### Основные функции
* **Интеллектуальный генератор планов**: Нейросеть (через OpenRouter API) подбирает частоту полива, объём воды, нормы освещения (в люксах), влажности и температуры под конкретный вид растения.
* **Автоматическое управление**: Удалённое включение/выключение УФ-лампы, водяной помпы и вентиляции на основе данных от датчиков в реальном времени.
* **Мониторинг параметров**: Сбор и отображение ключевых показателей (влажность почвы, температура воздуха, уровень освещённости).
* **Синхронизация с облаком**: Мгновенный обмен данными между аппаратной станцией и мобильным интерфейсом через Firebase Realtime Database.
* **Премиальный UI/UX**: Тёмная неоновая тема оформления с размытием (Glassmorphism), плавными анимациями и кастомными графиками мониторинга.

### Технологический стек
* **Mobile App**: Flutter, Dart, Firebase Core, Firebase Database, Google Fonts, Flutter Animate
* **Backend/AI**: OpenRouter API (модели автоматического выбора), Firebase Realtime Database
* **Hardware**: C++, ESP32, датчики влажности почвы (емкостные), датчики температуры/влажности воздуха (DHT), датчики освещённости (BH1750), реле управления.

---

### Интерфейс приложения / Application Screenshots

<p align="center">
  <img src="Screenshot_20260602_213809_com.yandex.searchapp.android.cl.png" width="24%" alt="Мониторинг состояния"/>
  <img src="Screenshot_20260602_213824_com.yandex.searchapp.android.cl.png" width="24%" alt="Генератор планов ухода"/>
  <img src="Screenshot_20260602_213829_com.yandex.searchapp.android.cl.png" width="24%" alt="История показателей"/>
  <img src="Screenshot_20260602_213849_com.yandex.searchapp.android.cl.png" width="24%" alt="Интеграция с нейросетью"/>
</p>

<p align="center">
  <img src="Screenshot_20260602_213906_com.yandex.searchapp.android.cl.png" width="24%" alt="Панель датчиков"/>
  <img src="Screenshot_20260602_213911_com.yandex.searchapp.android.cl.png" width="24%" alt="Активация режима автополива"/>
  <img src="Screenshot_20260602_213935_com.yandex.searchapp.android.cl.png" width="24%" alt="Графики климата"/>
  <img src="Screenshot_20260602_213945_com.yandex.searchapp.android.cl.png" width="24%" alt="Настройки системы"/>
</p>

---

## English

**Oasis AI** is an intelligent automated plant care and greenhouse management system powered by IoT and Artificial Intelligence. The project combines a hardware station (ESP32 microcontroller, sensors, relays) with a cross-platform mobile application built using Flutter.

The system monitors microclimate conditions, controls irrigation and lighting, and utilizes an integrated AI model to analyze sensor data, providing tailored care recommendations and optimal growth plans for any plant species.

### Key Features
* **AI Care Plan Generator**: Generates customized care schedules (watering times, water volume, UV lamp duration, and ideal ranges for moisture, temperature, and lux) via the OpenRouter API.
* **Automated Control**: Real-time automated and manual control over UV lighting, water pumps, and ventilation systems based on environmental factors.
* **Live Telemetry & Monitoring**: Tracks soil moisture, air temperature, and ambient light levels using high-precision hardware sensors.
* **Cloud Infrastructure**: Seamless, low-latency synchronization between the physical hardware and mobile application leveraging Firebase Realtime Database.
* **Premium UI/UX Design**: Sleek dark-mode aesthetic featuring high-end glassmorphic containers, fluid structural animations, and responsive dynamic charts.

### Tech Stack
* **Mobile App**: Flutter, Dart, Firebase Core, Firebase Database, Google Fonts, Flutter Animate
* **Backend/AI**: OpenRouter API (automated model routing), Firebase Realtime Database
* **Hardware Ecosystem**: C++, ESP32 MCU, capacitive soil moisture sensors, DHT air climate sensors, BH1750 digital light sensors, multi-channel relay modules.
