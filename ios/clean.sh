rm -rf Pods Podfile.lock
pod deintegrate
cd ..
flutter clean
puro flutter pub get
cd ios
pod repo update
pod install
cd ..
puro flutter run