flutter build appbundle --release 
echo "✅ built the bundle"

apksigner sign --ks upload-keystore.jks --min-sdk-version 21 --out build/app/outputs/bundle/release/app-release-signed.aab build/app/outputs/bundle/release/app-release.aab

open build/app/outputs/bundle/release/

# create shorebird release
shorebird release android --build-name=1.0.4 --build-number=4
shorebird release ios --build-name=1.0.4 --build-number=4

# to patch
shorebird patch --platforms=android --release-version=1.0.1+2
