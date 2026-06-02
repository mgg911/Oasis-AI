# 🌱 Oasis AI — Autonomous Greenhouse Intelligence

<p align="center">
  <a href="#русский">Русский</a> • 
  <a href="#english">English</a>
</p>

---

## Русский

**Oasis AI** — умная система автоматического ухода за растениями на базе IoT и искусственного интеллекта. Проект представляет собой комплекс из смарт-теплицы и кроссплатформенного приложения.
# Oasis AI — Autonomous Greenhouse Intelligence

Интеллектуальная система автоматизированного ухода за растениями на базе микроконтроллера ESP32, мобильного приложения на Flutter и интеграции с искусственным интеллектом через OpenRouter API.

## 📱 Интерфейс приложения

### Основной экран и генерация планов ухода
Приложение позволяет автоматически создавать индивидуальные протоколы заботы для любого типа растений (например, для орхидей или микрозелени) с помощью нейросети.

<p align="center">
  <img src="Screenshot_20260602_213824_com.yandex.searchapp_edit_19530319706394.jpg" width="30%" alt="Генератор планов ухода" />
  <img src="Screenshot_20260602_213849_com.yandex.searchapp_edit_19568041870451.jpg" width="30%" alt="План для орхидеи" />
  <img src="Screenshot_20260602_213935_com.yandex.searchapp_edit_19607895599611.jpg" width="30%" alt="План для микрозелени" />
</p>

### Активный мониторинг и датчики
Экран отслеживания в реальном времени собирает данные с сенсоров (влажность, температура, освещенность) и управляет состоянием периферии (УФ-лампы, автополив).

<p align="center">
  <img src="Screenshot_20260602_213906_com.yandex.searchapp_edit_19580067123053.jpg" width="30%" alt="Мониторинг орхидеи" />
  <img src="Screenshot_20260602_213945_com.yandex.searchapp_edit_19618506602735.jpg" width="30%" alt="Мониторинг микрозелени" />
  <img src="Screenshot_20260602_213911_com.yandex.searchapp_edit_19591933092322.jpg" width="30%" alt="Показания датчиков" />
</p>

### История событий
Журнал логирует все действия станции: автоматические сессии полива, включение освещения по таймеру AI и критические уведомления об отклонении показателей от нормы.

<p align="center">
  <img src="Screenshot_20260602_213829_com.yandex.searchapp_edit_19545305203787.jpg" width="45%" alt="История событий" />
</p>

## 🛠 Технологический стек

* **Hardware:** ESP32, датчики влажности почвы, датчик освещенности (BH1750), датчик температуры и влажности воздуха (DHT22), реле управления помпой и УФ-лампой.
* **Mobile & Web:** Flutter, Dart, Firebase (Firestore, Authentication, Hosting).
* **AI Integration:** OpenRouter API для кастомного анализа состояния экосистемы.
### Что уже в планах и разработке

* 📊 **Мониторинг:** Получение данных о влажности почвы, температуре воздуха и освещённости с датчиков ESP32 в реальном времени.
* 🤖 **ИИ-аналитика:** Интеграция с нейросетью через OpenRouter API для генерации индивидуальных планов ухода под каждый вид растения.
* 💧 **Автополив:** Автоматическая подача воды помпой при падении уровня влажности ниже критического.
* 💡 **Умный свет:** ИИ-управление УФ-лампой для продления светового дня растений.
* 📋 **История событий:** Логирование ключевых показателей теплицы и действий системы в базу данных Firebase.

### Архитектура системы
[ ESP32 + Датчики ] ──> Firebase Database ──> [ Flutter App ]
│
▼
OpenRouter API (ИИ)
│
▼
Персональный план ухода
### Технологический стек

| Слой | Технологии |
| :--- | :--- |
| **Мобильное приложение** | Flutter, Dart |
| **Микроконтроллер** | ESP32 |
| **База данных / Облако** | Firebase Realtime Database |
| **Интеграция с ИИ** | OpenRouter API (LLM модели) |

---

## English

**Oasis AI** is an automated smart greenhouse system powered by IoT and Artificial Intelligence. 

### Core Features

* 📊 **Real-time Monitoring:** Tracking soil moisture, ambient temperature, and light levels via ESP32.
* 🤖 **AI Care Plans:** Generating customized plant growth schedules using LLMs via OpenRouter API.
* 💧 **Smart Irrigation:** Automated water pump triggering based on live sensor thresholds.
* 📋 **Data Logging:** Saving sensor history and automated actions inside Firebase Realtime Database.

### Tech Stack

* **Frontend:** Flutter & Dart (iOS/Android)
* **Hardware:** ESP32 & IoT Sensors
* **Backend:** Firebase Cloud Services
* **AI Engine:** OpenRouter API
