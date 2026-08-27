//@ pragma UseQApplication
//@ pragma Env QT_QPA_PLATFORMTHEME=gtk3
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import Quickshell
import QtQuick
import "bar"
import "osd"

Scope {
  id: root

  Bar {
    theme: Theme
  }

  OSD {
    theme: Theme
  }
}