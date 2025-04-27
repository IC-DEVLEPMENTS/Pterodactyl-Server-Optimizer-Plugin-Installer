# Pterodactyl-Server-Optimizer-Plugin-Installer
A powerful script for automating the optimization and plugin installation process for Pterodactyl game servers. It removes outdated configurations, installs essential performance-boosting plugins, and generates new optimized configuration files for Minecraft servers. Ensures smooth and high-performance operation on both existing and new servers.

# Benefits:

**Optimized Performance: Automatically installs essential plugins like ClearLag, Chunky, and EntityTrackerFixer to improve server performance and reduce lag.**

## Custom Configurations: Generates optimized server.properties, spigot.yml, bukkit.yml, and paper-world.yml configurations to improve server stability and world handling.

## Easy Installation: Simple one-step setup to install all plugins and configurations, both for existing and new servers.

## Automatic Updates: Ensures that new Pterodactyl servers are automatically set up with the best configuration and essential plugins.

## No More Manual Tweaks: Removes the need for manual server optimization, letting you focus on managing your game server.

## World Optimization: Automatically removes old and inefficient world configuration files, replacing them with newly optimized versions for chunk loading, entity handling, and more.

## Scalable for Multiple Servers: Easily deployable across multiple Pterodactyl nodes, making it perfect for large server farms or dedicated hosting.

## Cron Job for Auto Setup: Includes a cron job that ensures new servers are always set up with optimized settings without any manual intervention.

***Example of Script Output:
[INFO] Installing Minecraft server optimization plugins for Pterodactyl Wings...
[INFO] Plugins downloaded successfully.
[INFO] Installing plugins into all existing servers...
[INFO] Generating optimized server.properties, spigot.yml, bukkit.yml, and paper-world.yml...
[INFO] All servers optimized, configurations replaced, and template created!
[INFO] Cron job set up for new server configurations.
[INFO] Done!**

# How to Use:
**One - click to install it**
```bash <(curl -s https://raw.githubusercontent.com/IC-DEVLEPMENTS/Pterodactyl-Server-Optimizer-Plugin-Installer/refs/heads/main/install.sh)```
Run the script on your Pterodactyl node.

Automatically optimize and install plugins across all your Minecraft servers.

New servers will be automatically configured with the optimal setup.
