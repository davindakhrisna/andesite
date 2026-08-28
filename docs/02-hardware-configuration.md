# ⚙️ Hardware Configuration

> [!NOTE]
> Flint abstracts CPU microcode and GPU drivers into a centralized `var` option matrix in each host's `default.nix`.

---

## 🖥️ Configuration Matrix

In `hosts/<hostname>/default.nix`:

```nix
var = {
  cpu = "intel";           # "intel" | "amd" | null
  gpu = "nvidia";          # "nvidia" | "amd" | "intel" | null
  nvidia.mode = "desktop";  # "desktop" | "offload" | "sync"

  # Optional for hybrid laptop PRIME:
  # nvidia.intelBusId  = "PCI:0:2:0";
  # nvidia.nvidiaBusId = "PCI:1:0:0";
};
```

---

## 🎛️ Hardware Presets

### 1. CPU Configuration

| CPU Type | Option | Enabled Subsystems |
| :--- | :--- | :--- |
| **Intel** | `cpu = "intel";` | Microcode updates (`hardware.cpu.intel.updateMicrocode`), thermal daemon (`services.thermald`) |
| **AMD** | `cpu = "amd";` | Microcode updates (`hardware.cpu.amd.updateMicrocode`) |

---

### 2. GPU Configuration

| GPU Setup | Configuration | Details |
| :--- | :--- | :--- |
| **Nvidia Desktop** | `gpu = "nvidia";`<br>`nvidia.mode = "desktop";` | Dedicated GPU mode, modesetting, `nvidia-vaapi-driver` for HW video decoding, power management. |
| **Nvidia Hybrid (On-Demand)** | `gpu = "nvidia";`<br>`nvidia.mode = "offload";` | Powers down Nvidia GPU when idle. Run GPU-bound apps via `nvidia-offload <app>`. |
| **Nvidia Hybrid (Always-On)** | `gpu = "nvidia";`<br>`nvidia.mode = "sync";` | Keeps Nvidia GPU active full-time for maximum framerate stability. |
| **AMD Radeon** | `gpu = "amd";` | Kernel `amdgpu` driver with Vulkan/RADV, VA-API (`vaapiVdpau`), and VDPAU. |
| **Intel Iris / Arc** | `gpu = "intel";` | Intel media driver stack and VA-API hardware decoding. |

---

## 🔍 Laptop PRIME Setup

> [!TIP]
> **Find Your PCI Bus IDs:**
> Run `lspci | grep -E "VGA|3D"` in your terminal:
> ```bash
> 00:02.0 VGA compatible controller: Intel Corporation ...  -> "PCI:0:2:0"
> 01:00.0 3D controller: NVIDIA Corporation ...             -> "PCI:1:0:0"
> ```

> [!IMPORTANT]
> For hybrid laptops, ensure `intelBusId` and `nvidiaBusId` match the format `PCI:X:Y:Z` (e.g. `00:02.0` becomes `PCI:0:2:0`).
