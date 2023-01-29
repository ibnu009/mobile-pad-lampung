# PAD Pesat

| PERHATIAN: Sebelum build project perhatikan hal-hal berikut ini! |
| --- |
1. Project ini menggunakan library yang tidak support null safety jadi wajib untuk menonaktifkan null-sound pada project ini baik ketika build ataupun release.
2. Setiap kali membuat BLoC, Repository, ataupun Datasource wajib didaftarkan terlebih dahulu di folder di
3. Pastikan minimum SDK nya tidak kurang dari 21

### Running Project
```dart
flutter run --no-sound-null-safety
```


### Build Project

```dart
flutter build apk --no-sound-null-safety
```

### Penjelasan Struktur Folder
| Folder | Dekripsi |
| --- | --- |
| Common | Tempat untuk menampung hal hal umum seperti error message, API path, dan const value dari Aplikasi |
| Core | Sumber data dari aplikasi, terdapat sub folder untuk menaruh models, repository sebagai penghubung antara datasource dan UI, dan service sebagai base untuk fetching data |
| Di | DI atau kependekan dari Dependency Injection adalah tempat untuk menaruh dependency dari class serta BLoC pada project ini |
| Presentation | Tempat untuk menaruh pages, component atau widget, serta BLoC |

### BLoC Best Practices
1. Setiap screen memiliki 1 BLoC
2. Gunakan provider dari context untuk menggunakan BLoC contoh :
```dart
context.read<YourBLoC>().add(YourEvent());
```
Selalu ingat untuk menambahkan BLoC baru di DI folder dan di provider yang ada di main.dart agar dapat digunakan menggunakan context.

### Convert JSON object menjadi Dart Object
Pada project ini kita menggunakan bantuan quicktype dengan link berikut :
https://app.quicktype.io

### Custom Widget
Pada project ini telah terdapat beberapa custom widget yang dapat digunakan, custom widget dapat ditemukan di :
```dart
presentation -> components
```
disarankan untuk menggunakan widget yang sudah tersedia agar jika ada perubahan tampilan maka hanya perlu merubah di 1 tempat saja.

### Extention
Pada project ini telah terdapat jarang menggunakan utility class, dan lebih menggunakan extension. extension-extension pada project ini dapat ditemukan pada :
```dart
utils -> extension
```

### Bluetooth configuration
1. Setup bluetooth configuration dan membuat function untuk mengambil bounded devices dari bluetooth :
```dart
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}
    if (!mounted) return;
    setState(() {
      _devices = devices;
    });
  }
```
2. Pilih printer yang sesuai dengan kebutuhan, setiap jenis printer memiliki key masing-masing yang dapat ditemukan di :
```dart
core -> data -> sources -> shared_preferences.dart
```
kemudian jika sudah mengambil key yang sesuai, result dari shared preference disimpan kedalam variable dengan tipe data string lalu panggil device yang sesuai. Contoh :

```dart
String deviceName = await storage.readSecureData(printerTicketKey) ?? ""; //untuk mengambil printer bluetooth untuk print ticket
BluetoothDevice? selectedDevice = _devices.getProperDevice(deviceName);
```

3. Lakukan proses printing dengan memanggil class printer helper dan bluetooth.connected callback :
```dart
final PrinterHelper printerHelper = PrinterHelper();

 bluetooth.isConnected.then((isConnected) {
        print('isConnected $isConnected');
        if (isConnected == false) {
          bluetooth.connect(selectedDevice).then((value) {
            if (value == false) return;
            printerHelper.printTicketParkir(
                code: widget.parkingCode ?? '',
                location: wisataName,
                vehicleType: widget.vehicleType ?? '');
          }).catchError((error) {});
          printerHelper.printTicketParkir(
              code: widget.parkingCode ?? '',
              location: wisataName,
              vehicleType: widget.vehicleType ?? '');
          return;
        }

        if (isConnected == true) {
          printerHelper.printTicketParkir(
              code: widget.parkingCode ?? '',
              location: wisataName,
              vehicleType: widget.vehicleType ?? '');
        }
      });
```

