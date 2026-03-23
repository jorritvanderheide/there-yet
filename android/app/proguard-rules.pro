# Geolocator includes a FusedLocationClient that references Google Play
# Services classes. This app uses forceLocationManager (no GMS), so these
# classes are never loaded at runtime. Tell R8 to ignore them.
-dontwarn com.google.android.gms.**
