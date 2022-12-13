#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/fleur

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Assert
TARGET_OTA_ASSERT_DEVICE := fleur,miel

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := fleur
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 440

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := sea_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/sea

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(BOARD_PREBUILT_DTBIMAGE_DIR)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := true
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 2147483648
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 2147483648
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 67108864

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_EXT4_SHARE_DUP_BLOCKS := false
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_METADATA_PARTITION := true

# Partitions Out
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

# Platform
TARGET_BOARD_PLATFORM := mt6781
BOARD_HAS_MTK_HARDWARE := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6781

# SPL
VENDOR_SECURITY_PATCH := 2023-09-01

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/touchpanel/double_tap_enable"

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# SELinux
include device/mediatek/sepolicy_vndr/SEPolicy.mk

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := product system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 3

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE += $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/framework_compatibility_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml
	
# VNDK
BOARD_VNDK_VERSION := current

# Inherit the proprietary files
include vendor/xiaomi/fleur/BoardConfigVendor.mk
