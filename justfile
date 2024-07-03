import "justfiles/misc.just"
import "justfiles/valhalla.just"
import "justfiles/nirvana.just"

# Default recipe of the justfile
default: help

hostname := `hostname`

# Regenerate the system and user configurations
switch:
  just switch-system
  just switch-home

# Regenerate the system configurations
switch-system:
  just switch-system-{{hostname}}
  
# Regenerate the user configurations
switch-home:
  just switch-home-{{hostname}}
  mkdir -p $HOME/mounts/luminosa
