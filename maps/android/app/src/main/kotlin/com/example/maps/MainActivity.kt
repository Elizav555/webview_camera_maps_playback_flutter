package com.example.maps

import android.os.Bundle
import android.os.PersistableBundle
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        MapKitFactory.setApiKey(API_KEY);
        super.onCreate(savedInstanceState, persistentState)
    }
}
