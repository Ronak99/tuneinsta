flutter build appbundle --release 
echo "✅ built the bundle"

apksigner sign --ks upload-keystore.jks --min-sdk-version 21 --out build/app/outputs/bundle/release/app-release-signed.aab build/app/outputs/bundle/release/app-release.aab

open build/app/outputs/bundle/release/

# to patch
 shorebird patch --platforms=android --release-version=1.0.1+2
