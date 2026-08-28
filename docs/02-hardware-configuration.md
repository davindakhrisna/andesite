# ⚙️ Hardware Configuration

> [!NOTE]
> Flint abstracts CPU microcode and GPU drivers into a clean `var` option matrix in your host's `default.nix`.

---

## 🖥️ Configuration Matrix

In your `hosts/<hostname>/default.nix`:

```nix
var = {
  cpu = "intel";          # "intel" | "amd" | null
  gpu = "nvidia";         # "nvidia" | "amd" | "intel" | null
  nvidia.mode = "desktop"; # "desktop" | "offload" | "sync"
  # nvidia.intelBusId = "PCI:0:2:0";  # Required for laptop PRIME
  # nvidia.nvidiaBusId = "PCI:1:0:0"; # Required for laptop PRIME
};
```

---

## 🎛️ Option Presets

### 1. CPU Presets
* **`cpu = "intel";`**: Enables `updateMicrocode` and `thermald` daemon.
* **`cpu = "amd";`**: Enables AMD CPU microcode updates.

### 2. GPU Presets

| GPU Setup | Configuration | Description |
| :--- | :--- | :--- |
| **Nvidia Desktop** | `gpu = "nvidia"; nvidia.mode = "desktop";` | Dedicated GPU, Wayland hardware acceleration, and power management. |
| **Nvidia Hybrid Laptop (On-Demand)** | `gpu = "nvidia"; nvidia.mode = "offload";` | Powers down Nvidia GPU when idle; run apps via `nvidia-offload <app>`. |
| **Nvidia Hybrid Laptop (Always On)** | `gpu = "nvidia"; nvidia.mode = "sync";` | Always routes display through Nvidia GPU for max performance. |
| **AMD Radeon GPU** | `gpu = "amd";` | Enables `amdgpu` driver and Vulkan/RADV acceleration. |
| **Intel Arc / iGPU** | `gpu = "intel";` | Enables Intel media drivers and VA-API hardware acceleration. |

---

> [!TIP]
> **Finding Laptop PCI Bus IDs:**
> Run `lspci | grep -E "VGA|3D"` to find your bus IDs:
> ```
> 00:02.0 VGA compatible controller: Intel Corporation ... -> "PCI:0:2:0"
> 01:00.0 3D controller: NVIDIA Corporation ...            -> "PCI:1:0:0"
> ```
