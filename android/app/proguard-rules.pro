# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.gms.common.internal.safeparcel.** { *; }
-keep class com.google.android.gms.ads.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Google Play Core
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.**

# Hive (Flutter Hive, not Apache Hive)
-keep class io.flutter.plugins.hive.** { *; }
-keep class hive.** { *; }
-keep class org.hivedb.** { *; }
-keep class com.hivedb.** { *; }
-keep class targetly.data.models.** { *; }
-keep class targetly.data.models.**$ { *; }
-keep class targetly.data.models.**$Adapter { *; }
-dontwarn io.flutter.plugins.hive.**
-dontwarn hive.**

# BLoC
-keep class io.flutter_bloc.** { *; }
-keep class bloc.** { *; }
-keep class equatable.** { *; }
-dontwarn io.flutter_bloc.**
-dontwarn bloc.**

# Lottie
-keep class com.airbnb.lottie.** { *; }

# General rules
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep class * extends java.util.ListResourceBundle { protected Object[][] getContents(); }
-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable { public static final *** NULL; }
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable { static final long serialVersionUID; private static final java.io.ObjectStreamField[] serialPersistentFields; private void writeObject(java.io.ObjectOutputStream); private void readObject(java.io.ObjectInputStream); java.lang.Object writeReplace(); java.lang.Object readResolve(); }
