#! /bin/bash
# Prompt user for sudo password
echo "Please enter your sudo password:"
sudo -v

# prompts user for sudo privelages and then installs dependencies
if [ $? -eq 0 ]; then
	export DEBIAN_FRONTEND = noninteractive

	# Installs dependencies on apt
	sudo apt install -y shc git ffmpeg libwebrtc-audio-processing1 python3 pip

	# Download and run OLLAMA installation script
	curl -fsSL https://ollama.com/install.sh | sh

	# Create directory for the project
	git clone https://github.com/straydog-1212/nassieAI.git /tmp/nassieAI
	sudo mv /tmp/nassieAI /usr/local/
	cd /usr/local/nassieAI

	# Set up virtual environment for Python
	python -m venv ~/.nassieAI

	# Activate the virtual environment
	source ~/.nassieAI/bin/activate

	# Install dependencies using pip
	pip install tts
	pip install -U openai-whisper


	# Exits sudo
	sudo -k
else
    echo "Authentication failed. Exiting."
    exit 1
fi

