#!/bin/bash

# Create directory for the project
mkdir -p ~/nassieAI
cd ~/nassieAI

# Download and run OLLAMA installation script
curl -fsSL https://ollama.com/install.sh | sh

# Set up virtual environment for Python
python -m venv ~/githubApps/PersonalProjects/pythonVirtualEnvironment

# Activate the virtual environment
source ~/githubApps/PersonalProjects/pythonVirtualEnvironment/bin/activate

# Install dependencies using pip
pip install tts 
pip install -U openai-whisper 

