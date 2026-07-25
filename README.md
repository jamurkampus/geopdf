# BorneoGIS PDF Map — Elite Edition by Lamri

**Professional Offline GeoPDF Viewer for Android**

Alternatif Avenza Maps yang berjalan 100% offline. GPS real-time di atas GeoPDF. Gratis. Bebas berlangganan.

---

## Fitur

- Membuka file GeoPDF dari penyimpanan Android
- Posisi GPS real-time tepat di atas GeoPDF (menggunakan data georef dari file)
- Koordinat: Latitude, Longitude (DD/DMS), UTM Easting, UTM Northing, Zona UTM
- Elevasi, Heading, Kecepatan, Akurasi GPS (±m) dengan indikator warna
- Kompas magnetometer real-time
- Crosshair di tengah layar
- Tema Light dan Dark
- Halaman Home: Buka GeoPDF, Riwayat File, Pengaturan, Tentang
- Splash Screen animasi
- 100% offline setelah instalasi

---

## Tech Stack

| Komponen | Library |
|---|---|
| Framework | Flutter 3.24 (Dart 3.3+) |
| PDF Rendering | pdfx ^2.6.0 |
| GPS | geolocator ^12.0.0 |
| Kompas | sensors_plus ^6.0.0 |
| File Picker | file_picker ^8.1.2 |
| State | provider ^6.1.2 |
| Storage | shared_preferences ^2.3.3 |
| Screen On | wakelock_plus ^1.2.8 |
| UTM Convert | Built-in (WGS84, tanpa dependensi eksternal) |
| GeoPDF Parse | Built-in (GPTS/XMP/LGI, tanpa dependensi eksternal) |

---

## Cara Build APK

### Prasyarat

1. Flutter SDK 3.24+ — https://docs.flutter.dev/get-started/install
2. Android Studio / VS Code dengan Flutter extension
3. JDK 17+
4. Android SDK (API 21+)

### Langkah Build

```bash
# 1. Clone / ekstrak proyek
cd borneogis_pdf_map

# 2. Install dependencies
flutter pub get

# 3. Build APK release
flutter build apk --release

# APK tersimpan di:
# build/app/outputs/flutter-apk/app-release.apk

# 4. (Opsional) Build APK split per ABI untuk ukuran lebih kecil
flutter build apk --split-per-abi --release
```

### Install ke Perangkat

```bash
# Via USB (debug mode aktif)
flutter install

# Manual: copy APK ke perangkat, lalu install
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## Fonts

Aplikasi menggunakan **Space Grotesk** dari Google Fonts. Unduh dan letakkan di `assets/fonts/`:

- `SpaceGrotesk-Regular.ttf`
- `SpaceGrotesk-Medium.ttf`
- `SpaceGrotesk-SemiBold.ttf`
- `SpaceGrotesk-Bold.ttf`

Download: https://fonts.google.com/specimen/Space+Grotesk

Atau aktifkan `google_fonts` package (sudah ada di pubspec.yaml) dan hapus referensi font lokal di pubspec.yaml bagian `fonts:` jika tidak ingin menyertakan font manual.

---

## Struktur Proyek

```
lib/
  main.dart               # Entry point, routing, providers
  theme/
    app_theme.dart        # Light & Dark theme, AppColors
  models/
    recent_file.dart      # Model data file terakhir
  providers/
    app_provider.dart     # State: tema, settings, recent files
    gps_provider.dart     # GPS stream, compass, GpsData
  screens/
    splash_screen.dart    # Splash animasi
    home_screen.dart      # Halaman utama
    viewer_screen.dart    # Viewer GeoPDF + GPS overlay
    settings_screen.dart  # Pengaturan
    about_screen.dart     # Tentang aplikasi
  widgets/
    gps_panel.dart        # Panel koordinat GPS
    crosshair_overlay.dart  # Crosshair tengah
    compass_widget.dart   # Widget kompas
    recent_file_tile.dart # Tile file terakhir (swipeable)
  utils/
    utm_converter.dart    # Konversi Lat/Lon → UTM (WGS84)
    geopdf_parser.dart    # Ekstrak georef dari GeoPDF bytes
    coordinate_formatter.dart  # Format DD, DMS, kecepatan, heading

android/
  app/
    src/main/
      AndroidManifest.xml     # Permissions, intent filters
      kotlin/.../MainActivity.kt
      res/
        xml/file_provider_paths.xml
        values/styles.xml, colors.xml
        values-night/styles.xml
  build.gradle
  gradle.properties
  settings.gradle

website/
  index.html              # Landing page

assets/
  fonts/                  # Space Grotesk TTF files
  images/                 # App images (opsional)
```

---

## GeoPDF Parser

Parser georeferencing mendukung 3 format:

1. **OGC GeoPDF** — `/GPTS [lat lon lat lon ...]` array
2. **USGS-style** — XMP viewport metadata dengan koordinat
3. **ESRI-style** — `/LGIDict` dengan `/Bounds` array

Jika file tidak memiliki georeferencing, PDF tetap bisa dibuka dan ditampilkan, tetapi overlay GPS tidak aktif.

---

## Izin Android yang Dibutuhkan

| Izin | Kegunaan |
|---|---|
| ACCESS_FINE_LOCATION | GPS presisi tinggi |
| ACCESS_COARSE_LOCATION | Fallback GPS kasar |
| READ_EXTERNAL_STORAGE | Membaca file PDF (Android ≤12) |
| WAKE_LOCK | Jaga layar menyala saat navigasi |

---

## Kontak

**Lamri, S.P.**
GIS Analyst & WebGIS Developer
- Portfolio: https://lamri.vercel.app
- BorneoGIS: https://borneogis.vercel.app
- GitHub: https://github.com/jamurkampus

---

*© 2025 Lamri — BorneoGIS PDF Map Elite Edition*
