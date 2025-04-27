#!/bin/bash

# Made By IC Development

if [ "$EUID" -ne 0 ]
then
  echo "Please run as root."
  exit
fi

echo "Installing Minecraft server optimization plugins for Pterodactyl Wings..."

# Pterodactyl Wings volumes directory
VOLUMES_DIR="/var/lib/pterodactyl/volumes"

# Temporary folder to download plugins first
TEMP_PLUGINS_DIR="/tmp/mc-optimize-plugins"

# Create temporary plugin folder
mkdir -p "$TEMP_PLUGINS_DIR"

# Download optimization plugins
echo "Downloading optimization plugins..."

curl -L -o "$TEMP_PLUGINS_DIR/ClearLag.jar" https://dev.bukkit.org/projects/clearlagg/files/latest
curl -L -o "$TEMP_PLUGINS_DIR/FarmLimiter.jar" https://hangar.papermc.io/api/v1/projects/ryder/FarmLimiter/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/Spark.jar" https://hangar.papermc.io/api/v1/projects/lucko/spark/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/EntityTrackerFixer.jar" https://github.com/youyouangel/EntityTrackerFixer/releases/latest/download/EntityTrackerFixer.jar
curl -L -o "$TEMP_PLUGINS_DIR/FAWE.jar" https://ci.athion.net/job/FastAsyncWorldEdit/lastSuccessfulBuild/artifact/worldedit-bukkit/build/libs/FastAsyncWorldEdit-bukkit.jar
curl -L -o "$TEMP_PLUGINS_DIR/Chunky.jar" https://hangar.papermc.io/api/v1/projects/pop4959/Chunky/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/AntiRedstoneLag.jar" https://hangar.papermc.io/api/v1/projects/niyuki/AntiRedstoneLag/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/VillagerOptimiser.jar" https://hangar.papermc.io/api/v1/projects/angeschossen/VillagerOptimiser/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/PetBlocks.jar" https://hangar.papermc.io/api/v1/projects/shynixn/PetBlocks/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/ChunkSpawnerLimiter.jar" https://hangar.papermc.io/api/v1/projects/agentenderman/ChunkSpawnerLimiter/versions/latest/PAPER/download
curl -L -o "$TEMP_PLUGINS_DIR/ServerBooster.jar" https://hangar.papermc.io/api/v1/projects/OmegaSeason/ServerBooster/versions/latest/PAPER/download

echo "Plugins downloaded successfully."

# Install into all existing servers under Wings
echo "Installing plugins into all existing servers..."

