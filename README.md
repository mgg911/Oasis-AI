# 🌱 Oasis AI — Autonomous Greenhouse Intelligence

<p align="center">
  <a href="#русский">Русский</a> • 
  <a href="#english">English</a>
</p>

---

## Русский

**Oasis AI** — умная система автоматического ухода за растениями на базе IoT и искусственного интеллекта. Проект представляет собой комплекс из смарт-теплицы и кроссплатформенного приложения.

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
