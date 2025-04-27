#!/bin/bash

if [ "$EUID" -ne 0 ]
then
  echo "Please run as root."
  exit
fi

echo "Installing Minecraft server optimization plugins on all servers..."

# Where all servers are stored
VOLUMES_DIR="/var/lib/pterodactyl/volumes"

# Temp folder for downloading plugins first
TEMP_PLUGINS_DIR="/tmp/mc-optimize-plugins"

# Create temp plugin download folder
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

# Install into all existing servers
echo "Installing plugins into all existing servers..."

for server in "$VOLUMES_DIR"/*
do
  if [ -d "$server/plugins" ]; then
    echo "Installing plugins in $server..."
    cp "$TEMP_PLUGINS_DIR"/*.jar "$server/plugins/"
    chmod -R 777 "$server/plugins/"
  fi
done

# Setup a default template for future servers
echo "Setting up template for future servers..."

DEFAULT_TEMPLATE="$VOLUMES_DIR/.default-plugins"

mkdir -p "$DEFAULT_TEMPLATE/plugins"
cp "$TEMP_PLUGINS_DIR"/*.jar "$DEFAULT_TEMPLATE/plugins/"
chmod -R 777 "$DEFAULT_TEMPLATE/plugins/"

echo "All servers optimized and template created!"

# Clean up temp folder
rm -rf "$TEMP_PLUGINS_DIR"

echo "Done!"
