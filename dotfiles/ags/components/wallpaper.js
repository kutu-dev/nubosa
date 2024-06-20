import { ItemNarrow } from "./item.js";
import { ButtonLabel } from "./button-label.js";

export const Wallpaper = () => ItemNarrow([ButtonLabel(
  "",
  {
    onPrimaryClick: (self, event) => {
      const coords = event.get_root_coords()
      Utils.exec(`sh -c "swww img $(cumulus wallpaper get) -t grow --transition-pos ${coords[1]},${1080-coords[2]}"`)
    },
  },
)]);
