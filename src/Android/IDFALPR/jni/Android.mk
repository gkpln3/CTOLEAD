LOCAL_PATH := $(call my-dir)
LIB_PATH := $(LOCAL_PATH)/../libs/armeabi-v7a


NDK_DEBUG=1


include $(CLEAR_VARS)

LOCAL_MODULE := leptonica
LOCAL_SRC_FILES := liblept.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := tesseract
LOCAL_SRC_FILES := libtess.so
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

#LOCAL_MODULE := simpleini
#LOCAL_SRC_FILES := libsimpleini.a
#include $(PREBUILT_STATIC_LIBRARY)

#include $(CLEAR_VARS)

#LOCAL_MODULE := support
#LOCAL_SRC_FILES := libsupport.a
#include $(PREBUILT_STATIC_LIBRARY)

#include $(CLEAR_VARS)

#LOCAL_MODULE := openalpr
#LOCAL_SRC_FILES := libopenalpr-static.a
#include $(PREBUILT_STATIC_LIBRARY)

#include $(CLEAR_VARS)

OPENCV_INSTALL_MODULES:=on
OPENCV_CAMERA_MODULES:=off

include ../../OpenCV-2.4.10-android-sdk/sdk/native/jni/OpenCV.mk

LOCAL_MODULE := IDFALPR
LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/*.c*) $(wildcard $(LOCAL_PATH)/detection/*.c*) $(wildcard $(LOCAL_PATH)/edges/*.c*) $(wildcard $(LOCAL_PATH)/segmentation/*.c*) $(wildcard $(LOCAL_PATH)/simpleini/*.c*) $(wildcard $(LOCAL_PATH)/support/*.c*) $(wildcard $(LOCAL_PATH)/textdetection/*.c*)
LOCAL_SHARED_LIBRARIES += tesseract leptonica
LOCAL_STATIC_LIBRARIES += openalpr support simpleini

LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)