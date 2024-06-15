import { ItemNarrow } from "./item.js";
import { ButtonLabel } from "./button-label.js";

export const Wallpaper = () => ItemNarrow([ButtonLabel(
  "",
  {
    onClicked: (self, event) => {
      // Get the coordinates of the button
      const [_, x, y] = self.translate_coordinates(self.get_toplevel(), 0, 0);
    },
  },
)]);
