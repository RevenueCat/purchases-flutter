-dontwarn com.amazon.**
-keep class com.amazon.** {*;}
-keepattributes *Annotation*
-keep class androidx.lifecycle.DefaultLifecycleObserver

# The org.xmlpull package is part of the Android framework, so the classes are always available.
# However, some apps add it to their classpath, either explicitly or transitively. When
# this happens, it becomes susceptible to be shrunk. The following rule avoids that.
-keep class org.xmlpull.v1.** { *; }
