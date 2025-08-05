# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
#-dontwarn java.beans.ConstructorProperties
#-dontwarn java.beans.Transient
#-dontwarn javax.annotation.Nullable
#-dontwarn org.conscrypt.Conscrypt
#-dontwarn org.conscrypt.OpenSSLProvider
#-dontwarn org.w3c.dom.bootstrap.DOMImplementationRegistry
# -keep class com.hiennv.flutter_callkit_incoming.** { *; }
#


# Razorpay rules
-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}
-optimizations !method/inlining/
-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# Suppress warnings
-dontwarn java.beans.ConstructorProperties
-dontwarn java.beans.Transient
-dontwarn javax.annotation.Nullable
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.OpenSSLProvider
-dontwarn org.w3c.dom.bootstrap.DOMImplementationRegistry

# Keep CallKitIncoming plugin classes
-keep class com.hiennv.flutter_callkit_incoming.** { *; }

# Keep Flutter DartExecutor messenger
-keep class io.flutter.embedding.engine.dart.DartExecutor$DefaultBinaryMessenger { *; }

# Keep Flutter BinaryMessenger handler
-keep class io.flutter.plugin.common.BinaryMessenger$BinaryMessageHandler { *; }

# Keep all Flutter classes
-keep class io.flutter.** { *; }

# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep Flutter background service classes
-keep class com.ekasetiawans.flutter_background_service.** { *; }

# Keep all app classes
-keep class com.attachchat.app.** { *; }

# Keep all Flutter activities
-keep class * extends io.flutter.embedding.android.FluttefrActivity
-keep class * extends io.flutter.embedding.android.FlutterFragmentActivity

-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.** { *; }

# Keep all annotations
-keepattributes *Annotation*
-keepattributes InnerClasses


