//    package com.attachchat.app
//
//    import io.flutter.embedding.android.FlutterActivity
//
//    class MainActivity : FlutterActivity(){
//
//        @override
//        fun onNewIntent(intent: Intent) {
//            super.onNewIntent(intent)
//            setIntent(intent)
//            handleCustomCallIntent(intent)
//        }
//
//        private fun handleCustomCallIntent(intent: Intent) {
//            if (intent.action == "com.attachchat.app.ACTION_SHOW_CALL_SCREEN") {
//                // This will open the Flutter app with a specific route or logic
//                // You can pass extras too
//            }
//        }
//
//    }





//
//    package com.attachchat.app
//
//    import android.content.Intent
//    import android.os.Bundle
//    import io.flutter.embedding.android.FlutterActivity
//
//    class MainActivity: FlutterActivity() {
//
//        override fun onNewIntent(intent: Intent) {
//            super.onNewIntent(intent)
//            setIntent(intent)
//            handleCustomCallIntent(intent)
//        }
//
//        private fun handleCustomCallIntent(intent: Intent) {
//            if (intent.action == "com.attachchat.app.ACTION_SHOW_CALL_SCREEN") {
//                // You can handle routing here if needed
//                println("📲 App launched via ACTION_SHOW_CALL_SCREEN intent")
//            }
//        }
//
//
//
//    }





package com.attachchat.app

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

class
MainActivity: FlutterActivity() {

    private val CHANNEL = "com.attachchat.app/call"
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel?.setMethodCallHandler { call, result ->
            // Handle Flutter calls here
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleCustomCallIntent(intent)
    }

    private fun handleCustomCallIntent(intent: Intent) {
        if (intent.action == "com.attachchat.app.ACTION_SHOW_CALL_SCREEN") {

            println("📲 App launched via ACTION_SHOW_CALL_SCREEN intent with data: ${intent.extras?.keySet()}")

            val data = mapOf("callId" to "12345", "callerName" to "Alice")

            // Use the initialized methodChannel safely
            methodChannel?.invokeMethod("showCallScreen", data)
        }
    }
}



