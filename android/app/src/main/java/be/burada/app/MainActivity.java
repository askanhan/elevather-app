package be.visiontree.burada.app;

import android.os.Bundle;
import android.webkit.WebView;

import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowCompat;
import androidx.core.view.WindowInsetsCompat;

import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    WindowCompat.setDecorFitsSystemWindows(getWindow(), false);

    final WebView webView = getBridge().getWebView();
    final float density = getResources().getDisplayMetrics().density;

    ViewCompat.setOnApplyWindowInsetsListener(webView, (v, insets) -> {
      Insets status = insets.getInsets(WindowInsetsCompat.Type.statusBars());
      Insets nav = insets.getInsets(WindowInsetsCompat.Type.navigationBars());

      // physical px -> CSS px (dp gibi)
      float topCss = status.top / density;
      float bottomCss = nav.bottom / density;

      String js =
        "document.documentElement.style.setProperty('--android-status-bar','" + topCss + "px');" +
        "document.documentElement.style.setProperty('--android-nav-bar','" + bottomCss + "px');";

      webView.post(() -> webView.evaluateJavascript(js, null));
      return insets;
    });

    webView.requestApplyInsets();
  }
}