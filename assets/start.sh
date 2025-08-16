#!/bin/sh

# Set Wine environment variables
export WINEPREFIX=/root/.wine
export WINEARCH=win64
export DISPLAY=:0

# Initialize Wine if not already done
if [ ! -d "$WINEPREFIX" ]; then
    echo "Initializing Wine..."
    winecfg
    wineboot --init
fi

# Wait for X server to be ready
sleep 5

# Configure Wine for better compatibility
winecfg /v win10

# Start MetaTrader in background
echo "Starting MetaTrader 5..."
wine /root/Metatrader/terminal64.exe /portable &