#include <alpr.h>
#include <jni.h>
#include <string>
#include <android/log.h>

/********************************************
 * Function prototypes.
 ********************************************/
extern "C"
{
JNIEXPORT jboolean JNICALL Java_com_example_idfalpr_anpr_init(JNIEnv* env, jclass javaclass, jstring configFilePath, jstring runtimeDataDir);
JNIEXPORT jstring JNICALL Java_com_example_idfalpr_anpr_detect(JNIEnv* env, jclass javaclass, jstring filePath);
}

/********************************************
 * Globals
 ********************************************/
alpr::Alpr* pRecognizer = NULL;


JNIEXPORT jboolean JNICALL Java_com_example_idfalpr_anpr_init(JNIEnv* env, jclass javaclass, jstring configFilePath, jstring runtimeDataDir)
{
	__android_log_print(ANDROID_LOG_DEBUG, "NDK", "ndk start initializing\n");
	jboolean isCopy = false;

	// Get the paths from the java code.
	std::string szConfigFilePath = env->GetStringUTFChars(configFilePath, &isCopy);
	std::string szRuntimeDataDir = env->GetStringUTFChars(runtimeDataDir, &isCopy);

	// Initialize the Alpr recognizer object.
	pRecognizer = new alpr::Alpr("eu", szConfigFilePath, szRuntimeDataDir);

	jboolean fIsLoaded = pRecognizer->isLoaded();
	__android_log_print(ANDROID_LOG_DEBUG, "NDK", "ndk done initializing, IsLoaded = %s\n", pRecognizer->isLoaded() ? "true" : "false");
	return fIsLoaded;
}

JNIEXPORT jstring JNICALL Java_com_example_idfalpr_anpr_detect(JNIEnv* env, jclass javaclass, jstring filePath)
{
	__android_log_print(ANDROID_LOG_DEBUG, "NDK", "Start of ndk\n");

	jboolean isCopy = false;

	const char* szFilePath = env->GetStringUTFChars(filePath, &isCopy);

	if (szFilePath == NULL)
	{
		return env->NewStringUTF("GOT NULL!");
	}

	if (pRecognizer->isLoaded() == false)
	{
		return env->NewStringUTF("not loaded!");
	}

	alpr::AlprResults results = pRecognizer->recognize(szFilePath);
	__android_log_print(ANDROID_LOG_DEBUG, "NDK", "End of ndk\n");

	if (results.plates.size() == 0)
	{
		return env->NewStringUTF("No plates found");
	}

	return env->NewStringUTF((*results.plates.begin()).bestPlate.characters.c_str());
}
