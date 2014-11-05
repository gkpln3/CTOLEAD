package com.example.idfalpr;

import java.io.File;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Environment;
import android.os.FileObserver;
import android.provider.MediaStore;
import android.view.MenuInflater;
import android.view.View;
import android.view.Window;

import com.google.android.glass.content.Intents;
import com.google.android.glass.view.WindowUtils;
import com.google.android.glass.widget.CardBuilder;
import com.google.android.glass.widget.CardScrollView;

public class MainActivity extends Activity
{
	private static final int TAKE_PICTURE_REQUEST = 1;

	/** {@link CardScrollView} to use as the main content view. */
	private CardBuilder m_CardBuilder;

	private boolean m_fIsProcessing;
	
	private boolean m_fIsInitialized;

	@Override
	protected void onCreate(Bundle bundle)
	{
		// Initialize the activity to support voice commands.
		getWindow().requestFeature(WindowUtils.FEATURE_VOICE_COMMANDS);
		getWindow().requestFeature(Window.FEATURE_OPTIONS_PANEL);
		super.onCreate(bundle);

		m_CardBuilder = new CardBuilder(this, CardBuilder.Layout.TEXT);
		m_CardBuilder.setText("Initializing");
		setContentView(m_CardBuilder.getView());
		
		/********************************************
		 * Start initializing.
		 ********************************************/
		// Initialize on a different thread to enable gui updates on the gui thread.
//		new Thread(new Runnable()
//		{
//			@Override
//			public void run()
//			{
				// Initialize the license plate recognition class.
				String runtimeDataDir = Environment.getExternalStorageDirectory() + File.separator + "DCIM/runtimedata";
				m_fIsInitialized = anpr.init(runtimeDataDir + File.separator + "openalpr.conf", runtimeDataDir);

//				MainActivity.this.runOnUiThread(new Runnable()
//				{
//					@Override
//					public void run()
//					{
						m_CardBuilder.setText("Ready");
						setContentView(m_CardBuilder.getView());
						m_fIsInitialized = true;
//					}
//				});
//			}
//		}).start();

		/*********************************
		 * Init done.
		 *********************************/
	}
	
	// When the menu (voice commands menu) is first appearing, create it.
	@Override
	public boolean onCreatePanelMenu(int featureId, android.view.Menu menu) 
	{
		// Build the voice commands menu.
		if (featureId == WindowUtils.FEATURE_VOICE_COMMANDS || featureId == Window.FEATURE_OPTIONS_PANEL)
		{
			getMenuInflater().inflate(R.menu.main, menu);
			return true;
		}
		
		return super.onCreatePanelMenu(featureId, menu);
	};
	
	@Override
	public boolean onPreparePanel(int featureId, View view, android.view.Menu menu) 
	{
		if (featureId == WindowUtils.FEATURE_VOICE_COMMANDS || featureId == Window.FEATURE_OPTIONS_PANEL)
		{
			// Enable voice commands if not processing and is initialized.
			return (!m_fIsProcessing) && m_fIsInitialized;
		}
		
		return super.onPreparePanel(featureId, view, menu);
	};
	
	// When the user selects one of the voice commands.
	@Override
	public boolean onMenuItemSelected(int featureId, android.view.MenuItem item) 
	{
		if (featureId == WindowUtils.FEATURE_VOICE_COMMANDS || featureId == Window.FEATURE_OPTIONS_PANEL)
		{
			switch (item.getItemId())
			{
			// When the user says "identify".
			case R.id.identify_menu_item:
			{
				// Start a thread to process the picture in. 
				takePicture();
				break;
			}
			default:
				return true;
			}
		}
		
		return super.onMenuItemSelected(featureId, item);
	};
	
	@Override
	protected void onResume()
	{
		super.onResume();
	}

	@Override
	protected void onPause()
	{
		super.onPause();
	}

	
	private void takePicture()
	{
		Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
		startActivityForResult(intent, TAKE_PICTURE_REQUEST);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		if (requestCode == TAKE_PICTURE_REQUEST && resultCode == RESULT_OK)
		{
			m_CardBuilder.setText("Processing...");
			setContentView(m_CardBuilder.getView());

			String thumbnailPath = data
					.getStringExtra(Intents.EXTRA_THUMBNAIL_FILE_PATH);
			String picturePath = data
					.getStringExtra(Intents.EXTRA_PICTURE_FILE_PATH);

			processPictureWhenReady(picturePath);
			
			// Show a picture thumbnail for the meanwhile.
//			mCardBuilder.addImage(BitmapFactory.decodeFile(thumbnailPath));
		}

		super.onActivityResult(requestCode, resultCode, data);
	}

	private void processPictureWhenReady(final String picturePath)
	{
		final File pictureFile = new File(picturePath);

		if (pictureFile.exists())
		{
			// The picture is ready; process it.

			// Process the picture data and try to find the license plate.
			String licensePlateNumber = anpr.detect(pictureFile.getPath());
			
			// Delete the picture from the memroy.
			pictureFile.delete();
			
			m_CardBuilder.setText(licensePlateNumber);
			setContentView(m_CardBuilder.getView());
			m_fIsProcessing = false;
		} else
		{
			// The file does not exist yet. Before starting the file observer,
			// you
			// can update your UI to let the user know that the application is
			// waiting for the picture (for example, by displaying the thumbnail
			// image and a progress indicator).

			final File parentDirectory = pictureFile.getParentFile();
			FileObserver observer = new FileObserver(parentDirectory.getPath(),
					FileObserver.CLOSE_WRITE | FileObserver.MOVED_TO)
			{
				// Protect against additional pending events after CLOSE_WRITE
				// or MOVED_TO is handled.
				private boolean isFileWritten;

				@Override
				public void onEvent(int event, String path)
				{
					if (!isFileWritten)
					{
						// For safety, make sure that the file that was created
						// in
						// the directory is actually the one that we're
						// expecting.
						File affectedFile = new File(parentDirectory, path);
						isFileWritten = affectedFile.equals(pictureFile);

						if (isFileWritten)
						{
							stopWatching();

							// Now that the file is ready, recursively call
							// processPictureWhenReady again (on the UI thread).
							runOnUiThread(new Runnable()
							{
								@Override
								public void run()
								{
									processPictureWhenReady(picturePath);
								}
							});
						}
					}
				}
			};
			observer.startWatching();
		}
	}
}