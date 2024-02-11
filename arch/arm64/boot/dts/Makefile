# SPDX-License-Identifier: GPL-2.0
dtb-y += exynos/exynos9610.dtb

dtbo-$(CONFIG_DTBO_M21) += \
      samsung/exynos9611-m21_swa_open_06.dtbo \
      samsung/exynos9611-m21_swa_open_00.dtbo

dtbo-$(CONFIG_DTBO_M31) += \
      samsung/exynos9611-m31_eur_open_00.dts \
      samsung/exynos9611-m31_eur_open_01.dts

targets += dtbs
DTB_LIST  := $(dtb-y) $(dtbo-y)
always    := $(DTB_LIST)

dtbs: $(addprefix $(obj)/, $(DTB_LIST))

clean-files := *.dtb*
