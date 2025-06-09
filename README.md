# min_dia

https://docs.google.com/document/d/1ZcYZD2th9OycgTrd7N-mhLl_U8puJZ6Rhx7VwJ-stzk/edit?usp=sharing

# 📚 Continue Listening Feature

This project implements the **"Continue Listening"** feature for the `min-dia` app as per the client requirements.

---

## ▶️ Usage Steps

1. Launch the app → Home Page
2. Tap the **Book icon** → navigates to Book Page
3. Tap the **Music icon** → navigates to Audio Page
4. Tap **Play** → audio starts, widget will appear
5. Navigate back → widget appears on Home & Book Page
6. Use widget to **Play/Pause** from anywhere

🎧 Audio resumes from last position, and `_handleDisposeEvent` logs the listen percentage when the widget is disposed (e.g., on app close or navigation).

---

## ✅ Tech Summary

- **Widget appears only after audio playback starts**
- **Play/Pause works both in Audio Page and widget**
- **Playback resumes from last position using `SharedPreferences`**
- **iOS-safe layout using `SafeArea`**
- **Rounded card UI matches client design**

---

## 🛠 Tech Stack

- Flutter
- GetX
- just_audio
- shared_preferences

---

> Built with clean architecture.  
> Code is modular, maintainable, and production-ready. ✅