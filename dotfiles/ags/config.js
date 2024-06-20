import { Workspaces } from "./components/workspaces.js";
import { Clock } from "./components/clock.js";
import { Title } from "./components/title.js";
import { Audio } from "./components/audio.js";
import { Wallpaper } from "./components/wallpaper.js";
import { ItemNarrow } from "./components/item.js";
import { ButtonLabel } from "./components/button-label.js";

const Left = () => Widget.Box({
  spacing: 8,
  children: [
    ItemNarrow([
      ButtonLabel("󰅟"),
    ]),
    Title(),
  ],
});

const Center = () => Widget.Box({
  children: [
    Workspaces(),
  ],
});

const Right = () => Widget.Box({
  hpack: "end",
  spacing: 8,
  children: [
    ...Audio(),
    Clock(),
    Wallpaper(),
  ],
});

const Bar = (monitor = 0) => Widget.Window({
  monitor,
  name: `bar-${monitor}`,
  class_name: "bar",
  anchor: ["top", "left", "right"],
  // Bottom margin will be made automatically by Hyprland
  margins: [ 6, 6, 0, 6 ],
  exclusivity: "exclusive",
  child: Widget.CenterBox({
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),
  }),
});

const css_file_path = `${App.configDir}/style.css`;
App.config({
  windows: [Bar()],
  style: css_file_path,
});

Utils.monitorFile(
    css_file_path,
    function() {
        App.applyCss(css_file_path);
    },
)
