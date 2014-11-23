LOCAL_PATH := $(call my-dir)
LIB_PATH := $(LOCAL_PATH)/../libs/armeabi-v7a

include $(CLEAR_VARS)

OPENCV_INSTALL_MODULES:=on
OPENCV_CAMERA_MODULES:=off

include ../../OpenCV-2.4.10-android-sdk/sdk/native/jni/OpenCV.mk

LOCAL_MODULE := libface
LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/*.c*)

LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)