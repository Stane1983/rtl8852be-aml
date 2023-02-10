ifeq ($(CONFIG_PLATFORM_RTK16XXB), y)
# CONFIG_RTKM - n/m/y for not support / standalone / built-in
CONFIG_RTKM = m
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_RADIO_WORK
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DRTK_1619B_PLATFORM

# CONFIG_RTW_ANDROID - 0: no Android, 4/5/6/7/8/9/10/11 : Android version
CONFIG_RTW_ANDROID = $(PLTFM_VER)

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -gt 0; echo $$?), 0)
EXTRA_CFLAGS += -DCONFIG_RTW_ANDROID=$(CONFIG_RTW_ANDROID)
endif

ifeq ($(shell test $(CONFIG_RTW_ANDROID) -ge 11; echo $$?), 0)
EXTRA_CFLAGS += -DCONFIG_IFACE_NUMBER=3
#EXTRA_CFLAGS += -DCONFIG_SEL_P2P_IFACE=1
EXTRA_CFLAGS += -DRTW_USE_CFG80211_REPORT_PROBE_REQ
endif

ARCH ?= arm

CROSS_COMPILE := $(CROSS)
KSRC := $(LINUX_KERNEL_PATH)

ifeq ($(CONFIG_PCI_HCI), y)
EXTRA_CFLAGS += -DCONFIG_PLATFORM_OPS
_PLATFORM_FILES := platform/platform_linux_pc_pci.o
OBJS += $(_PLATFORM_FILES)
# Core Config
CONFIG_MSG_NUM = 128
EXTRA_CFLAGS += -DCONFIG_MSG_NUM=$(CONFIG_MSG_NUM)
EXTRA_CFLAGS += -DCONFIG_RXBUF_NUM_1024
EXTRA_CFLAGS += -DCONFIG_TX_SKB_ORPHAN
CORE_NR_XMITFRAME = 512
EXTRA_CFLAGS += -DCORE_NR_XMITFRAME=$(CORE_NR_XMITFRAME)
CORE_MAX_TX_RING_NUM = 512
EXTRA_CFLAGS += -DCORE_MAX_TX_RING_NUM=$(CORE_MAX_TX_RING_NUM)
# PHL Config
EXTRA_CFLAGS += -DRTW_WKARD_98D_RXTAG
CORE_MAX_PHL_RING_ENTRY_NUM = 512
EXTRA_CFLAGS += -DCORE_MAX_PHL_RING_ENTRY_NUM=$(CORE_MAX_PHL_RING_ENTRY_NUM)
CORE_MAX_PHL_RING_RX_PKT_NUM = 1024
EXTRA_CFLAGS += -DCORE_MAX_PHL_RING_RX_PKT_NUM=$(CORE_MAX_PHL_RING_RX_PKT_NUM)
endif

endif
