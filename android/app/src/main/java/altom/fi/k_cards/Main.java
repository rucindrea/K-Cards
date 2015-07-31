package altom.fi.k_cards;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.text.TextPaint;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import java.util.prefs.PreferenceChangeEvent;


public class Main extends Activity implements View.OnClickListener {
    private static final String TAG = "RuKCards";
    TextView nameTextView;
    TextView colorLabelTextView;
    Button addNameButton;
    Button changeColorButton;
    Button infoButton;
    Button butonel;

    int greenColor;
    int blueColor;
    int redColor;
    int yellowColor;

    float textViewWidth;
    Paint paint;
    String text = "";
    float size = 0;

    public SharedPreferences app_preferences;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        nameTextView = (TextView) findViewById(R.id.nameTextView);
        addNameButton = (Button) findViewById(R.id.add_name_button);
        addNameButton.setOnClickListener(this);
        changeColorButton = (Button) findViewById(R.id.changeColorButton);
        changeColorButton.setOnClickListener(this);
        colorLabelTextView = (TextView) findViewById(R.id.colorLabelTextView);
        infoButton = (Button) findViewById(R.id.infoButton);
        infoButton.setOnClickListener(this);
        greenColor = Color.parseColor("#389209");
        blueColor = Color.parseColor("#005FC8");
        redColor = Color.parseColor("#FF0000");
        yellowColor = Color.parseColor("#EDE30C");

        //for text resize purposes
        textViewWidth = nameTextView.getWidth();
        paint = new Paint(Paint.ANTI_ALIAS_FLAG);

        app_preferences = PreferenceManager.getDefaultSharedPreferences(this);

        text = app_preferences.getString("name", "");
        nameTextView.setText(text);
        size = app_preferences.getFloat("size", 100);
        nameTextView.setTextSize(size);


    }


    @Override
    public void onClick(View v) {
        if (v.getId() == R.id.add_name_button) {
            AlertDialog.Builder alert = new AlertDialog.Builder(this);

            alert.setTitle("Add Your Name");
            alert.setMessage("Add your name or your assigned number.");

            final EditText input = new EditText(this);
            alert.setView(input);
            input.setText(text);
            input.selectAll();

            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);



            alert.setPositiveButton("Add", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    text = input.getText().toString().toUpperCase();
                    nameTextView.setText(text);

                    getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

                    textViewWidth = nameTextView.getWidth();
                    size = calibrateTextSize(paint, text, 0, 150, textViewWidth);
                    nameTextView.setTextSize(size);

                    SharedPreferences.Editor editor = app_preferences.edit();
                    editor.putString("name", text);
                    editor.putFloat("size", size);
                    editor.commit();


                }
            });

            alert.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {

                    getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
                    // Canceled.
                }
            });

            alert.show();
        }
        if (v.getId() == R.id.changeColorButton) {
            View backgroundView = findViewById(R.id.name_content);

            if (colorLabelTextView.getText().toString().contains("Green")) {
                backgroundView.setBackgroundColor(yellowColor);
                colorLabelTextView.setTextColor(Color.BLACK);
                addNameButton.setTextColor(Color.BLACK);
                nameTextView.setTextColor(Color.BLACK);
                infoButton.setTextColor(Color.BLACK);
                colorLabelTextView.setText("Yellow - Same Thread");
            } else if (colorLabelTextView.getText().toString().contains("Yellow")) {
                backgroundView.setBackgroundColor(redColor);
                colorLabelTextView.setTextColor(Color.WHITE);
                addNameButton.setTextColor(Color.WHITE);
                nameTextView.setTextColor(Color.WHITE);
                infoButton.setTextColor(Color.WHITE);
                colorLabelTextView.setText("Red - I MUST SPEAK RIGHT NOW!");
            } else if (colorLabelTextView.getText().toString().contains("Red")) {
                backgroundView.setBackgroundColor(blueColor);
                colorLabelTextView.setText("Blue - Rat hole/going nowhere");
            } else if (colorLabelTextView.getText().toString().contains("Blue")) {
                backgroundView.setBackgroundColor(greenColor);
                colorLabelTextView.setText("Green - New Thread");
            } else {
                backgroundView.setBackgroundColor(greenColor);
                colorLabelTextView.setText("Green - New Thread");
            }
        }

        if (v.getId() == R.id.infoButton) {
            AlertDialog.Builder alert = new AlertDialog.Builder(this);

            alert.setTitle("Info about the K-Cards");
            alert.setMessage("About K-Cards"
                    + System.getProperty("line.separator")
                    + "K-Cards are used for facilitating discussions and keeping track of discussion threads. They were first used by a group of software testers as part of their peer-conference facilitation at events like WTSTs (Workshop on Teaching Software Testing) and WOC (Workshop on Open Certification). The initial concept was developed and used by Paul Holland, his wife Karen and Scott Barber."
                    + System.getProperty("line.separator")
                    + System.getProperty("line.separator")
                    + "The facilitator of a discussion keeps track of discussion threads/topics and who wants to (still) talk about them using color cards that the participants show."
                    + System.getProperty("line.separator")
                    + "Here are all the color and their meaning:"
                    + System.getProperty("line.separator")
                    + "·   Green: Please place me on the new thread list"
                    + System.getProperty("line.separator")
                    + "·   Yellow: Please place me on the same thread list"
                    + System.getProperty("line.separator")
                    + "·   Red (or pink): Oooh, oooh, I must speak now (or important admin issue: e.g.: I can’t hear)"
                    + System.getProperty("line.separator")
                    + "·   Blue (or purple): I feel this discussion is becoming (or has become) a rat hole. – This one is not used at larger conferences."
                    + System.getProperty("line.separator")
                    + "For a full account of the history of K-Cards, here is Paul Holland's post about it: http://testingthoughts.com/blog/26"
                    + System.getProperty("line.separator")
                    + System.getProperty("line.separator"));
            alert.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    //OK.
                }
            });
            alert.show();
        }
    }

    public static float calibrateTextSize(Paint paint, String text, float min, float max, float boxWidth) {
        float size = (Math.max(Math.min((boxWidth / paint.measureText(text) * 4), max), min));
        System.out.println("size " + size);
        System.out.println("text " + paint.measureText(text));
        return size;
    }
}
