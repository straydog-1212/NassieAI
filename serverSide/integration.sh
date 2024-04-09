#! bin/bash/

whisper  --language en clip_0002.ogg > friendtyler.txt
# for language use "none" to do language detection
# use the flag --threads to specify thread count of cpu to be used for whisper

# cleans up whisper file to get rid of the time stamps
sed -i 's/\[[0-9:.]* --> [0-9:.]*\]//g' speech.txt

# ollama reads file output by whisper and uses it to do whatever process was required
ollama run <modelname> "<prompt>" > ollamaoutputtext.txt

#text to speech reads ollamas file  and outputs an audio file
tts --text "$(cat ollamaoutput.txt)"
