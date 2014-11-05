package com.example.idfalpr;

public class anpr
{
	static
	{
		System.loadLibrary("lept");
		System.loadLibrary("tess");
		System.loadLibrary("opencv_java");
		System.loadLibrary("IDFALPR");
	}
	
	public static native boolean init(String configFilePath, String runtimeDataDir);
	public static native String detect(String filePath);
}
