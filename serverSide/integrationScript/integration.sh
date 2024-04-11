#! /bin/bash

json_file = ./serverSideConfig.json
modelname=$(jq -r '.ttsModelName' $json_file)
lang=$(jq -r '.language' $json_file)
threads=$(jq -r '.threads' $json_file)
vocodername=$(jq -r '.vocoderModelName' $json_file)
outpath=$(jq -r '.outputPath' $json_file)


whisper  --language "$lang" webrtcOuPut.ogg > whisperOutPut.txt
# for language use "none" to do language detection
# use the flag --threads to specify thread count of cpu to be used for whisper

# cleans up whisper file to get rid of the time stamps
sed -i 's/\[[0-9:.]* --> [0-9:.]*\]//g' whisperOutPut.txt

# ollama reads file output by whisper and uses it to do whatever process was required
ollama run "$modelname" "$cat whisperOutPut.txt" > ollamaOutPut.txt

#text to speech reads ollamas file  and outputs an audio file
tts --text "$(cat ollamaoutput.txt)" \
    --model_name "$modelname" \
    --vocoder_name "$vocodername" \
    --out_path "$outpath"