for server in "$VOLUMES_DIR"/*/server/*
do
  if [ -d "$server/plugins" ]; then
    echo "Installing plugins in $server..."
    cp "$TEMP_PLUGINS_DIR"/*.jar "$server/plugins/"
    chmod -R 777 "$server/plugins/"
  fi

  # Remove old config files (if they exist)
  echo "Removing old configuration files in $server..."
  rm -f "$server/server.properties"
  rm -f "$server/spigot.yml"
  rm -f "$server/bukkit.yml"
  rm -f "$server/world/paper-world.yml"  # Remove old paper-world.yml

  # Generate new, optimized server.properties
  echo "Generating optimized server.properties for $server..."
  cat > "$server/server.properties" <<EOF
# Optimized Minecraft server.properties
max-players=50
view-distance=6
spawn-protection=0
allow-nether=true
level-type=DEFAULT
motd=Optimized Minecraft Server
enable-command-block=true
max-tick-time=60000
enable-query=true
EOF

  # Generate new, optimized spigot.yml
  echo "Generating optimized spigot.yml for $server..."
  cat > "$server/spigot.yml" <<EOF
# Optimized spigot.yml for better performance
world-settings:
  default:
    entity-activation-range:
      animals: 16
      monsters: 24
      misc: 8
    mob-spawn-range: 4
    tick-inactive-villagers: false
    save-structure-info: false
  advanced:
    netty-threads: 4
    use-compression: true
  settings:
    save-user-cache-on-stop: false
EOF

  # Generate new, optimized bukkit.yml
  echo "Generating optimized bukkit.yml for $server..."
  cat > "$server/bukkit.yml" <<EOF
# Optimized bukkit.yml for better performance
settings:
  allow-end: true
  prevent-proxy-connections: false
  world-loads:
    - world
    - world_nether
    - world_the_end
  ticks-per:
    animal-spawns: 400
    monster-spawns: 1
    autosave: 6000
  entity-activation-range:
    animals: 16
    monsters: 24
    misc: 8
EOF

  # Generate new, optimized paper-world.yml
  echo "Generating optimized paper-world.yml for $server..."
  cat > "$server/world/paper-world.yml" <<EOF
# Optimized paper-world.yml for world performance
world-settings:
  default:
    enabled: true
    type: NORMAL
    seed: 0
    generator: default
    environment: NORMAL
    generator-settings: ''
    generator-options: ''
    custom-settings: false
    cleanup-interval: 600
    chunk-loader: true
    nether: true
    end: true
    save-on-unload: true
    fixed-world-size: 5000
    keep-chunks-loaded: true
    per-chunk-spawn: false
    disable-chunk-unloading: false
EOF
done

# Setup a default template for future servers
echo "Setting up template for future servers..."

DEFAULT_TEMPLATE="$VOLUMES_DIR/.default-plugins"

mkdir -p "$DEFAULT_TEMPLATE/plugins"
cp "$TEMP_PLUGINS_DIR"/*.jar "$DEFAULT_TEMPLATE/plugins/"
chmod -R 777 "$DEFAULT_TEMPLATE/plugins/"

# Create a template for server config files
echo "Setting up template for server configuration files..."
DEFAULT_CONFIG_TEMPLATE="$VOLUMES_DIR/.default-configs"

mkdir -p "$DEFAULT_CONFIG_TEMPLATE"

# Generate the default config files (server.properties, spigot.yml, bukkit.yml)
cat > "$DEFAULT_CONFIG_TEMPLATE/server.properties" <<EOF
# Optimized Minecraft server.properties
max-players=50
view-distance=6
spawn-protection=0
allow-nether=true
level-type=DEFAULT
motd=Optimized Minecraft Server
enable-command-block=true
max-tick-time=60000
enable-query=true
EOF

cat > "$DEFAULT_CONFIG_TEMPLATE/spigot.yml" <<EOF
# Optimized spigot.yml for better performance
world-settings:
  default:
    entity-activation-range:
      animals: 16
      monsters: 24
      misc: 8
    mob-spawn-range: 4
    tick-inactive-villagers: false
    save-structure-info: false
  advanced:
    netty-threads: 4
    use-compression: true
  settings:
    save-user-cache-on-stop: false
EOF

cat > "$DEFAULT_CONFIG_TEMPLATE/bukkit.yml" <<EOF
# Optimized bukkit.yml for better performance
settings:
  allow-end: true
  prevent-proxy-connections: false
  world-loads:
    - world
    - world_nether
    - world_the_end
  ticks-per:
    animal-spawns: 400
    monster-spawns: 1
    autosave: 6000
  entity-activation-range:
    animals: 16
    monsters: 24
    misc: 8
EOF

cat > "$DEFAULT_CONFIG_TEMPLATE/paper-world.yml" <<EOF
# Optimized paper-world.yml for world performance
world-settings:
  default:
    enabled: true
    type: NORMAL
    seed: 0
    generator: default
    environment: NORMAL
    generator-settings: ''
    generator-options: ''
    custom-settings: false
    cleanup-interval: 600
    chunk-loader: true
    nether: true
    end: true
    save-on-unload: true
    fixed-world-size: 5000
    keep-chunks-loaded: true
    per-chunk-spawn: false
    disable-chunk-unloading: false
EOF

echo "All servers optimized, configurations replaced, and template created!"

# Clean up temp folder
rm -rf "$TEMP_PLUGINS_DIR"

# Set up a cron job to install plugins and configurations for new servers
echo "Setting up cron job to install plugins 
and configurations for new servers..."

CRON_JOB="@reboot root /bin/bash /path/to/this/script.sh"

# Add cron job to root's crontab if not already added
(crontab -l | grep -v "$CRON_JOB"; echo "$CRON_JOB") | crontab -

echo "Done!"

# Made By IC Development
