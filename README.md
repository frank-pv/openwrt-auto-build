# OpenWrt Auto Build

这是一个通过 GitHub Actions 自动编译 ImmortalWrt 固件的仓库，当前配置用于 `rax-3000me`。

## 快速使用

1. 打开仓库的 **Actions** 页面。
2. 在左侧选择 **Build OpenWrt for rax-3000me**。
3. 点击 **Run workflow**，`model` 保持为 `rax-3000me`，然后确认运行。
4. 等待构建完成。构建成功后，打开仓库的 **Releases** 页面下载固件。

工作流会自动完成以下操作：

- 使用 ImmortalWrt 的 `openwrt-25.12` 分支作为源码。
- 更新并安装 feeds 和额外软件包。
- 应用型号专用的 `.config` 配置。
- 编译固件并将 `bin/targets` 下的固件文件上传到 Release。
- 仅保留最近 2 个 Release。

## 目录结构

```text
.
├── .github/workflows/rax-3000me.yml  # rax-3000me 构建工作流
└── model/
    └── rax-3000me/
        ├── .config                    # ImmortalWrt 编译配置
        ├── custom.sh                  # feeds 和第三方软件包定制脚本
        └── Makefile                   # 自定义 my-config 软件包
```

## 当前定制内容

`custom.sh` 会在编译前执行以下定制：

- 加入 PassWall 2、PassWall 依赖包和 Argon 主题。
- 替换 SmartDNS、FRP 和 DDNS-Go 相关源码。
- 调整 DDNS-Go 服务使用的运行用户。

这些步骤需要访问 GitHub。第三方仓库使用浅克隆，构建时会以远程仓库当前内容为准，因此同一配置不一定能够得到完全相同的构建结果。

## 添加或修改机型

1. 在 `model/` 下创建新的型号目录，例如 `model/example-device/`。
2. 在目录中放入 `.config`、`custom.sh` 和 `Makefile`。其中 `custom.sh` 和 `Makefile` 可以按需调整。
3. 复制并修改 `.github/workflows/rax-3000me.yml`，使工作流的名称和默认 `model` 与新目录一致。
4. 提交并推送后，在对应工作流中手动运行，并确认 `model` 输入值与目录名完全一致。

`.config` 应由 ImmortalWrt 的配置流程生成或维护，修改后建议先运行一次 `make defconfig`，确认配置没有被自动删改。

## 本地编译

工作流会自动下载源码；如需本地复现，可使用与工作流一致的源码和分支：

```bash
git clone --depth=1 --single-branch -b openwrt-25.12 \
  https://github.com/immortalwrt/immortalwrt.git openwrt
cd openwrt

chmod +x ../model/rax-3000me/custom.sh
../model/rax-3000me/custom.sh
cp ../model/rax-3000me/Makefile package/dev/my-config/Makefile
./scripts/feeds update -a
./scripts/feeds install -a
cp ../model/rax-3000me/.config .config
make defconfig
make download -j"$(nproc)"
make -j"$(nproc)"
```

编译产物位于 `openwrt/bin/targets/`，其中 `packages/` 目录下的文件不是最终固件镜像。

## 注意事项

- 刷写前请确认设备型号、硬件版本和固件格式完全匹配，并提前备份配置。
- 刷机可能导致设备变砖、数据丢失或失去保修，请自行承担风险。
- 首次构建和更新第三方 feeds 可能耗时较长，并需要较大的磁盘空间。
- 工作流需要仓库的 Actions 权限以及写入 Release 的权限。