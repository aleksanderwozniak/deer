package com.example.tasking;

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.app.Activity
import android.graphics.Color
import android.os.Build
import android.view.View
import android.view.WindowManager

class MainActivity(): FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    
    makeStatusBarTransparent()
  }
}

fun android.app.Activity.setWindowFlag(activity: android.app.Activity, bits: Int, on: Boolean) {
  val win = activity.window
  val winParams = win.attributes
  if (on) {
    winParams.flags = winParams.flags or bits
  } else {
    winParams.flags = winParams.flags and bits.inv()
  }
  win.attributes = winParams
}

// https://github.com/mikepenz/MaterialDrawer/issues/254#issuecomment-95685807
fun FlutterActivity.makeStatusBarTransparent() {
  window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN

  if (Build.VERSION.SDK_INT in 19..22) {
    setWindowFlag(this, WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS, true)
  } else if(Build.VERSION.SDK_INT >= 23) {
    //val view = getFlutterView()
    //var flags = view.systemUiVisibility
    //flags = flags or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
    //view.systemUiVisibility = flags

    setWindowFlag(this, WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS, false)
    window.statusBarColor = Color.TRANSPARENT
  }
}