#!/bin/bash

# Get the required Node.js version from package.json
REQUIRED_VERSION=$(node -p "require('$(dirname "$0")/../package.json').engines.node")
# Get the Node.js version from .nvmrc if it exists
if [ -f "$(dirname "$0")/../.nvmrc" ]; then
  NVMRC_VERSION=$(cat "$(dirname "$0")/../.nvmrc")
  # Remove 'v' prefix if present
  NVMRC_VERSION=${NVMRC_VERSION//v/}
fi

# Get current Node.js version
CURRENT_VERSION=$(node --version)
# Remove 'v' prefix from versions for comparison
REQUIRED_VERSION_CLEAN=${REQUIRED_VERSION//v/}
CURRENT_VERSION_CLEAN=${CURRENT_VERSION//v/}

if [ "$CURRENT_VERSION_CLEAN" != "$REQUIRED_VERSION_CLEAN" ]; then
  echo -e "\n\nℹ️  Required Node.js version: \033[32mv$REQUIRED_VERSION_CLEAN\033[0m"
  echo -e "ℹ️  Current Node.js version:  \033[31mv$CURRENT_VERSION_CLEAN\033[0m"
  echo -e "ℹ️  Attempting to install node version from .nvmrc file...\n\n"
  if [ "$NVMRC_VERSION" != "$REQUIRED_VERSION_CLEAN" ]; then
    echo -e "❌ .nvmrc version does not match required version (v$REQUIRED_VERSION_CLEAN). Please make sure .nvmrc version matches the package.json engine version.\n\n"
    exit 1
  fi

  # Try nvm install first
  if command -v nvm >/dev/null 2>&1; then
    echo -e "ℹ️  nvm found, installing Node.js version from .nvmrc..."
    nvm install
    echo -e "✅ Node.js v$NVMRC_VERSION installed from .nvmrc through nvm"
  # If nvm fails, try mise
  elif command -v mise >/dev/null 2>&1; then
    echo -e "ℹ️  mise found, installing Node.js version from .nvmrc..."
    mise i    # Verify after mise install, as `.nvmrc` version might be out of sync with package.json engine version
    echo -e "✅ Node.js v$NVMRC_VERSION installed from .nvmrc through mise"
  # If both fail, show error message
  else
      echo -e "\n\n❌\n❌\n❌\033[1m\033[31m  Error: Node.js version mismatch\033[0m\n❌\n❌"
      echo -e "❌  Required version: \033[32mv$REQUIRED_VERSION_CLEAN\033[0m"
      echo -e "❌  Current version:  \033[31mv$CURRENT_VERSION_CLEAN\033[0m"
      echo -e "❌\n❌\n❌\n\n"
      exit 1
  fi
elif [ "$REQUIRED_VERSION_CLEAN" != "$NVMRC_VERSION" ]; then
  echo -e "\033[33m🟠 .nvmrc version does not match required version (v$REQUIRED_VERSION_CLEAN). Please make sure .nvmrc version matches the package.json engine version.\033[0m\n\n"
  exit 1
fi
