package cordova.plugin;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.util.Log;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Swish extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("echo")) {
            callbackContext.success("Echo: " + data.getString(0));
            return true;
        } else if(action.equals("isSwishInstalled")) {

            //Swish package name is “se.bankgirot.swish”

            boolean isSwishInstalled = false;
            try {
                cordova.getActivity().getPackageManager().getApplicationInfo("se.bankgirot.swish", 0);
                isSwishInstalled = true;
            } catch(PackageManager.NameNotFoundException e) {
            }

            callbackContext.success(isSwishInstalled ? "true" : "false");

        } else if(action.equals("beginPayment")) {

            Activity activity = cordova.getActivity();
            String token = data.getString(0);
            int identifier = activity.getResources().getIdentifier( "SWISH_URL_SUFFIX", "string", activity.getPackageName());
            String callBackUrl = "swish" + activity.getString(identifier);

            if ( token == null || token.length() == 0 || callBackUrl == null || callBackUrl.length() == 0 || activity == null) {
                callbackContext.success("false");
            }

            Uri scheme = Uri.parse("swish://paymentrequest?token="+token+"&callbackurl="+callBackUrl);
            Intent intent = new Intent(Intent.ACTION_VIEW, scheme);
            intent.setPackage("se.bankgirot.swish");
            boolean started=true;
            try {
                activity.startActivityForResult(intent, 15);
            } catch (Exception e){
                started=false;
            }

            callbackContext.success(started ? "true" : "false");
            return true;
        }

        return false;
    }
}